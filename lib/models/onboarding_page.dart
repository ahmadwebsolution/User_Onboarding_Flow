import 'package:flutter/material.dart';

class OnboardingPageModel {
  final String title;
  final String description;
  final IconData? icon;
  final String? imageAsset;
  final String? badgeText;

  const OnboardingPageModel({
    required this.title,
    required this.description,
    this.icon,
    this.imageAsset,
    this.badgeText,
  });
}
