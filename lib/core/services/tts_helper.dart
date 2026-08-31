import 'dart:async';
import 'dart:io' show Platform;

import 'package:flutter/foundation.dart';
import 'package:flutter_tts/flutter_tts.dart';

/// State of TTS playback.
enum TtsState {
  playing,
  stopped,
  paused,
  continued,
}

/// Helper service for Text-To-Speech (TTS) functionality.
///
/// Wraps [FlutterTts] to provide easy playback, language configuration,
/// event streams, and volume/rate controls for views and controllers.
class TtsHelper {
  TtsHelper({FlutterTts? tts}) : _tts = tts ?? FlutterTts() {
    _initTts();
  }

  final FlutterTts _tts;
  TtsState _state = TtsState.stopped;

  final _stateController = StreamController<TtsState>.broadcast();

  /// Stream of current TTS state changes.
  Stream<TtsState> get stateStream => _stateController.stream;

  /// Current state of the TTS engine.
  TtsState get state => _state;

  /// Whether TTS is currently speaking text.
  bool get isPlaying => _state == TtsState.playing;

  /// Whether TTS is currently paused.
  bool get isPaused => _state == TtsState.paused;

  /// Whether TTS is stopped.
  bool get isStopped => _state == TtsState.stopped;

  void _initTts() {
    _tts
      ..setStartHandler(() {
        _state = TtsState.playing;
        _stateController.add(_state);
      })
      ..setCompletionHandler(() {
        _state = TtsState.stopped;
        _stateController.add(_state);
      })
      ..setCancelHandler(() {
        _state = TtsState.stopped;
        _stateController.add(_state);
      })
      ..setPauseHandler(() {
        _state = TtsState.paused;
        _stateController.add(_state);
      })
      ..setContinueHandler(() {
        _state = TtsState.continued;
        _stateController.add(_state);
      })
      ..setErrorHandler((dynamic message) {
        _state = TtsState.stopped;
        _stateController.add(_state);
        debugPrint('TTS Error: $message');
      });

    // Default configuration for natural speech
    setSpeechRate(0.5);
    setVolume(1);
    setPitch(1);

    if (!kIsWeb && Platform.isIOS) {
      _tts
        ..setSharedInstance(true)
        ..setIosAudioCategory(
          IosTextToSpeechAudioCategory.ambientSolo,
          [
            IosTextToSpeechAudioCategoryOptions.allowBluetooth,
            IosTextToSpeechAudioCategoryOptions.allowBluetoothA2DP,
          ],
        );
    }
  }

  /// Speaks the provided [text].
  ///
  /// Optionally supply a [languageCode] (e.g., 'ne-NP', 'en-US').
  Future<void> speak(String text, {String? languageCode}) async {
    if (text.trim().isEmpty) return;

    if (languageCode != null) {
      await setLanguage(languageCode);
    }

    await _tts.speak(text);
  }

  /// Stops current speech output.
  Future<void> stop() async {
    await _tts.stop();
    _state = TtsState.stopped;
    _stateController.add(_state);
  }

  /// Pauses current speech output.
  Future<void> pause() async {
    await _tts.pause();
    _state = TtsState.paused;
    _stateController.add(_state);
  }

  /// Sets the TTS language (e.g., 'ne-NP' for Nepali, 'en-US' for English).
  Future<void> setLanguage(String languageCode) async {
    await _tts.setLanguage(languageCode);
  }

  /// Sets the speech rate (0.0 to 1.0). Default is 0.5.
  Future<void> setSpeechRate(double rate) async {
    await _tts.setSpeechRate(rate);
  }

  /// Sets the audio volume (0.0 to 1.0). Default is 1.0.
  Future<void> setVolume(double volume) async {
    await _tts.setVolume(volume);
  }

  /// Sets the pitch (0.5 to 2.0). Default is 1.0.
  Future<void> setPitch(double pitch) async {
    await _tts.setPitch(pitch);
  }

  /// Returns a list of available TTS languages on the device.
  Future<List<dynamic>> getLanguages() async {
    final languages = await _tts.getLanguages;
    if (languages is List) {
      return languages;
    }
    return [];
  }

  /// Returns true if the given [language] is supported/installed.
  Future<bool> isLanguageAvailable(String language) async {
    final available = await _tts.isLanguageAvailable(language);
    return available == 1 || available == true;
  }

  /// Disposes resources.
  Future<void> dispose() async {
    await stop();
    await _stateController.close();
  }
}
