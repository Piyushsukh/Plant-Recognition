import 'package:get/get.dart';
import 'screens/splash_screen.dart';
import 'screens/on_boarding1.dart';
import 'screens/on_boarding2.dart';
import 'screens/onboarding_screen.dart';
import 'screens/main_navigation.dart';
import 'screens/plant_detail_screen.dart';
import 'screens/care_tips_screen.dart';
import 'screens/blog_detail_screen.dart';
import 'screens/notifications_screen.dart';

final appRoutes = [
  GetPage(
    name: '/splash',
    page: () => const SplashScreen(),
    transition: Transition.fadeIn,
    transitionDuration: const Duration(milliseconds: 300),
  ),
  GetPage(
    name: '/onboarding',
    page: () => const OnboardingScreen(),
    transition: Transition.rightToLeft,
    transitionDuration: const Duration(milliseconds: 300),
  ),
  GetPage(
    name: '/onboarding1',
    page: () => const Onboarding1(),
    transition: Transition.rightToLeft,
    transitionDuration: const Duration(milliseconds: 300),
  ),
  GetPage(
    name: '/onboarding2',
    page: () => const Onboarding2(),
    transition: Transition.rightToLeft,
    transitionDuration: const Duration(milliseconds: 300),
  ),
  GetPage(
    name: '/home',
    page: () => const MainNavigation(),
    transition: Transition.fadeIn,
    transitionDuration: const Duration(milliseconds: 400),
  ),
  GetPage(
    name: '/plantDetail',
    page: () => const PlantDetailScreen(),
    transition: Transition.rightToLeft,
    transitionDuration: const Duration(milliseconds: 300),
  ),
  GetPage(
    name: '/careTips',
    page: () => const CareTipsScreen(),
    transition: Transition.rightToLeft,
    transitionDuration: const Duration(milliseconds: 300),
  ),
  GetPage(
    name: '/blogDetail',
    page: () => const BlogDetailScreen(),
    transition: Transition.rightToLeft,
    transitionDuration: const Duration(milliseconds: 300),
  ),
  GetPage(
    name: '/notifications',
    page: () => const NotificationsScreen(),
    transition: Transition.rightToLeft,
    transitionDuration: const Duration(milliseconds: 300),
  ),
];
