import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../core/theme.dart';
import '../controllers/navigation_controller.dart';
import '../controllers/notification_controller.dart';
import '../widgets/premium_card.dart';
import '../widgets/custom_button.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final NavigationController navController = Get.find();
    final NotificationController notificationController = Get.find();

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Hello! 👋",
                          style: Theme.of(context).textTheme.headlineMedium
                              ?.copyWith(color: AppTheme.lightText),
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          "Discover Plants",
                          style: Theme.of(context).textTheme.displayMedium,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  Obx(
                    () => GestureDetector(
                      onTap: () => Get.toNamed('/notifications'),
                      child: Stack(
                        children: [
                          Container(
                            width: 48,
                            height: 48,
                            decoration: BoxDecoration(
                              color: AppTheme.primaryGreen.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: const Icon(
                              Icons.notifications_outlined,
                              color: AppTheme.primaryGreen,
                            ),
                          ),
                          if (notificationController.unreadCount.value > 0)
                            Positioned(
                              right: 0,
                              top: 0,
                              child: Container(
                                padding: const EdgeInsets.all(4),
                                decoration: const BoxDecoration(
                                  color: Colors.red,
                                  shape: BoxShape.circle,
                                ),
                                child: Text(
                                  '${notificationController.unreadCount.value}',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 32),

              // Hero Section
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [AppTheme.primaryGreen, AppTheme.softGreen],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Identify any plant\ninstantly",
                      style: Theme.of(context).textTheme.headlineLarge
                          ?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      "Just point your camera and discover",
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: Colors.white.withOpacity(0.9),
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 24),
                    FloatingActionCard(
                      icon: Icons.camera_alt,
                      onPressed: () => navController.navigateToIdentify(),
                      backgroundColor: Colors.white,
                      iconColor: AppTheme.primaryGreen,
                      size: 80,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),

              // Quick Actions
              Text(
                "Quick Actions",
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: 16),
              GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 1,
                children: [
                  _buildQuickActionCard(
                    context,
                    "My Plants",
                    Icons.eco,
                    "View your collection",
                    () => navController.navigateToMyPlants(),
                  ),
                  _buildQuickActionCard(
                    context,
                    "Explore",
                    Icons.explore,
                    "Browse plant library",
                    () => navController.navigateToExplore(),
                  ),
                  _buildQuickActionCard(
                    context,
                    "Care Tips",
                    Icons.lightbulb_outline,
                    "Learn plant care",
                    () => Get.toNamed('/careTips'),
                  ),
                  _buildQuickActionCard(
                    context,
                    "Blogs",
                    Icons.article,
                    "Read plant stories",
                    () => navController.navigateToBlogs(),
                  ),
                ],
              ),
              const SizedBox(height: 32),

              // Featured Section
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Text(
                      "Popular Plants",
                      style: Theme.of(context).textTheme.headlineMedium,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  TextButton(
                    onPressed: () => navController.navigateToExplore(),
                    child: const Text("See All"),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              SizedBox(
                height: 200,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 3,
                  itemBuilder: (context, index) {
                    final plants = [
                      {
                        'name': 'Monstera',
                        'image':
                            'https://images.unsplash.com/photo-1506905925346-21bda4d32df4?w=300',
                      },
                      {
                        'name': 'Snake Plant',
                        'image':
                            'https://images.unsplash.com/photo-1593691509543-c55fb32d8de5?w=300',
                      },
                      {
                        'name': 'Fiddle Leaf',
                        'image':
                            'https://images.unsplash.com/photo-1586093248292-4e6636ce8b97?w=300',
                      },
                    ];

                    final plantData = {
                      'id': plants[index]['name'],
                      'name': plants[index]['name'],
                      'image': plants[index]['image'],
                      'scientificName': '${plants[index]['name']} species',
                    };

                    return Container(
                      width: 140,
                      margin: EdgeInsets.only(right: index < 2 ? 16 : 0),
                      child: PlantCard(
                        plant: plantData,
                        showSaveButton: false,
                        onTap: null,
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildQuickActionCard(
    BuildContext context,
    String title,
    IconData icon,
    String subtitle,
    VoidCallback onTap,
  ) {
    return PremiumCard(
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: AppTheme.primaryGreen.withOpacity(0.1),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(icon, color: AppTheme.primaryGreen, size: 24),
          ),
          const SizedBox(height: 12),
          Text(
            title,
            style: Theme.of(context).textTheme.titleMedium,
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
          const SizedBox(height: 4),
          Text(
            subtitle,
            style: Theme.of(context).textTheme.bodyMedium,
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
