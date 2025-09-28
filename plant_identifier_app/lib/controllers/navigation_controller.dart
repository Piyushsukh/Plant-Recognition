import 'package:get/get.dart';

class NavigationController extends GetxController {
  var currentIndex = 0.obs;

  void changeIndex(int index) {
    currentIndex.value = index;
  }

  void navigateToHome() => changeIndex(0);
  void navigateToIdentify() => changeIndex(1);
  void navigateToExplore() => changeIndex(2);
  void navigateToMyPlants() => changeIndex(3);
  void navigateToBlogs() => changeIndex(4);
}