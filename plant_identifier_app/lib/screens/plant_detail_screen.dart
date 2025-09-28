import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';
import '../core/theme.dart';
import '../controllers/plant_controller.dart';
import '../widgets/custom_button.dart';
import '../widgets/premium_card.dart';

class PlantDetailScreen extends StatelessWidget {
  const PlantDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final PlantController plantController = Get.find();

    return Scaffold(
      body: Obx(() {
        final plant = plantController.identifiedPlant.value;
        if (plant == null) {
          return const Center(child: Text('No plant data available'));
        }

        return CustomScrollView(
          slivers: [
            // App Bar with Image
            SliverAppBar(
              expandedHeight: 300,
              pinned: true,
              backgroundColor: AppTheme.primaryGreen,
              leading: Container(
                margin: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: IconButton(
                  onPressed: () => Get.back(),
                  icon: const Icon(Icons.arrow_back, color: Colors.white),
                ),
              ),
              actions: [
                Obx(() {
                  final isSaved = plantController.isPlantSaved(plant['id']);

                  return Container(
                    margin: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: GestureDetector(
                      onTap: () {
                        if (!isSaved) {
                          plantController.addPlant(plant);
                        } else {
                          plantController.removePlant(plant['id']);
                        }
                      },
                      child: AnimatedScale(
                        scale: isSaved ? 1.1 : 1.0,
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeOutBack,
                        child: Icon(
                          isSaved ? Icons.bookmark : Icons.bookmark_add,
                          color: Colors.white,
                          size: 28,
                        ),
                      ),
                    ),
                  );
                }),
              ],

              flexibleSpace: FlexibleSpaceBar(
                background: Image.network(
                  plant['image'] ?? '',
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                    color: AppTheme.beige,
                    child: const Icon(
                      Icons.local_florist,
                      size: 80,
                      color: AppTheme.primaryGreen,
                    ),
                  ),
                ),
              ),
            ),

            // Content
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Plant Name
                    Text(
                      plant['name'] ?? 'Unknown Plant',
                      style: Theme.of(context).textTheme.displayMedium,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      plant['scientificName'] ?? '',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: AppTheme.lightText,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Info Cards
                    Row(
                      children: [
                        Expanded(
                          child: _buildInfoCard(
                            context,
                            'Family',
                            plant['family'] ?? 'Unknown',
                            Icons.category,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: _buildInfoCard(
                            context,
                            'Origin',
                            plant['origin'] ?? 'Unknown',
                            Icons.public,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 32),

                    // Tabs
                    DefaultTabController(
                      length: 3,
                      child: Column(
                        children: [
                          TabBar(
                            labelColor: AppTheme.primaryGreen,
                            unselectedLabelColor: AppTheme.lightText,
                            indicatorColor: AppTheme.primaryGreen,
                            tabs: const [
                              Tab(text: 'Care Tips'),
                              FittedBox(child: Tab(text: 'Similar Plants')),
                              Tab(text: 'Gallery'),
                            ],
                          ),
                          const SizedBox(height: 24),
                          SizedBox(
                            height: 300,
                            child: TabBarView(
                              children: [
                                _buildCareTab(context, plant['care']),
                                _buildSimilarPlantsTab(context),
                                _buildGalleryTab(context),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 32),

                    // Action Buttons
                    Row(
                      children: [
                        Expanded(
                          child: Obx(() {
                            final isSaved = plantController.isPlantSaved(
                              plant['id'],
                            );

                            return GestureDetector(
                              onTap: () {
                                if (!isSaved) {
                                  plantController.addPlant(plant);
                                  Get.snackbar(
                                    'Success',
                                    'Plant saved to your collection!',
                                    backgroundColor: AppTheme.primaryGreen,
                                    colorText: Colors.white,
                                  );
                                } else {
                                  plantController.removePlant(plant['id']);
                                }
                              },
                              child: AnimatedScale(
                                scale: 1.0,
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.easeOutBack,
                                child: PremiumButton(
                                  text: isSaved ? 'Saved' : 'Save Plant',
                                  icon: isSaved
                                      ? Icons.bookmark
                                      : Icons.bookmark_add,
                                  onPressed: () {
                                    if (!isSaved) {
                                      plantController.addPlant(plant);
                                    } else {
                                      plantController.removePlant(plant['id']);
                                    }
                                  },
                                  isOutlined: false,
                                ),
                              ),
                            );
                          }),
                        ),

                        const SizedBox(width: 16),
                        Expanded(
                          child: PremiumButton(
                            text: 'Share',
                            onPressed: () {
                              final plant =
                                  plantController.identifiedPlant.value;
                              if (plant != null) {
                                // Share text using SharePlus
                                SharePlus.instance.share(
                                  ShareParams(
                                    text:
                                        '🌱 Check out this plant: ${plant['name']} (${plant['scientificName']})!\nDiscover more in our Plant Identifier App.',
                                    subject: 'Plant Info',
                                  ),
                                );
                              } else {
                                Get.snackbar(
                                  'No plant selected',
                                  'Please identify a plant first to share it.',
                                  backgroundColor: AppTheme.primaryGreen,
                                  colorText: Colors.white,
                                );
                              }
                            },
                            isOutlined: true,
                            icon: Icons.share,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      }),
    );
  }

  Widget _buildInfoCard(
    BuildContext context,
    String title,
    String value,
    IconData icon,
  ) {
    return PremiumCard(
      child: Column(
        children: [
          Icon(icon, color: AppTheme.primaryGreen, size: 24),
          const SizedBox(height: 8),
          Text(title, style: Theme.of(context).textTheme.bodyMedium),
          const SizedBox(height: 4),
          Text(
            value,
            style: Theme.of(context).textTheme.titleMedium,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildCareTab(BuildContext context, Map<String, dynamic>? care) {
    if (care == null) {
      return const Center(child: Text('No care information available'));
    }

    return ListView.separated(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      itemCount: care.length,
      separatorBuilder: (_, __) =>
          const Divider(thickness: 0.6, color: Colors.black12, height: 28),
      itemBuilder: (context, index) {
        final entry = care.entries.elementAt(index);
        final label = _getFriendlyLabel(entry.key);
        final icon = _getCareIcon(entry.key);

        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: AppTheme.primaryGreen, size: 28),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: AppTheme.primaryGreen,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    entry.value.toString(),
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: AppTheme.lightText,
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  String _getFriendlyLabel(String key) {
    switch (key.toLowerCase()) {
      case 'light':
        return 'Light Requirement';
      case 'water':
        return 'Watering';
      case 'humidity':
        return 'Humidity';
      case 'temperature':
        return 'Temperature';
      default:
        return key.capitalize ?? key;
    }
  }

  Widget _buildSimilarPlantsTab(BuildContext context) {
    final similarPlants = [
      {
        'name': 'Monstera Adansonii',
        'image':
            'https://images.unsplash.com/photo-1506905925346-21bda4d32df4?w=200',
      },
      {
        'name': 'Philodendron',
        'image':
            'https://images.unsplash.com/photo-1593691509543-c55fb32d8de5?w=200',
      },
      {
        'name': 'Pothos',
        'image':
            'https://images.unsplash.com/photo-1586093248292-4e6636ce8b97?w=200',
      },
      {
        'name': 'Peace Lily',
        'image':
            'https://images.unsplash.com/photo-1416879595882-3373a0480b5b?w=200',
      },
    ];

    return GridView.builder(
      padding: const EdgeInsets.all(8),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 0.8,
      ),
      itemCount: similarPlants.length,
      itemBuilder: (context, index) {
        final plant = similarPlants[index];

        return GestureDetector(
          onTap: () {},
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Stack(
              children: [
                // Plant Image
                Positioned.fill(
                  child: Image.network(
                    plant['image']!,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => Container(
                      color: AppTheme.beige,
                      child: const Icon(
                        Icons.local_florist,
                        color: AppTheme.primaryGreen,
                      ),
                    ),
                  ),
                ),
                // Frosted / Semi-transparent overlay with text
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.4),
                      borderRadius: const BorderRadius.vertical(
                        bottom: Radius.circular(12),
                      ),
                    ),
                    child: Text(
                      plant['name']!,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildGalleryTab(BuildContext context) {
    final galleryImages = [
      'https://images.unsplash.com/photo-1416879595882-3373a0480b5b?w=300',
      'https://images.unsplash.com/photo-1506905925346-21bda4d32df4?w=300',
      'https://images.unsplash.com/photo-1593691509543-c55fb32d8de5?w=300',
      'https://images.unsplash.com/photo-1586093248292-4e6636ce8b97?w=300',
      'https://images.unsplash.com/photo-1485955900006-10f4d324d411?w=300',
      'https://images.unsplash.com/photo-1558618666-fcd25c85cd64?w=300',
    ];

    return GridView.builder(
      padding: const EdgeInsets.all(8),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
      ),
      itemCount: galleryImages.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            showDialog(
              context: context,
              builder: (context) => Dialog(
                child: Image.network(
                  galleryImages[index],
                  fit: BoxFit.contain,
                  errorBuilder: (_, __, ___) => Container(
                    height: 200,
                    color: AppTheme.beige,
                    child: const Icon(
                      Icons.local_florist,
                      size: 50,
                      color: AppTheme.primaryGreen,
                    ),
                  ),
                ),
              ),
            );
          },
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(
              galleryImages[index],
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => Container(
                color: AppTheme.beige,
                child: const Icon(
                  Icons.local_florist,
                  color: AppTheme.primaryGreen,
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  IconData _getCareIcon(String careType) {
    switch (careType.toLowerCase()) {
      case 'light':
        return Icons.wb_sunny;
      case 'water':
        return Icons.water_drop;
      case 'humidity':
        return Icons.opacity;
      case 'temperature':
        return Icons.thermostat;
      default:
        return Icons.info;
    }
  }
}
