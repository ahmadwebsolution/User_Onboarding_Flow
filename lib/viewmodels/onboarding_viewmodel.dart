import 'package:flutter/material.dart';
import '../constants/app_data.dart';
import '../models/onboarding_page.dart';
import '../services/preferences_service.dart';

class OnboardingViewModel extends ChangeNotifier {
  final PreferencesService _preferencesService = PreferencesService.instance;
  final PageController pageController = PageController();

  final List<OnboardingPageModel> pages = AppData.onboardingPages;
  int _currentPage = 0;
  bool _isCompleting = false;

  int get currentPage => _currentPage;
  bool get isCompleting => _isCompleting;
  bool get isLastPage => _currentPage == pages.length - 1;
  int get totalPages => pages.length;

  void onPageChanged(int index) {
    _currentPage = index;
    notifyListeners();
  }

  void nextPage() {
    if (!isLastPage) {
      pageController.nextPage(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOutCubic,
      );
    }
  }

  void skip() {
    if (!isLastPage) {
      pageController.animateToPage(
        pages.length - 1,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOutCubic,
      );
    }
  }

  Future<void> completeOnboarding() async {
    _isCompleting = true;
    notifyListeners();

    await _preferencesService.setOnboardingCompleted(true);

    _isCompleting = false;
    notifyListeners();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }
}
