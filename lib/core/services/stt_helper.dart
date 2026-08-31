import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:speech_to_text/speech_recognition_error.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

/// Callback type for speech recognition results.
typedef SpeechResultCallback =
    void Function({required String recognizedWords, required bool isFinal});

/// Helper service for Speech-To-Text (STT) voice recognition.
///
/// Wraps [SpeechToText] to provide an easy-to-use interface for initializing,
/// listening for speech input, streaming recognized words, and handling errors.
class SttHelper {
  SttHelper({SpeechToText? speechToText})
    : _speech = speechToText ?? SpeechToText();

  final SpeechToText _speech;

  bool _isInitialized = false;

  final _recognizedTextController = StreamController<String>.broadcast();
  final _listeningStatusController = StreamController<bool>.broadcast();
  final _errorController = StreamController<String>.broadcast();

  /// Stream of recognized speech text in real-time.
  Stream<String> get recognizedTextStream => _recognizedTextController.stream;

  /// Stream of listening status changes (`true` when listening).
  Stream<bool> get isListeningStream => _listeningStatusController.stream;

  /// Stream of error messages.
  Stream<String> get errorStream => _errorController.stream;

  /// Whether speech recognition is currently initialized.
  bool get isInitialized => _isInitialized;

  /// Whether the microphone is currently active and listening.
  bool get isListening => _speech.isListening;

  /// Whether speech recognition is available on the device.
  bool get isAvailable => _speech.isAvailable;

  /// Initializes the speech recognition engine.
  ///
  /// Must be called before [startListening].
  /// Returns `true` if initialization succeeded and permission was granted.
  Future<bool> initialize({
    void Function(String status)? onStatus,
    void Function(SpeechRecognitionError error)? onError,
  }) async {
    if (_isInitialized) return true;

    try {
      return _isInitialized = await _speech.initialize(
        onStatus: (status) {
          final listening = _speech.isListening;
          _listeningStatusController.add(listening);
          onStatus?.call(status);
        },
        onError: (errorNotification) {
          _errorController.add(errorNotification.errorMsg);
          _listeningStatusController.add(false);
          onError?.call(errorNotification);
          debugPrint('STT Error: ${errorNotification.errorMsg}');
        },
      );
    } catch (e) {
      debugPrint('STT Initialization error: $e');
      _errorController.add(e.toString());
      return false;
    }
  }

  /// Starts listening to voice input from the microphone.
  ///
  /// - [onResult]: Callback with recognized text and final status.
  /// - [localeId]: Optional locale (e.g. 'ne_NP', 'en_US').
  /// - [listenFor]: Maximum total duration to listen.
  /// - [pauseFor]: Silence duration before auto-stopping.
  Future<bool> startListening({
    SpeechResultCallback? onResult,
    String? localeId,
    Duration? listenFor,
    Duration? pauseFor,
  }) async {
    if (!_isInitialized) {
      final initialized = await initialize();
      if (!initialized) return false;
    }

    if (_speech.isListening) {
      await stopListening();
    }

    try {
      final options = SpeechListenOptions(
        localeId: localeId,
        listenFor: listenFor ?? const Duration(seconds: 30),
        pauseFor: pauseFor ?? const Duration(seconds: 3),
        cancelOnError: true,
      );

      await _speech.listen(
        onResult: (SpeechRecognitionResult result) {
          _recognizedTextController.add(result.recognizedWords);
          onResult?.call(
            recognizedWords: result.recognizedWords,
            isFinal: result.finalResult,
          );
        },
        listenOptions: options,
      );
      _listeningStatusController.add(true);
      return true;
    } catch (e) {
      debugPrint('STT Listen error: $e');
      _errorController.add(e.toString());
      return false;
    }
  }

  /// Stops listening and commits final recognition result.
  Future<void> stopListening() async {
    if (_speech.isListening) {
      await _speech.stop();
      _listeningStatusController.add(false);
    }
  }

  /// Cancels listening and discards current speech buffer.
  Future<void> cancelListening() async {
    if (_speech.isListening) {
      await _speech.cancel();
      _listeningStatusController.add(false);
    }
  }

  /// Returns available locales for speech recognition.
  Future<List<LocaleName>> getLocales() async {
    if (!_isInitialized) {
      await initialize();
    }
    return _speech.locales();
  }

  /// Disposes streams and stops active listeners.
  Future<void> dispose() async {
    await stopListening();
    await _recognizedTextController.close();
    await _listeningStatusController.close();
    await _errorController.close();
  }
}
