import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../core/theme.dart';
import '../widgets/custom_button.dart';

class Onboarding1 extends StatelessWidget {
  const Onboarding1({super.key});

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
                  color: AppTheme.softGreen.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(40),
                ),
                child: const Icon(
                  Icons.camera_alt_outlined,
                  size: 80,
                  color: AppTheme.primaryGreen,
                ),
              ),
              const SizedBox(height: 48),
              Text(
                "Identify Plants\nInstantly",
                style: Theme.of(context).textTheme.displayLarge,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              Text(
                "Take a photo and discover the name, family, and care details of any plant in seconds.",
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
                    width: 40,
                    height: 8,
                    decoration: BoxDecoration(
                      color: AppTheme.primaryGreen,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: AppTheme.lightText.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 32),
              PremiumButton(
                text: "Next",
                onPressed: () => Get.toNamed('/onboarding2'),
                width: double.infinity,
              ),
              const SizedBox(height: 16),
              TextButton(
                onPressed: () => Get.offNamed('/home'),
                child: Text(
                  "Skip",
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