import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

final connectivityProvider = StateNotifierProvider<ConnectivityNotifier, bool>((ref) {
  return ConnectivityNotifier()..checkCurrentConnectivity();
});

class ConnectivityNotifier extends StateNotifier<bool> {
  ConnectivityNotifier() : super(true);

  final Connectivity _connectivity = Connectivity();

  void checkCurrentConnectivity() async {
    _connectivity.onConnectivityChanged.listen((result) async {
      if (result != ConnectivityResult.none) {
        // Check for actual internet access
        var previousState = state;
        var currentState = await _verifyInternetAccess();
        if (previousState != currentState) {
          state = currentState;
        }
      } else {
        state = false;
      }
    });
  }

  Future<bool> _verifyInternetAccess() async {
    try {
      final result = await http.get(Uri.parse('https://www.google.com'));
      return result.statusCode == 200;
    } catch (_) {
      return false;
    }
  }
}
