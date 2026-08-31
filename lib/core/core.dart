/// Core layer — shared infrastructure, constants, theme, services,
///  and utilities.
///
/// This barrel file exports everything in the core layer so features
/// can use a single import: `import 'package:gbv/core/core.dart';`
library;

export 'accessibility/accessibility_settings.dart';
export 'audio/audio_service.dart';
export 'connectivity/connectivity_dio_interceptor.dart';
export 'connectivity/connectivity_service.dart';
export 'constants/app_constants.dart';
export 'constants/asset_paths.dart';
export 'enums/app_enums.dart';
export 'error/exceptions.dart';
export 'error/failures.dart';
export 'routing/app_router.dart';
export 'routing/app_routes.dart';
export 'services/stt_helper.dart';
export 'services/tts_helper.dart';
export 'storage/encrypted_storage_service.dart';
export 'storage/secure_storage_service.dart';
export 'theme/app_colors.dart';
export 'theme/app_spacing.dart';
export 'theme/app_text_styles.dart';
export 'theme/app_theme.dart';
export 'utils/context_extensions.dart';
export 'utils/string_extensions.dart';
export 'utils/text_validator.dart';
