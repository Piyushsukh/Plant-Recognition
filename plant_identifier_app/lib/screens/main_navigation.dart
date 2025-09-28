import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/navigation_controller.dart';
import '../core/theme.dart';
import 'home_screen.dart';
import 'camera_screen.dart';
import 'explore_screen.dart';
import 'my_plants_screen.dart';
import 'blogs_screen.dart';

class MainNavigation extends StatelessWidget {
  const MainNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    final NavigationController navController = Get.find();

    final List<Widget> screens = [
      const HomeScreen(),
      const CameraScreen(),
      const ExploreScreen(),
      const MyPlantsScreen(),
      const BlogsScreen(),
    ];

    return Obx(() => Scaffold(
      body: screens[navController.currentIndex.value],
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          color: AppTheme.cardBackground,
          boxShadow: [
            BoxShadow(
              color: AppTheme.shadowColor,
              blurRadius: 10,
              offset: Offset(0, -2),
            ),
          ],
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildNavItem(
                  icon: Icons.home_outlined,
                  activeIcon: Icons.home,
                  label: 'Home',
                  index: 0,
                  navController: navController,
                ),
                _buildNavItem(
                  icon: Icons.camera_alt_outlined,
                  activeIcon: Icons.camera_alt,
                  label: 'Identify',
                  index: 1,
                  navController: navController,
                ),
                _buildNavItem(
                  icon: Icons.explore_outlined,
                  activeIcon: Icons.explore,
                  label: 'Explore',
                  index: 2,
                  navController: navController,
                ),
                _buildNavItem(
                  icon: Icons.eco_outlined,
                  activeIcon: Icons.eco,
                  label: 'My Plants',
                  index: 3,
                  navController: navController,
                ),
                _buildNavItem(
                  icon: Icons.article_outlined,
                  activeIcon: Icons.article,
                  label: 'Blogs',
                  index: 4,
                  navController: navController,
                ),
              ],
            ),
          ),
        ),
      ),
    ));
  }

  Widget _buildNavItem({
    required IconData icon,
    required IconData activeIcon,
    required String label,
    required int index,
    required NavigationController navController,
  }) {
    return Obx(() {
      final isActive = navController.currentIndex.value == index;
      return GestureDetector(
        onTap: () => navController.changeIndex(index),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: isActive ? AppTheme.primaryGreen.withOpacity(0.1) : Colors.transparent,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                isActive ? activeIcon : icon,
                color: isActive ? AppTheme.primaryGreen : AppTheme.lightText,
                size: 24,
              ),
              const SizedBox(height: 4),
              Text(
                label,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: isActive ? FontWeight.w600 : FontWeight.normal,
                  color: isActive ? AppTheme.primaryGreen : AppTheme.lightText,
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}