import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../core/theme.dart';
import '../core/constants.dart';
import '../widgets/premium_card.dart';

class ExploreScreen extends StatelessWidget {
  const ExploreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Text(
                "Explore Plants",
                style: Theme.of(context).textTheme.displayMedium,
              ),
              const SizedBox(height: 8),
              Text(
                "Discover thousands of plants",
                style: Theme.of(
                  context,
                ).textTheme.bodyLarge?.copyWith(color: AppTheme.lightText),
              ),
              const SizedBox(height: 24),

              // Search Bar
              Container(
                decoration: BoxDecoration(
                  color: AppTheme.cardBackground,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: const [
                    BoxShadow(
                      color: AppTheme.shadowColor,
                      blurRadius: 8,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Search plants...',
                    prefixIcon: const Icon(
                      Icons.search,
                      color: AppTheme.lightText,
                    ),
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.all(16),
                    hintStyle: Theme.of(
                      context,
                    ).textTheme.bodyLarge?.copyWith(color: AppTheme.lightText),
                  ),
                ),
              ),
              const SizedBox(height: 32),

              // Categories
              Text(
                "Categories",
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: 16),
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 1.2,
                ),
                itemCount: AppConstants.plantCategories.length,
                itemBuilder: (context, index) {
                  final category = AppConstants.plantCategories[index];
                  return CategoryCard(
                    name: category['name']!,
                    emoji: category['icon']!,
                    onTap: () {
                      Get.snackbar(
                        'Category',
                        'Exploring ${category['name']}',
                        backgroundColor: AppTheme.primaryGreen,
                        colorText: Colors.white,
                      );
                    },
                  );
                },
              ),
              const SizedBox(height: 32),

              // Trending Plants
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Trending Plants",
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  TextButton(onPressed: () {}, child: const Text("See All")),
                ],
              ),
              const SizedBox(height: 16),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: AppConstants.mockPlants.length,
                itemBuilder: (context, index) {
                  final plant = AppConstants.mockPlants[index];
                  return Container(
                    margin: const EdgeInsets.only(bottom: 16),
                    child: PremiumCard(
                      padding: EdgeInsets.zero,
                      onTap: () {
                        Get.snackbar(
                          'Plant Info',
                          'Viewing ${plant['name']}',
                          backgroundColor: AppTheme.primaryGreen,
                          colorText: Colors.white,
                        );
                      },
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius: const BorderRadius.horizontal(
                              left: Radius.circular(20),
                            ),
                            child: Image.network(
                              plant['image'],
                              width: 80,
                              height: 80,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) =>
                                  Container(
                                    width: 80,
                                    height: 80,
                                    color: AppTheme.beige,
                                    child: const Icon(
                                      Icons.local_florist,
                                      color: AppTheme.primaryGreen,
                                    ),
                                  ),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    plant['name'],
                                    style: Theme.of(
                                      context,
                                    ).textTheme.titleMedium,
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    plant['scientificName'],
                                    style: Theme.of(
                                      context,
                                    ).textTheme.bodyMedium,
                                  ),
                                  const SizedBox(height: 8),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 8,
                                      vertical: 4,
                                    ),
                                    decoration: BoxDecoration(
                                      color: AppTheme.primaryGreen.withOpacity(
                                        0.1,
                                      ),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Text(
                                      plant['family'],
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium
                                          ?.copyWith(
                                            color: AppTheme.primaryGreen,
                                            fontWeight: FontWeight.w500,
                                          ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.all(16),
                            child: Icon(
                              Icons.arrow_forward_ios,
                              color: AppTheme.lightText,
                              size: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
