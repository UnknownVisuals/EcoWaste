import 'package:eco_waste/features/authentication/controllers/auth_controller.dart';
import 'package:eco_waste/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LogoutScreen extends StatelessWidget {
  const LogoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthController authController = Get.put(AuthController());
    return AlertDialog(
      title: Center(
        child: Text(
          'Keluar',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
      content: Text(
        'Yakin mau keluar Sobat Sampah?',
        style: Theme.of(context).textTheme.bodyMedium,
      ),
      actions: <Widget>[
        Row(
          children: [
            Expanded(
              child: OutlinedButton(
                onPressed: () => Get.back(),
                child: const Center(child: Text('No')),
              ),
            ),
            const SizedBox(width: REYSizes.spaceBtwItems),
            Expanded(
              child: Obx(
                () => ElevatedButton(
                  onPressed: authController.isLoading.value
                      ? null
                      : () async {
                          await authController.logout();
                          Get.back(); // Close dialog
                          // Navigation will be handled by AuthController
                        },
                  child: authController.isLoading.value
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor: AlwaysStoppedAnimation<Color>(
                              Colors.white,
                            ),
                          ),
                        )
                      : const Center(child: Text('Yes')),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
