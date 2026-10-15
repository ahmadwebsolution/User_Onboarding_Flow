import 'package:flutter/material.dart';
import '../services/preferences_service.dart';

class HomeViewModel extends ChangeNotifier {
  final PreferencesService _preferencesService = PreferencesService.instance;

  bool _isResetting = false;
  bool get isResetting => _isResetting;

  Future<void> resetOnboarding() async {
    _isResetting = true;
    notifyListeners();

    await _preferencesService.resetPreferences();

    _isResetting = false;
    notifyListeners();
  }
}
