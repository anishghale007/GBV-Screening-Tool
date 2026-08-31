import 'package:equatable/equatable.dart';

/// Failure classes used with `dartz` Either pattern.
///
/// These represent domain-level failures that BLoC/Cubit can
/// react to and display appropriate UI feedback.
abstract class Failure extends Equatable {
  const Failure(this.message);
  final String message;

  @override
  List<Object?> get props => [message];
}

/// Failure when reading/writing to local storage.
class StorageFailure extends Failure {
  const StorageFailure(super.message);
}

/// Failure when encryption or decryption operations fail.
class EncryptionFailure extends Failure {
  const EncryptionFailure(super.message);
}

/// Failure when audio playback cannot start or completes with error.
class AudioFailure extends Failure {
  const AudioFailure(super.message);
}

/// Generic unexpected failure.
class UnexpectedFailure extends Failure {
  const UnexpectedFailure(super.message);
}
