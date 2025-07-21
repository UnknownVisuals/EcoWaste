import 'dart:io';

import 'package:eco_waste/features/authentication/controllers/user_controller.dart';
import 'package:eco_waste/features/user/leaderboard/models/leaderboard_model.dart';
import 'package:eco_waste/features/user/trash_bank/models/deposit_asus_model.dart';
import 'package:eco_waste/features/user/trash_bank/models/waste_type_model.dart';
import 'package:eco_waste/utils/http/http_client.dart';
import 'package:eco_waste/utils/popups/loaders.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class DepositAsusController extends GetxController {
  final REYHttpHelper httpHelper = Get.put(REYHttpHelper());

  RxList<WasteTypeModel> wasteType = <WasteTypeModel>[].obs;
  Rx<File?> selectedImage = Rx<File?>(null);
  Rx<bool> isLoading = false.obs;

  RxList<WasteTypeModel> mockWasteTypes = [
    WasteTypeModel(
      id: "WT001",
      name: "Plastik",
      description:
          "Botol, gelas, dan wadah plastik lainnya. Pastikan dalam keadaan bersih dan kering sebelum disetor.",
      pricePerKg: 15.0,
      recyclable: true,
      hazardous: false,
    ),
    WasteTypeModel(
      id: "WT002",
      name: "Kertas",
      description:
          "Kertas HVS, koran, majalah, dan kardus. Tidak termasuk kertas thermal atau yang berlapis plastik/lilin.",
      pricePerKg: 15.0,
      recyclable: true,
      hazardous: false,
    ),
    WasteTypeModel(
      id: "WT003",
      name: "Kaca",
      description:
          "Botol atau wadah kaca bekas sirup, kecap, atau minuman. Pisahkan berdasarkan warna jika memungkinkan.",
      pricePerKg: 15.0,
      recyclable: true,
      hazardous: false,
    ),
    WasteTypeModel(
      id: "WT004",
      name: "Organik",
      description:
          "Sisa makanan, daun kering, dan sampah dari kebun yang dapat diolah menjadi kompos.",
      pricePerKg: 10.0,
      recyclable: true,
      hazardous: false,
    ),
    WasteTypeModel(
      id: "WT005",
      name: "B3",
      description:
          "Bahan Berbahaya dan Beracun seperti baterai bekas, lampu, dan sampah elektronik.",
      pricePerKg: 15.0,
      recyclable: false,
      hazardous: true,
    ),
  ].obs;

  // POST Deposit Asus
  Future<void> postDeposit(
    DepositAsusModel depositAsusModel,
    LeaderboardModel leaderboardModel,
  ) async {
    isLoading.value = true;

    try {
      final response = await httpHelper.postRequest(
        'pengumpulan-sampah',
        'ADMIN',
        depositAsusModel.toJson(),
      );

      final responseLeaderboard = await httpHelper.postRequest(
        'leaderboard',
        'ADMIN',
        leaderboardModel.toJson(),
      );

      if (response.statusCode == 201 && responseLeaderboard.statusCode == 200) {
        REYLoaders.successSnackBar(
          title: "Sukses menyetor sampah",
          message: "Data sampah berhasil disetor",
        );
        final UserController userController = Get.find();
        await userController.refreshUserPoin(depositAsusModel.userId);
      } else {
        REYLoaders.errorSnackBar(
          title: "Gagal menyetor sampah",
          message: "Terjadi kesalahan saat menyetor sampah",
        );
      }
    } catch (e) {
      REYLoaders.errorSnackBar(
        title: "Gagal menyetor sampah",
        message: e.toString(),
      );
    } finally {
      isLoading.value = false;
    }
  }

  // GET Jenis sampah
  Future<void> getWasteType() async {
    isLoading.value = true;

    try {
      final wasteTypeResponse = await httpHelper.getRequest('waste-types');

      if (wasteTypeResponse.statusCode == 200) {
        final jsonData = wasteTypeResponse.body;

        wasteType.value = (jsonData as List)
            .map((item) => WasteTypeModel.fromJson(item))
            .toList();
      } else {
        REYLoaders.errorSnackBar(
          title: "Gagal memuat jenis sampah",
          message: "Kesalahan saat memuat jenis sampah",
        );
      }
    } catch (e) {
      REYLoaders.errorSnackBar(
        title: "Gagal memuat jenis sampah",
        message: e.toString(),
      );
    } finally {
      isLoading.value = false;
    }
  }

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
          title: "Gagal memilih gambar",
          message: "Tidak ada gambar yang dipilih",
        );
      }
    } catch (e) {
      REYLoaders.errorSnackBar(
        title: "Gagal memilih gambar",
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
