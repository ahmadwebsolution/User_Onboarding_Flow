import 'package:shared_preferences/shared_preferences.dart';
import '../constants/app_data.dart';

class PreferencesService {
  static PreferencesService? _instance;
  PreferencesService._();

  static PreferencesService get instance =>
      _instance ??= PreferencesService._();

  Future<bool> isOnboardingCompleted() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(AppData.onboardingPrefKey) ?? false;
  }

  Future<void> setOnboardingCompleted(bool completed) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(AppData.onboardingPrefKey, completed);
  }

  Future<void> resetPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(AppData.onboardingPrefKey);
  }
}
