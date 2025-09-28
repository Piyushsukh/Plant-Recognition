import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../core/theme.dart';
import '../controllers/plant_controller.dart';
import '../controllers/navigation_controller.dart';
import '../widgets/premium_card.dart';
import '../widgets/custom_button.dart';

class MyPlantsScreen extends StatelessWidget {
  const MyPlantsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final PlantController plantController = Get.find();

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "My Plants",
                        style: Theme.of(context).textTheme.displayMedium,
                      ),
                      Obx(
                        () => Text(
                          "${plantController.myPlants.length} plants in your collection",
                          style: Theme.of(context).textTheme.bodyLarge
                              ?.copyWith(color: AppTheme.lightText),
                        ),
                      ),
                    ],
                  ),
                  FloatingActionCard(
                    icon: Icons.add,
                    onPressed: () {
                      Get.snackbar(
                        'Add Plant',
                        'Feature coming soon!',
                        backgroundColor: AppTheme.primaryGreen,
                        colorText: Colors.white,
                      );
                    },
                    size: 48,
                  ),
                ],
              ),
              const SizedBox(height: 32),

              // Plants Grid
              Expanded(
                child: Obx(() {
                  if (plantController.myPlants.isEmpty) {
                    return _buildEmptyState(context);
                  }

                  return GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 16,
                          mainAxisSpacing: 16,
                          childAspectRatio: 0.8,
                        ),
                    itemCount: plantController.myPlants.length,
                    itemBuilder: (context, index) {
                      final plant = plantController.myPlants[index];
                      return PlantCard(
                        plant: plant,
                        onTap: () {
                          plantController.identifiedPlant.value = plant;
                          Get.toNamed('/plantDetail');
                        },
                      );
                    },
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              color: AppTheme.beige.withOpacity(0.5),
              borderRadius: BorderRadius.circular(30),
            ),
            child: const Icon(
              Icons.eco_outlined,
              size: 60,
              color: AppTheme.primaryGreen,
            ),
          ),
          const SizedBox(height: 24),
          Text(
            "No plants yet",
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          const SizedBox(height: 8),
          Text(
            "Start identifying plants to build\nyour collection",
            style: Theme.of(
              context,
            ).textTheme.bodyLarge?.copyWith(color: AppTheme.lightText),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 32),
          PremiumButton(
            text: "Identify Your First Plant",
            onPressed: () {
              final navController = Get.find<NavigationController>();
              navController.navigateToIdentify();
            },
            icon: Icons.camera_alt,
          ),
        ],
      ),
    );
  }
}
