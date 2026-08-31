import 'package:audioplayers/audioplayers.dart';

/// Audio playback service for question narration and instructions.
///
/// Wraps [AudioPlayer] with simple play/pause/replay controls.
/// All audio is bundled locally (no network fetch).
class AudioService {
  AudioService({AudioPlayer? player}) : _player = player ?? AudioPlayer();

  final AudioPlayer _player;

  /// Whether audio is currently playing.
  bool get isPlaying => _player.state == PlayerState.playing;

  /// Plays an audio file from the app's bundled assets.
  ///
  /// [assetPath] should be relative to the assets directory,
  /// e.g., `audio/ne/question_1.mp3`.
  Future<void> play(String assetPath) async {
    await _player.stop();
    await _player.play(AssetSource(assetPath));
  }

  /// Pauses the currently playing audio.
  Future<void> pause() async {
    await _player.pause();
  }

  /// Resumes paused audio.
  Future<void> resume() async {
    await _player.resume();
  }

  /// Stops audio and resets to the beginning.
  Future<void> stop() async {
    await _player.stop();
  }

  /// Replays the current audio from the beginning.
  Future<void> replay(String assetPath) async {
    await _player.stop();
    await _player.play(AssetSource(assetPath));
  }

  /// Listens for audio completion events.
  Stream<void> get onComplete => _player.onPlayerComplete;

  /// Disposes the audio player when no longer needed.
  Future<void> dispose() async {
    await _player.dispose();
  }
}
