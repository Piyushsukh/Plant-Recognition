import 'package:get/get.dart';
import '../services/plant_data_service.dart';
import '../services/ml_kit_service.dart';
import 'notification_controller.dart';

class PlantController extends GetxController {
  var myPlants = <Map<String, dynamic>>[].obs;
  var identifiedPlant = Rxn<Map<String, dynamic>>();
  var isLoading = false.obs;
  var capturedImagePath = '';

  @override
  void onInit() {
    super.onInit();
    PlantDataService.loadData();
  }

  void addPlant(Map<String, dynamic> plant) {
    if (!myPlants.any((p) => p['id'] == plant['id'])) {
      myPlants.add(plant);
      final notificationController = Get.find<NotificationController>();
      notificationController.addNotification(
        'Plant Saved! 🌱',
        '${plant['name']} has been added to your collection',
        'success',
      );
    }
  }

  void removePlant(String plantId) {
    myPlants.removeWhere((plant) => plant['id'] == plantId);
  }

  bool isPlantSaved(String plantId) {
    return myPlants.any((p) => p['id'] == plantId);
  }

  Future<void> identifyPlant([String? imagePath]) async {
    isLoading.value = true;
    
    try {
      final pathToUse = imagePath ?? capturedImagePath;
      if (pathToUse.isNotEmpty) {
        final plant = await MLKitService.identifyPlant(pathToUse);
        identifiedPlant.value = plant;
      } else {
        // Fallback to random plant
        final plants = PlantDataService.plants;
        if (plants.isNotEmpty) {
          identifiedPlant.value = plants[DateTime.now().millisecond % plants.length];
        }
      }
    } catch (e) {
      // Fallback on error
      final plants = PlantDataService.plants;
      if (plants.isNotEmpty) {
        identifiedPlant.value = plants[DateTime.now().millisecond % plants.length];
      }
    }
    
    isLoading.value = false;
  }

  void setCapturedImagePath(String path) {
    capturedImagePath = path;
  }

  void clearIdentification() {
    identifiedPlant.value = null;
  }
}