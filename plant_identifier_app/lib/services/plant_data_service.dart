import 'dart:convert';
import 'package:flutter/services.dart';

class PlantDataService {
  static List<Map<String, dynamic>>? _plants;
  static List<Map<String, dynamic>>? _careTips;
  static List<Map<String, dynamic>>? _blogPosts;

  static Future<void> loadData() async {
    if (_plants != null) return;
    
    final String jsonString = await rootBundle.loadString('assets/data/plants.json');
    final Map<String, dynamic> data = json.decode(jsonString);
    
    _plants = List<Map<String, dynamic>>.from(data['plants']);
    _careTips = List<Map<String, dynamic>>.from(data['careTips']);
    _blogPosts = List<Map<String, dynamic>>.from(data['blogPosts']);
  }

  static List<Map<String, dynamic>> get plants => _plants ?? [];
  static List<Map<String, dynamic>> get careTips => _careTips ?? [];
  static List<Map<String, dynamic>> get blogPosts => _blogPosts ?? [];

  static Map<String, dynamic>? findPlantByKeywords(List<String> keywords) {
    for (final plant in plants) {
      final plantKeywords = List<String>.from(plant['keywords'] ?? []);
      for (final keyword in keywords) {
        for (final plantKeyword in plantKeywords) {
          if (plantKeyword.toLowerCase().contains(keyword.toLowerCase()) ||
              keyword.toLowerCase().contains(plantKeyword.toLowerCase())) {
            return plant;
          }
        }
      }
    }
    return null;
  }
}