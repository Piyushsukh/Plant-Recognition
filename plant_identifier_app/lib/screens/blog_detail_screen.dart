import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';
import '../core/theme.dart';
import '../widgets/custom_button.dart';

class BlogDetailScreen extends StatelessWidget {
  const BlogDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final blog = Get.arguments as Map<String, dynamic>?;
    final RxBool isBookmarked = false.obs;

    if (blog == null) {
      return Scaffold(
        appBar: AppBar(title: const Text("Blog")),
        body: const Center(child: Text("Blog not found")),
      );
    }

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // App Bar with Image
          SliverAppBar(
            expandedHeight: 300,
            pinned: true,
            backgroundColor: AppTheme.primaryGreen,
            leading: Container(
              margin: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.black.withValues(alpha: 0.3),
                borderRadius: BorderRadius.circular(12),
              ),
              child: IconButton(
                onPressed: () => Get.back(),
                icon: const Icon(Icons.arrow_back, color: Colors.white),
              ),
            ),
            actions: [
              Obx(
                () => Container(
                  margin: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.black.withValues(alpha: 0.3),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: GestureDetector(
                    onTap: () {
                      isBookmarked.value = !isBookmarked.value;
                      Get.snackbar(
                        isBookmarked.value ? 'Bookmarked' : 'Removed',
                        isBookmarked.value
                            ? 'Blog saved to your reading list!'
                            : 'Removed from reading list!',
                        snackPosition: SnackPosition.BOTTOM,
                        backgroundColor: AppTheme.primaryGreen,
                        colorText: Colors.white,
                      );
                    },
                    child: AnimatedScale(
                      scale: isBookmarked.value ? 1.2 : 1.0,
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeOutBack,
                      child: Icon(
                        isBookmarked.value
                            ? Icons.bookmark
                            : Icons.bookmark_add,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
            flexibleSpace: FlexibleSpaceBar(
              background: Image.network(
                blog['image'] ?? '',
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  color: AppTheme.beige,
                  child: const Icon(
                    Icons.article,
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
                  // Category
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: AppTheme.primaryGreen.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      blog['category'] ?? 'Blog',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppTheme.primaryGreen,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Title
                  Text(
                    blog['title'] ?? 'Blog Title',
                    style: Theme.of(context).textTheme.displayMedium,
                  ),
                  const SizedBox(height: 16),

                  // Author and Date
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 20,
                        backgroundColor: AppTheme.primaryGreen.withValues(alpha: 0.1),
                        child: Text(
                          (blog['author'] ?? 'A')[0].toUpperCase(),
                          style: Theme.of(context).textTheme.titleMedium
                              ?.copyWith(
                                color: AppTheme.primaryGreen,
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            blog['author'] ?? 'Anonymous',
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          Text(
                            blog['date'] ?? '',
                            style: Theme.of(context).textTheme.bodyMedium
                                ?.copyWith(color: AppTheme.lightText),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 32),

                  // Content
                  Text(
                    blog['content'] ??
                        blog['excerpt'] ??
                        'Blog content goes here...',
                    style: Theme.of(
                      context,
                    ).textTheme.bodyLarge?.copyWith(height: 1.6, fontSize: 16),
                  ),
                  const SizedBox(height: 32),

                  // Action Buttons
                  Row(
                    children: [
                      Expanded(
                        child: PremiumButton(
                          text: 'Share',
                          onPressed: () {
                            // Share blog content
                            SharePlus.instance.share(
                              ShareParams(
                                text:
                                    '📖 Check out this article: ${blog['title']}\n\n${blog['excerpt'] ?? 'Interesting plant-related content!'}\n\nRead more in our Plant Identifier App.',
                              ),
                            );
                          },
                          icon: Icons.share,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Obx(
                          () => PremiumButton(
                            text: isBookmarked.value ? 'Saved' : 'Bookmark',
                            icon: isBookmarked.value
                                ? Icons.bookmark
                                : Icons.bookmark_add,
                            onPressed: () {
                              isBookmarked.value = !isBookmarked.value;
                              Get.snackbar(
                                isBookmarked.value ? 'Bookmarked' : 'Removed',
                                isBookmarked.value
                                    ? 'Blog saved to your reading list!'
                                    : 'Removed from reading list!',
                                backgroundColor: AppTheme.primaryGreen,
                                colorText: Colors.white,
                                snackPosition: SnackPosition.BOTTOM,
                              );
                            },
                            isOutlined: !isBookmarked.value,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 32),

                  // Related Articles Section
                  Text(
                    "Related Articles",
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  const SizedBox(height: 16),
                  Container(
                    height: 120,
                    decoration: BoxDecoration(
                      color: AppTheme.beige.withValues(alpha: 0.3),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: const Center(
                      child: Text(
                        "Related articles coming soon!",
                        style: TextStyle(
                          color: AppTheme.lightText,
                          fontStyle: FontStyle.italic,
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
    );
  }
}
