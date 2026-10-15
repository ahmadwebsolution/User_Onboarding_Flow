import 'package:flutter/material.dart';

import '../models/onboarding_page.dart';

class AppData {
  static const String appName = 'AmirApp';
  static const String onboardingPrefKey = 'has_completed_onboarding';

  static const List<OnboardingPageModel> onboardingPages = [
    OnboardingPageModel(
      title: 'Track Your Growth',
      description: 'Monitor your daily progress, habits, and productivity metrics with intuitive visual analytics.',
      icon: Icons.insights_rounded,
      badgeText: 'ANALYTICS',
      imageAsset: 'assets/icon/brandimg.png',
    ),
    OnboardingPageModel(
      title: 'Seamless Collaboration',
      description: 'Connect with your team in real time, share insights, and get things done faster together.',
      icon: Icons.hub_rounded,
      badgeText: 'COLLABORATE',
      imageAsset: 'assets/icon/brandimg.png',
    ),
    OnboardingPageModel(
      title: 'Fast & Secure',
      description: 'All your preferences and data are securely stored locally with lightning-fast instant access.',
      icon: Icons.shield_rounded,
      badgeText: 'SECURITY',
      imageAsset: 'assets/icon/brandimg.png',
    ),
  ];
}
