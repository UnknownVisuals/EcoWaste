import 'package:eco_waste/features/user/trash_bank/models/schedule_model.dart';
import 'package:eco_waste/utils/http/http_client.dart';
import 'package:eco_waste/utils/popups/loaders.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class ScheduleController extends GetxController {
  final REYHttpHelper httpHelper = Get.put(REYHttpHelper());

  RxList<ScheduleModel> schedule = <ScheduleModel>[].obs;
  Rx<bool> isLoading = false.obs;

  // GET Jadwal Pengumpulan
  Future<void> getSchedule({required String desaId}) async {
    isLoading.value = true;

    try {
      final scheduleResponse = await httpHelper.getRequest(
        'jadwal-pengumpulan?desaId=$desaId',
      );

      if (scheduleResponse.statusCode == 200) {
        final jsonData = scheduleResponse.body;

        schedule.value = (jsonData as List)
            .map((item) => ScheduleModel.fromJson(item))
            .toList();
      } else {
        REYLoaders.errorSnackBar(
          title: "Gagal memuat jadwal",
          message: "Kesalahan saat memuat data jadwal",
        );
      }
    } catch (e) {
      REYLoaders.errorSnackBar(
        title: "Gagal memuat jadwal",
        message: e.toString(),
      );
    } finally {
      isLoading.value = false;
    }
  }

  // Format jadwal waktu mulai - waktu selesai
  String formatScheduleTime(DateTime dateTime1, DateTime dateTime2) {
    final DateFormat formatter1 = DateFormat('HH:mm');
    final DateFormat formatter2 = DateFormat('HH:mm');
    return '${formatter1.format(dateTime1)} - ${formatter2.format(dateTime2)}';
  }
}
