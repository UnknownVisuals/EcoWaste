import 'package:eco_waste/features/authentication/controllers/user_controller.dart';
import 'package:eco_waste/features/trash_bank/models/deposit_asus_model.dart';
import 'package:eco_waste/features/trash_bank/models/waste_type_model.dart';
import 'package:eco_waste/utils/http/http_client.dart';
import 'package:eco_waste/utils/popups/loaders.dart';
import 'package:get/get.dart';

class DepositAsusController extends GetxController {
  final REYHttpHelper httpHelper = Get.put(REYHttpHelper());

  RxList<WasteTypeModel> wasteType = <WasteTypeModel>[].obs;
  Rx<bool> isLoading = false.obs;

  // POST Deposit Asus
  Future<void> postDeposit(DepositAsusModel depositAsusModel) async {
    isLoading.value = true;

    try {
      final response = await httpHelper.postRequest(
        'pengumpulan-sampah',
        depositAsusModel.toJson(),
      );

      if (response.statusCode == 201) {
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
}
