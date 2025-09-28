import 'package:google_mlkit_image_labeling/google_mlkit_image_labeling.dart';
import 'plant_data_service.dart';

class MLKitService {
  static final _imageLabeler = ImageLabeler(options: ImageLabelerOptions());

  static Future<Map<String, dynamic>?> identifyPlant(String imagePath) async {
    try {
      final inputImage = InputImage.fromFilePath(imagePath);
      final labels = await _imageLabeler.processImage(inputImage);

      final keywords = labels
          .map((label) => label.label.toLowerCase())
          .toList();

      // Find plant based on ML Kit labels
      final plant = PlantDataService.findPlantByKeywords(keywords);
      if (plant != null) {
        return plant;
      }

      // Fallback to random plant if no match
      final plants = PlantDataService.plants;
      if (plants.isNotEmpty) {
        return plants[DateTime.now().millisecond % plants.length];
      }

      return null;
    } catch (e) {
      // Fallback to random plant on error
      final plants = PlantDataService.plants;
      if (plants.isNotEmpty) {
        return plants[DateTime.now().millisecond % plants.length];
      }
      return null;
    }
  }

  static void dispose() {
    _imageLabeler.close();
  }
}
