import 'package:gbv/core/error/failures.dart';

/// Custom exception classes for typed error handling.
///
/// These are thrown by service-layer code and caught / mapped to
/// [Failure] types at the repository level using `dartz` Either.

/// Thrown when secure or encrypted storage operations fail.
class StorageException implements Exception {
  const StorageException(this.message);
  final String message;

  @override
  String toString() => 'StorageException: $message';
}

/// Thrown when AES encryption or decryption fails.
class EncryptionException implements Exception {
  const EncryptionException(this.message);
  final String message;

  @override
  String toString() => 'EncryptionException: $message';
}

/// Thrown when audio playback fails.
class AudioException implements Exception {
  const AudioException(this.message);
  final String message;

  @override
  String toString() => 'AudioException: $message';
}

/// Thrown when the device has no internet connection.
class NoInternetException implements Exception {
  const NoInternetException([this.message = 'No internet connection']);
  final String message;

  @override
  String toString() => 'NoInternetException: $message';
}
