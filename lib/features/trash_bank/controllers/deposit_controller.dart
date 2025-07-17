import 'package:eco_waste/features/trash_bank/models/confirmation_model.dart';
import 'package:eco_waste/features/trash_bank/models/deposit_model.dart';
import 'package:eco_waste/utils/http/http_client.dart';
import 'package:eco_waste/utils/popups/loaders.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class DepositController extends GetxController {
  final REYHttpHelper httpHelper = Get.put(REYHttpHelper());

  RxList<DepositModel> deposit = <DepositModel>[].obs;
  Rx<bool> isLoading = false.obs;

  // GET Pengumpulan Sampah
  Future<void> getDeposit({required String userId}) async {
    isLoading.value = true;

    try {
      final depositResponse = await httpHelper.getRequest(
        'pengumpulan-sampah/user/$userId',
      );

      if (depositResponse.statusCode == 200) {
        final jsonData = depositResponse.body;

        deposit.value = (jsonData as List)
            .map((item) => DepositModel.fromJson(item))
            .toList();
      } else {
        REYLoaders.errorSnackBar(
          title: "Gagal memuat pengumpulan sampah",
          message: "Kesalahan saat memuat data pengumpulan sampah",
        );
      }
    } catch (e) {
      REYLoaders.errorSnackBar(
        title: "Gagal memuat pengumpulan sampah",
        message: e.toString(),
      );
    } finally {
      isLoading.value = false;
    }
  }

  // POST Konfirmasi pengumpulan Sampah
  Future<void> confirmDeposit({
    required String depositId,
    required bool depositValue,
  }) async {
    isLoading.value = true;

    try {
      final confirmationModel = ConfirmationModel(
        id: depositId,
        value: depositValue,
      );

      final confirmationResponse = await httpHelper.patchRequest(
        'pengumpulan-sampah',
        confirmationModel.toJson(),
      );

      Get.back();

      if (confirmationResponse.statusCode == 200) {
        REYLoaders.successSnackBar(
          title: "Sukses mengonfirmasi pengumpulan sampah",
          message: "Pengumpulan sampah berhasil dikonfirmasi",
        );
      } else {
        REYLoaders.errorSnackBar(
          title: "Gagal mengonfirmasi pengumpulan sampah",
          message: "Terjadi kesalahan saat mengonfirmasi pengumpulan sampah",
        );
      }
    } catch (e) {
      REYLoaders.errorSnackBar(
        title: "Gagal mengonfirmasi pengumpulan sampah",
        message: e.toString(),
      );
    } finally {
      isLoading.value = false;
    }
  }

  String formatDepositTime(DateTime dateTime) {
    final DateFormat formatter = DateFormat('dd MMMM yyyy, HH:mm');
    return formatter.format(dateTime);
  }
}
