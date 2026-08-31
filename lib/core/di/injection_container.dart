import 'package:gbv/core/audio/audio_service.dart';
import 'package:gbv/core/storage/encrypted_storage_service.dart';
import 'package:gbv/core/storage/secure_storage_service.dart';
import 'package:get_it/get_it.dart';

/// Global service locator instance.
final GetIt sl = GetIt.instance;

/// Registers all app-level dependencies.
Future<void> initDependencies() async {
  // ── Core Services ───────────────────────────────────────────────────

  // Secure storage (Android Keystore / iOS Keychain).
  sl
    ..registerLazySingleton<SecureStorageService>(SecureStorageService.new)
    // AES-256 encrypted storage for screening data.
    ..registerLazySingleton<EncryptedStorageService>(
      () => EncryptedStorageService(secureStorage: sl<SecureStorageService>()),
    )
    // Audio playback service for narration.
    ..registerLazySingleton<AudioService>(AudioService.new);

  // ── Feature-level dependencies ──────────────────────────────────────
  // Register BLoCs, repositories, and use cases here as features are built.
}
