import 'package:flutter/material.dart';
import '../services/preferences_service.dart';

class SplashViewModel extends ChangeNotifier {
  final PreferencesService _preferencesService = PreferencesService.instance;

  bool _isLoading = true;
  bool _isOnboardingCompleted = false;

  bool get isLoading => _isLoading;
  bool get isOnboardingCompleted => _isOnboardingCompleted;

  Future<bool> checkFirstLaunch({
    Duration delay = const Duration(milliseconds: 1800),
  }) async {
    _isLoading = true;
    notifyListeners();

    // Give time for branding / logo animation
    await Future.delayed(delay);

    _isOnboardingCompleted =
        await _preferencesService.isOnboardingCompleted();
    _isLoading = false;
    notifyListeners();

    return _isOnboardingCompleted;
  }
}
