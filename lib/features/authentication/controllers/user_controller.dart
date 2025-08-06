import 'package:eco_waste/features/authentication/models/user_model.dart';
import 'package:eco_waste/features/user/trash_bank/controllers/deposit_controller.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class UserController extends GetxController {
  late Rx<UserModel> userModel = UserModel(
    id: '',
    email: '',
    username: '',
    desaId: '',
    poin: 0,
    role: 'WARGA',
  ).obs;

  final GetStorage storage = GetStorage();

  void updateUserModel(Map<String, dynamic> userData, int totalPoin) {
    userModel.value = UserModel.fromJson({...userData, 'poin': 0});
    refreshUserPoin(userModel.value.id);
  }

  void saveUserToStorage() {
    storage.write('user', userModel.value.toJson());
    storage.write('rememberMe', true);
  }

  void removeUserFromStorage() {
    storage.remove('user');
    storage.write('rememberMe', false);
  }

  Future<int> calculateTotalPoin(String userId) async {
    final DepositController depositController = Get.put(DepositController());
    await depositController.getDeposit(userId: userId);
    return depositController.deposit.fold<int>(
      0,
      (previousValue, element) => previousValue + element.poin,
    );
  }

  Future<void> refreshUserPoin(String userId) async {
    final totalPoin = await calculateTotalPoin(userId);
    userModel.update((user) {
      if (user != null) {
        user.poin = totalPoin;
      }
    });
  }
}
