import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'core/theme.dart';
import 'controllers/navigation_controller.dart';
import 'controllers/plant_controller.dart';
import 'controllers/notification_controller.dart';
import 'services/plant_data_service.dart';
import 'routes.dart';
import 'screens/splash_screen.dart';

void main() {
  runApp(const PlantApp());
}

class PlantApp extends StatelessWidget {
  const PlantApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Initialize data and controllers
    PlantDataService.loadData();
    Get.put(NavigationController());
    Get.put(PlantController());
    Get.put(NotificationController());

    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: "PlantID - Premium Plant Identifier",
      theme: AppTheme.theme,
      home: const SplashScreen(),
      getPages: appRoutes,
    );
  }
}
