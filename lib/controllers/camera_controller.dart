import 'dart:io';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:eco_waste/utils/popups/loaders.dart';

class CameraController extends GetxController {
  Rx<File?> selectedImage = Rx<File?>(null);

  // Pick image from gallery
  Future<void> pickImageFromGallery() async {
    try {
      final pickedFile = await ImagePicker().pickImage(
        source: ImageSource.gallery,
        imageQuality: 50,
      );
      if (pickedFile != null) {
        selectedImage.value = File(pickedFile.path);
      } else {
        REYLoaders.errorSnackBar(
          title: 'failedToSelectImage'.tr,
          message: 'noImageSelected'.tr,
        );
      }
    } catch (e) {
      REYLoaders.errorSnackBar(
        title: 'failedToSelectImage'.tr,
        message: e.toString(),
      );
    }
  }

  // Capture image using camera
  Future<void> captureImageWithCamera() async {
    try {
      final pickedFile = await ImagePicker().pickImage(
        source: ImageSource.camera,
        imageQuality: 50,
      );
      if (pickedFile != null) {
        selectedImage.value = File(pickedFile.path);
      } else {
        REYLoaders.errorSnackBar(
          title: "Gagal mengambil gambar",
          message: "Tidak ada gambar yang diambil",
        );
      }
    } catch (e) {
      REYLoaders.errorSnackBar(
        title: "Gagal mengambil gambar",
        message: e.toString(),
      );
    }
  }
}
