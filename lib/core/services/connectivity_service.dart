import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';

final connectivityProvider = StreamProvider<bool>((ref) {
  return ConnectivityService.isOnlineStream;
});

final isOnlineProvider = Provider<bool>((ref) {
  return ref.watch(connectivityProvider).valueOrNull ?? true;
});

class ConnectivityService {
  static final _connectivity = Connectivity();
  static final _logger = Logger();
  static final _controller = StreamController<bool>.broadcast();

  static Stream<bool> get isOnlineStream => _controller.stream;

  static bool _isOnline = true;
  static bool get isOnline => _isOnline;

  static Future<void> initialize() async {
    // Check initial state
    final result = await _connectivity.checkConnectivity();
    _isOnline = result != ConnectivityResult.none;
    _controller.add(_isOnline);

    // Listen to changes
    _connectivity.onConnectivityChanged.listen((result) {
      final wasOnline = _isOnline;
      _isOnline = result != ConnectivityResult.none;

      if (_isOnline != wasOnline) {
        _controller.add(_isOnline);
        if (_isOnline) {
          _logger.i('📶 Back online — triggering sync');
          _onReconnect();
        } else {
          _logger.w('📴 Offline — switching to cached data');
        }
      }
    });
  }

  static void _onReconnect() {
    // Trigger any pending sync operations
    // This would call SyncService.syncPending() in a real implementation
  }

  static void dispose() {
    _controller.close();
  }
}
