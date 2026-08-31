import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';

class ConnectivityService {
  ConnectivityService(this._connectivity);

  final Connectivity _connectivity;
  StreamSubscription<List<ConnectivityResult>>? _sub;

  bool _isOnline = true;

  bool get isOnline => _isOnline;

  Stream<bool> get onStatusChanged async* {
    yield _isOnline;
    yield* _connectivity.onConnectivityChanged.map((result) {
      final isOnline = !result.contains(ConnectivityResult.none);
      _isOnline = isOnline;
      return isOnline;
    });
  }

  Future<void> init() async {
    final result = await _connectivity.checkConnectivity();
    _isOnline = !result.contains(ConnectivityResult.none);

    // Keep status fresh even if nobody listens to onStatusChanged
    _sub ??= _connectivity.onConnectivityChanged.listen((results) {
      _isOnline = !results.contains(ConnectivityResult.none);
    });
  }

  void dispose() {
    _sub?.cancel();
    _sub = null;
  }
}
