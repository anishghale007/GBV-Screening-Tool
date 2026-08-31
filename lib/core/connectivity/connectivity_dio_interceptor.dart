import 'package:dio/dio.dart';
import 'package:gbv/core/connectivity/connectivity_service.dart';
import 'package:gbv/core/error/exceptions.dart';

class ConnectivityInterceptor extends Interceptor {
  ConnectivityInterceptor(this._connectivityService);

  final ConnectivityService _connectivityService;

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (!_connectivityService.isOnline) {
      handler.reject(
        DioException(
          requestOptions: options,
          error: const NoInternetException(),
        ),
      );
      return;
    }
    super.onRequest(options, handler);
  }
}
