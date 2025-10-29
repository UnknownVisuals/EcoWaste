import 'package:eco_waste/common/widgets/appbar.dart';
import 'package:eco_waste/common/widgets/base64_image_preview.dart';
import 'package:eco_waste/common/widgets/image_preview_dialog.dart';
import 'package:eco_waste/common/widgets/section_heading.dart';
import 'package:eco_waste/features/authentication/controllers/user_controller.dart';
import 'package:eco_waste/features/trash_bank/models/transactions_model.dart';
import 'package:eco_waste/features/trash_bank/screens/transactions/widgets/transactions_info_row.dart';
import 'package:eco_waste/utils/constants/colors.dart';
import 'package:eco_waste/utils/constants/sizes.dart';
import 'package:eco_waste/utils/formatters/formatter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';

class TransactionDetailScreen extends StatelessWidget {
  const TransactionDetailScreen({super.key, required this.transaction});

  final TransactionModel transaction;

  @override
  Widget build(BuildContext context) {
    // Determine status color and icon
    Color statusColor;
    IconData statusIcon;
    String statusText;

    switch (transaction.status.toUpperCase()) {
      case 'PENDING':
        statusColor = REYColors.warning;
        statusIcon = Iconsax.clock;
        statusText = 'pending'.tr;
        break;
      case 'COMPLETED':
        statusColor = REYColors.success;
        statusIcon = Iconsax.tick_circle;
        statusText = 'completed'.tr;
        break;
      default:
        statusColor = REYColors.grey;
        statusIcon = Iconsax.info_circle;
        statusText = transaction.status;
    }

    UserController userController = Get.put(UserController());
    String userRole = userController.userModel.value.role;

    return Scaffold(
      appBar: REYAppBar(
        title: Text(
          'transactionDetail'.tr,
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        showBackArrow: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(REYSizes.defaultSpace),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Status Card
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(REYSizes.md),
              decoration: BoxDecoration(
                color: statusColor.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(REYSizes.cardRadiusMd),
                border: Border.all(color: statusColor.withValues(alpha: 0.2)),
              ),
              child: Row(
                children: [
                  Icon(statusIcon, color: statusColor),
                  const SizedBox(width: REYSizes.spaceBtwItems),
                  Text(
                    statusText,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: statusColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: REYSizes.spaceBtwSections),

            // Transaction Information
            REYSectionHeading(title: 'transactionInformation'.tr),
            const SizedBox(height: REYSizes.spaceBtwItems),
            // TransactionsInfoRow(
            //   title: 'transactionId'.tr,
            //   value: transaction.id,
            // ),
            TransactionsInfoRow(
              title: 'type'.tr,
              value: transaction.type == 'PICKUP' ? 'pickUp'.tr : 'dropOff'.tr,
            ),
            TransactionsInfoRow(
              title: 'scheduledDate'.tr,
              value: DateFormat(
                'dd MMM yyyy, HH:mm',
              ).format(transaction.scheduledDate),
            ),
            TransactionsInfoRow(
              title: 'createdDate'.tr,
              value: DateFormat(
                'dd MMM yyyy, HH:mm',
              ).format(transaction.createdAt),
            ),
            if (transaction.completedDate != null)
              TransactionsInfoRow(
                title: 'completedDate'.tr,
                value: DateFormat(
                  'dd MMM yyyy, HH:mm',
                ).format(transaction.completedDate!),
              ),

            const SizedBox(height: REYSizes.spaceBtwSections),

            // Location Information
            REYSectionHeading(title: 'locationInformation'.tr),
            const SizedBox(height: REYSizes.spaceBtwItems),
            TransactionsInfoRow(
              title: 'locationDetail'.tr,
              value: transaction.locationDetail,
            ),

            const SizedBox(height: REYSizes.spaceBtwSections),

            // Waste Category Information
            ...[
              REYSectionHeading(title: 'wasteCategory'.tr),
              const SizedBox(height: REYSizes.spaceBtwItems),
              TransactionsInfoRow(
                title: 'category'.tr,
                value: transaction.wasteCategory.name,
              ),
              TransactionsInfoRow(
                title: 'description'.tr,
                value: transaction.wasteCategory.description,
              ),
              TransactionsInfoRow(
                title: 'pointsPerKg'.tr,
                value: REYFormatter.formatPoints(
                  transaction.wasteCategory.pointsPerKg,
                ),
              ),
              // TransactionsInfoRow(
              //   title: 'color'.tr,
              //   value: transaction.wasteCategory.color,
              // ),
            ],

            const SizedBox(height: REYSizes.spaceBtwSections),

            // User Information
            ...[
              REYSectionHeading(title: 'userInformation'.tr),
              const SizedBox(height: REYSizes.spaceBtwItems),
              TransactionsInfoRow(
                title: 'name'.tr,
                value: transaction.user.name,
              ),
              // TransactionsInfoRow(
              //   title: 'userId'.tr,
              //   value: transaction.user.id,
              // ),
            ],

            const SizedBox(height: REYSizes.spaceBtwSections),

            // Transaction Results (for completed transactions)
            if (transaction.status == 'COMPLETED') ...[
              REYSectionHeading(title: 'transactionResults'.tr),
              const SizedBox(height: REYSizes.spaceBtwItems),
              if (transaction.actualWeight != null)
                TransactionsInfoRow(
                  title: 'actualWeight'.tr,
                  value:
                      '${transaction.actualWeight!.toStringAsFixed(2)} ${'kg'.tr}',
                ),
              TransactionsInfoRow(
                title: 'pointsEarned'.tr,
                value: REYFormatter.formatPoints(transaction.points),
              ),
              if (transaction.notes != null && transaction.notes!.isNotEmpty)
                TransactionsInfoRow(
                  title: 'notes'.tr,
                  value: transaction.notes!,
                ),
              const SizedBox(height: REYSizes.spaceBtwSections),
            ],

            // Photos
            if (transaction.photos.isNotEmpty) ...[
              REYSectionHeading(title: 'photos'.tr),
              const SizedBox(height: REYSizes.spaceBtwItems),
              AspectRatio(
                aspectRatio: 16 / 9,
                child: SizedBox(
                  width: double.infinity,
                  child: GestureDetector(
                    onTap: () => REYImagePreviewDialog.showData(
                      context: context,
                      imageData: transaction.photos.first,
                    ),
                    child: REYBase64ImagePreview(
                      imageData: transaction.photos.first,
                      borderRadius: BorderRadius.circular(REYSizes.sm),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: REYSizes.spaceBtwSections),
            ],

            // Confirmation Button for Pending Transactions
            if (transaction.status == 'PENDING' &&
                (userRole == 'PETUGAS' || userRole == 'ADMIN'))
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    // Implement confirmation logic here
                  },
                  child: Text('confirmTransaction'.tr),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
