import 'package:get/get.dart';

class AdminHomeController extends GetxController {
  static AdminHomeController get instance => Get.find();

  final carouselCurrentIndex = 0.obs;

  void updatePageIndicator(index) {
    carouselCurrentIndex.value = index;
  }
}
