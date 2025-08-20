import 'package:eco_waste/features/admin/trash_bank/controllers/admin_waste_transaction_controller.dart';
import 'package:eco_waste/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DepositConfirmationScreen extends StatelessWidget {
  const DepositConfirmationScreen({
    super.key,
    required this.title,
    required this.message,
    required this.depositId,
    required this.depositValue,
  });

  final String title, message, depositId;
  final bool depositValue;

  @override
  Widget build(BuildContext context) {
    final AdminWasteTransactionController adminController = Get.put(
      AdminWasteTransactionController(),
    );

    return AlertDialog(
      title: Center(
        child: Text(title, style: Theme.of(context).textTheme.headlineMedium),
      ),
      content: Text(
        message,
        style: Theme.of(context).textTheme.bodyMedium,
        textAlign: TextAlign.center,
      ),
      actions: <Widget>[
        Row(
          children: [
            Expanded(
              child: OutlinedButton(
                onPressed: () => Get.back(),
                child: const Center(child: Text('Tidak')),
              ),
            ),
            const SizedBox(width: REYSizes.spaceBtwItems),
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  if (depositValue) {
                    adminController.processTransaction(depositId);
                  } else {
                    adminController.rejectTransaction(depositId);
                  }
                },
                child: const Center(child: Text('Iya')),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
