import 'package:get/get.dart';
import 'package:plant_identifier_app/core/constants.dart';

class CategoryController extends GetxController {
  var selectedCategory = "All".obs; // default category
  List<Map<String, dynamic>> get filteredPlants {
    if (selectedCategory.value == 'All') {
      return AppConstants.mockPlants;
    }
    return AppConstants.mockPlants
        .where((plant) => plant['category'] == selectedCategory.value)
        .toList();
  }
}
