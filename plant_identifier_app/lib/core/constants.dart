import '../services/plant_data_service.dart';

class AppConstants {
  static const String appName = 'PlantID';
  
  static List<Map<String, dynamic>> get mockPlants => PlantDataService.plants;
  static List<Map<String, dynamic>> get careTips => PlantDataService.careTips;
  static List<Map<String, dynamic>> get blogPosts => PlantDataService.blogPosts;

  static const List<Map<String, String>> plantCategories = [
    {'name': 'Indoor Plants', 'icon': '🏠'},
    {'name': 'Outdoor Plants', 'icon': '🌳'},
    {'name': 'Medicinal Plants', 'icon': '🌿'},
    {'name': 'Decorative Plants', 'icon': '🌺'},
    {'name': 'Succulents', 'icon': '🌵'},
    {'name': 'Herbs', 'icon': '🌱'},
  ];
}