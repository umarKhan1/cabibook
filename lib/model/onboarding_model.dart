// ignore_for_file: lines_longer_than_80_chars

import 'package:cabibook/utils/images_const.dart';

class OnboardingItem {
  OnboardingItem({
    required this.image,
    required this.title,
    required this.description,
  });
  final String image;
  final String title;
  final String description;

  static List<OnboardingItem> items = [
    OnboardingItem(
      image: ApplicationImageConst.onboarding1,
      title: 'Request Ride',
      description:
          'The fastest app to book a taxi, scooter, or a bike online near by you.',
    ),
    OnboardingItem(
      image: ApplicationImageConst.onboarding2,
      title: 'Book Driver',
      description:
          'Request a driver and booka a driver to pick you from your desired location.',
    ),
    OnboardingItem(
      image: ApplicationImageConst.onboarding3,
      title: 'Track your driver',
      description:
          'Track your driver from any location with a global mapping system',
    ),
  ];
}
