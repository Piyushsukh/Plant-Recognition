import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../core/theme.dart';
import '../widgets/custom_button.dart';

class Onboarding2 extends StatelessWidget {
  const Onboarding2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              const Spacer(),
              Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  color: AppTheme.beige.withOpacity(0.8),
                  borderRadius: BorderRadius.circular(40),
                ),
                child: const Icon(
                  Icons.eco_outlined,
                  size: 80,
                  color: AppTheme.primaryGreen,
                ),
              ),
              const SizedBox(height: 48),
              Text(
                "Learn Care Tips &\nExplore Plants",
                style: Theme.of(context).textTheme.displayLarge,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              Text(
                "Get personalized care instructions and discover thousands of plants in our comprehensive library.",
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: AppTheme.lightText,
                  height: 1.5,
                ),
                textAlign: TextAlign.center,
              ),
              const Spacer(),
              Row(
                children: [
                  Container(
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: AppTheme.lightText.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    width: 40,
                    height: 8,
                    decoration: BoxDecoration(
                      color: AppTheme.primaryGreen,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 32),
              PremiumButton(
                text: "Get Started",
                onPressed: () => Get.offNamed('/home'),
                width: double.infinity,
              ),
              const SizedBox(height: 16),
              TextButton(
                onPressed: () => Get.back(),
                child: Text(
                  "Back",
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: AppTheme.lightText,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}