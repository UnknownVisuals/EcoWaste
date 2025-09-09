import 'dart:convert';
import 'dart:typed_data';
import 'package:eco_waste/common/widgets/appbar.dart';
import 'package:eco_waste/common/widgets/image_preview_dialog.dart';
import 'package:eco_waste/common/widgets/section_heading.dart';
import 'package:eco_waste/features/user/trash_bank/models/transactions_model.dart';
import 'package:eco_waste/features/user/trash_bank/screens/transactions/widgets/transactions_info_row.dart';
import 'package:eco_waste/utils/constants/colors.dart';
import 'package:eco_waste/utils/constants/sizes.dart';
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
            REYSectionHeading(title: 'Transaction Information'),
            const SizedBox(height: REYSizes.spaceBtwItems),
            TransactionsInfoRow(title: 'Transaction ID', value: transaction.id),
            TransactionsInfoRow(
              title: 'Type',
              value: transaction.type == 'PICKUP' ? 'pickUp'.tr : 'dropOff'.tr,
            ),
            TransactionsInfoRow(
              title: 'Scheduled Date',
              value: DateFormat(
                'dd MMM yyyy, HH:mm',
              ).format(transaction.scheduledDate),
            ),
            TransactionsInfoRow(
              title: 'Created Date',
              value: DateFormat(
                'dd MMM yyyy, HH:mm',
              ).format(transaction.createdAt),
            ),
            if (transaction.completedDate != null)
              TransactionsInfoRow(
                title: 'Completed Date',
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
            if (transaction.wasteCategory != null) ...[
              REYSectionHeading(title: 'Waste Category'),
              const SizedBox(height: REYSizes.spaceBtwItems),
              TransactionsInfoRow(
                title: 'Category',
                value: transaction.wasteCategory!.name,
              ),
              TransactionsInfoRow(
                title: 'Description',
                value: transaction.wasteCategory!.description,
              ),
              TransactionsInfoRow(
                title: 'Points per Kg',
                value: '${transaction.wasteCategory!.pointsPerKg}',
              ),
              TransactionsInfoRow(
                title: 'Color',
                value: transaction.wasteCategory!.color,
              ),
            ],

            const SizedBox(height: REYSizes.spaceBtwSections),

            // User Information
            if (transaction.user != null) ...[
              REYSectionHeading(title: 'User Information'),
              const SizedBox(height: REYSizes.spaceBtwItems),
              TransactionsInfoRow(title: 'Name', value: transaction.user!.name),
              TransactionsInfoRow(
                title: 'User ID',
                value: transaction.user!.id,
              ),
            ],

            const SizedBox(height: REYSizes.spaceBtwSections),

            // Transaction Results (for completed transactions)
            if (transaction.status == 'COMPLETED') ...[
              REYSectionHeading(title: 'Transaction Results'),
              const SizedBox(height: REYSizes.spaceBtwItems),
              if (transaction.actualWeight != null)
                TransactionsInfoRow(
                  title: 'actualWeight'.tr,
                  value:
                      '${transaction.actualWeight!.toStringAsFixed(2)} ${'kg'.tr}',
                ),
              if (transaction.points != null)
                TransactionsInfoRow(
                  title: 'pointsEarned'.tr,
                  value: transaction.points.toString(),
                ),
              if (transaction.notes != null && transaction.notes!.isNotEmpty)
                TransactionsInfoRow(title: 'Notes', value: transaction.notes!),
              const SizedBox(height: REYSizes.spaceBtwSections),
            ],

            // Photos
            if (transaction.photos.isNotEmpty) ...[
              REYSectionHeading(title: 'Photos'),
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
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(REYSizes.sm),
                      child: _buildImageThumbnail(transaction.photos.first),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: REYSizes.spaceBtwSections),
            ],
          ],
        ),
      ),
    );
  }

  /// Build image thumbnail that handles both File and base64/network images
  Widget _buildImageThumbnail(String imageData) {
    if (imageData.startsWith('data:image')) {
      // Handle base64 images
      try {
        final base64String = imageData.split(',').last;
        final Uint8List bytes = base64Decode(base64String);
        return Image.memory(
          bytes,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return Container(
              color: REYColors.grey.withValues(alpha: 0.3),
              child: const Center(
                child: Icon(Iconsax.image, color: REYColors.grey, size: 48),
              ),
            );
          },
        );
      } catch (e) {
        return Container(
          color: REYColors.grey.withValues(alpha: 0.3),
          child: const Center(
            child: Icon(Iconsax.image, color: REYColors.grey, size: 48),
          ),
        );
      }
    } else {
      // Handle network images
      return Image.network(
        imageData,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return Container(
            color: REYColors.grey.withValues(alpha: 0.3),
            child: const Center(
              child: Icon(Iconsax.image, color: REYColors.grey, size: 48),
            ),
          );
        },
      );
    }
  }
}
