import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:gbv/core/audio/audio_service.dart';
import 'package:gbv/core/connectivity/connectivity_dio_interceptor.dart';
import 'package:gbv/core/connectivity/connectivity_service.dart';
import 'package:gbv/core/services/stt_helper.dart';
import 'package:gbv/core/services/tts_helper.dart';
import 'package:gbv/core/storage/encrypted_storage_service.dart';
import 'package:gbv/core/storage/secure_storage_service.dart';
import 'package:get_it/get_it.dart';

/// Global service locator instance.
final GetIt sl = GetIt.instance;

/// Registers all app-level dependencies.
Future<void> initDependencies() async {
  // ── Core Services ───────────────────────────────────────────────────

  // Connectivity
  sl
    ..registerLazySingleton<Connectivity>(Connectivity.new)
    ..registerLazySingleton<ConnectivityService>(
      () => ConnectivityService(sl<Connectivity>()),
    )
    ..registerLazySingleton<ConnectivityInterceptor>(
      () => ConnectivityInterceptor(sl<ConnectivityService>()),
    )
    ..registerLazySingleton<Dio>(() {
      final dio = Dio();
      dio.interceptors.add(sl<ConnectivityInterceptor>());
      return dio;
    })

    // Secure storage (Android Keystore / iOS Keychain).
    ..registerLazySingleton<SecureStorageService>(SecureStorageService.new)

    // AES-256 encrypted storage for screening data.
    ..registerLazySingleton<EncryptedStorageService>(
      () => EncryptedStorageService(secureStorage: sl<SecureStorageService>()),
    )

    // Audio playback service for narration.
    ..registerLazySingleton<AudioService>(AudioService.new)

    // Text-To-Speech (TTS) helper.
    ..registerLazySingleton<TtsHelper>(TtsHelper.new)

    // Speech-To-Text (STT) helper.
    ..registerLazySingleton<SttHelper>(SttHelper.new);

  // Initialize connectivity status check
  await sl<ConnectivityService>().init();

  // ── Feature-level dependencies ──────────────────────────────────────
  // Register BLoCs, repositories, and use cases here as features are built.
}
