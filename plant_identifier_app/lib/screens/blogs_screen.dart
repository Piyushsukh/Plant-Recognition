import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../core/theme.dart';
import '../core/constants.dart';
import '../widgets/premium_card.dart';
import '../controllers/category_controller.dart';

class BlogsScreen extends StatelessWidget {
  const BlogsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final categoryController = Get.put(CategoryController());

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Text(
                "Plant Blogs",
                style: Theme.of(context).textTheme.displayMedium,
              ),
              const SizedBox(height: 8),
              Text(
                "Stories, tips, and plant wisdom",
                style: Theme.of(
                  context,
                ).textTheme.bodyLarge?.copyWith(color: AppTheme.lightText),
              ),
              const SizedBox(height: 32),

              // Featured Blog
              if (AppConstants.blogPosts.isNotEmpty) ...[
                Text(
                  "Featured",
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                const SizedBox(height: 16),
                _buildFeaturedBlog(context, AppConstants.blogPosts.first),
                const SizedBox(height: 32),
              ],

              // Categories
              Obx(() {
                return SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      _buildCategoryChip(context, "All", categoryController),
                      const SizedBox(width: 12),
                      _buildCategoryChip(
                        context,
                        "Care Tips",
                        categoryController,
                      ),
                      const SizedBox(width: 12),
                      _buildCategoryChip(
                        context,
                        "Indoor Plants",
                        categoryController,
                      ),
                      const SizedBox(width: 12),
                      _buildCategoryChip(
                        context,
                        "Gardening",
                        categoryController,
                      ),
                    ],
                  ),
                );
              }),
              const SizedBox(height: 24),

              // Blog List
              Obx(() {
                final selected = categoryController.selectedCategory.value;

                final filteredPosts = selected == "All"
                    ? AppConstants.blogPosts
                    : AppConstants.blogPosts
                          .where((post) => post['category'] == selected)
                          .toList();

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Recent Posts",
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    const SizedBox(height: 16),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: filteredPosts.length,
                      itemBuilder: (context, index) {
                        final blog = filteredPosts[index];
                        return Container(
                          margin: const EdgeInsets.only(bottom: 16),
                          child: _buildBlogCard(context, blog),
                        );
                      },
                    ),
                  ],
                );
              }),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCategoryChip(
    BuildContext context,
    String label,
    CategoryController categoryController,
  ) {
    final isSelected = categoryController.selectedCategory.value == label;

    return GestureDetector(
      onTap: () => categoryController.selectedCategory.value = label,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? AppTheme.primaryGreen : AppTheme.cardBackground,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected
                ? AppTheme.primaryGreen
                : AppTheme.lightText.withOpacity(0.3),
          ),
        ),
        child: Text(
          label,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: isSelected ? Colors.white : AppTheme.lightText,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  Widget _buildFeaturedBlog(BuildContext context, Map<String, dynamic> blog) {
    return PremiumCard(
      padding: EdgeInsets.zero,
      onTap: () => Get.toNamed('/blogDetail', arguments: blog),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
            child: AspectRatio(
              aspectRatio: 16 / 9,
              child: Image.network(
                blog['image'],
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  color: AppTheme.beige,
                  child: const Icon(
                    Icons.article,
                    size: 48,
                    color: AppTheme.primaryGreen,
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: AppTheme.primaryGreen.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    blog['category'],
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppTheme.primaryGreen,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  blog['title'],
                  style: Theme.of(context).textTheme.headlineMedium,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 8),
                Text(
                  blog['excerpt'],
                  style: Theme.of(
                    context,
                  ).textTheme.bodyLarge?.copyWith(color: AppTheme.lightText),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Text(
                      blog['author'],
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      "•",
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppTheme.lightText,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      blog['date'],
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppTheme.lightText,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBlogCard(BuildContext context, Map<String, dynamic> blog) {
    return PremiumCard(
      padding: EdgeInsets.zero,
      onTap: () => Get.toNamed('/blogDetail', arguments: blog),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.horizontal(
              left: Radius.circular(20),
            ),
            child: Image.network(
              blog['image'],
              width: 100,
              height: 100,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => Container(
                width: 100,
                height: 100,
                color: AppTheme.beige,
                child: const Icon(Icons.article, color: AppTheme.primaryGreen),
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
                    blog['title'],
                    style: Theme.of(context).textTheme.titleMedium,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    blog['excerpt'],
                    style: Theme.of(context).textTheme.bodyMedium,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    blog['date'],
                    style: Theme.of(
                      context,
                    ).textTheme.bodyMedium?.copyWith(color: AppTheme.lightText),
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
