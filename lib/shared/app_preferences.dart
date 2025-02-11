import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:splity_z/shared/models/split_state.dart';

class AppPreferences {
  static Future<void> setAppState(SplitState state) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(
      _AppPreferencesKey.appState.key,
      JsonEncoder().convert(state.toJson()),
    );
  }

  static Future<SplitState> getAppState() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_AppPreferencesKey.appState.key) != null
        ? SplitState.fromJson(
            JsonDecoder().convert(
              prefs.getString(_AppPreferencesKey.appState.key)!,
            ),
          )
        : SplitState.initialState;
  }

  static Future<void> removeAppState() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_AppPreferencesKey.appState.key);
  }
}

enum _AppPreferencesKey {
  appState,
}

extension on _AppPreferencesKey {
  String get key {
    switch (this) {
      case _AppPreferencesKey.appState:
        return 'appState';
      default:
        throw Exception('Invalid key');
    }
  }
}
