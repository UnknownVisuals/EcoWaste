import 'package:eco_waste/features/user/trash_bank/controllers/waste_transaction_controller.dart';
import 'package:eco_waste/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DepositConfirmationScreen extends StatelessWidget {
  const DepositConfirmationScreen({
    super.key,
    required this.title,
    required this.message,
    required this.transactionId,
    required this.shouldProcess,
  });

  final String title, message, transactionId;
  final bool shouldProcess;

  @override
  Widget build(BuildContext context) {
    final WasteTransactionController transactionController = Get.put(
      WasteTransactionController(),
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
                onPressed: () => shouldProcess
                    ? transactionController.processTransaction(transactionId)
                    : transactionController.cancelTransaction(transactionId),
                child: const Center(child: Text('Iya')),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
