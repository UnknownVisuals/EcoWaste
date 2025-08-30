import 'package:eco_waste/common/widgets/appbar.dart';
import 'package:eco_waste/features/user/trash_bank/controllers/transactions_controller.dart';
import 'package:eco_waste/features/user/trash_bank/models/transaction_model.dart';
import 'package:eco_waste/utils/constants/colors.dart';
import 'package:eco_waste/utils/constants/sizes.dart';
import 'package:eco_waste/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';

class TransactionDetailScreen extends StatelessWidget {
  const TransactionDetailScreen({super.key, required this.transaction});

  final TransactionModel transaction;

  /// Safely parse color string to Color object
  Color _parseColor(String colorString) {
    try {
      if (colorString.isEmpty) return REYColors.primary;

      // Remove # if present and add 0xFF prefix
      String cleanColor = colorString.replaceFirst('#', '');

      // Ensure it's a valid hex color (6 characters)
      if (cleanColor.length == 6) {
        return Color(int.parse('0xFF$cleanColor', radix: 16));
      } else if (cleanColor.length == 8) {
        // Handle ARGB format
        return Color(int.parse('0x$cleanColor', radix: 16));
      } else {
        return REYColors.primary; // fallback
      }
    } catch (e) {
      // If any parsing error occurs, return default color
      return REYColors.primary;
    }
  }

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
        statusText = 'Pending';
        break;
      case 'COMPLETED':
        statusColor = REYColors.success;
        statusIcon = Iconsax.tick_circle;
        statusText = 'Completed';
        break;
      case 'CANCELLED':
        statusColor = REYColors.error;
        statusIcon = Iconsax.close_circle;
        statusText = 'Cancelled';
        break;
      default:
        statusColor = REYColors.grey;
        statusIcon = Iconsax.info_circle;
        statusText = transaction.status;
    }

    return Scaffold(
      appBar: REYAppBar(
        title: Text(
          'Transaction Detail',
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
                color: statusColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(REYSizes.cardRadiusMd),
                border: Border.all(color: statusColor.withOpacity(0.3)),
              ),
              child: Row(
                children: [
                  Icon(statusIcon, color: statusColor, size: 24),
                  const SizedBox(width: REYSizes.sm),
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

            // Transaction Info
            _buildInfoSection(context, 'Transaction Information', [
              _buildInfoRow('Transaction ID', transaction.id),
              _buildInfoRow(
                'Type',
                transaction.type == 'PICKUP' ? 'Pickup' : 'Drop Off',
              ),
              _buildInfoRow(
                'Scheduled Date',
                DateFormat(
                  'dd MMM yyyy, HH:mm',
                ).format(transaction.scheduledDate),
              ),
              _buildInfoRow(
                'Created Date',
                DateFormat('dd MMM yyyy, HH:mm').format(transaction.createdAt),
              ),
              if (transaction.completedDate != null)
                _buildInfoRow(
                  'Completed Date',
                  DateFormat(
                    'dd MMM yyyy, HH:mm',
                  ).format(transaction.completedDate!),
                ),
            ]),

            // Location Info
            _buildInfoSection(context, 'Location Information', [
              _buildInfoRow('Location Detail', transaction.locationDetail),
            ]),

            // Waste Category Info
            if (transaction.wasteCategory != null) ...[
              _buildInfoSection(context, 'Waste Category', [
                _buildInfoRow('Category', transaction.wasteCategory!.name),
                _buildInfoRow(
                  'Description',
                  transaction.wasteCategory!.description,
                ),
                _buildInfoRow(
                  'Points per Kg',
                  '${transaction.wasteCategory!.pointsPerKg}',
                ),
                Row(
                  children: [
                    Text(
                      'Color: ',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Container(
                      width: 20,
                      height: 20,
                      decoration: BoxDecoration(
                        color: _parseColor(transaction.wasteCategory!.color),
                        shape: BoxShape.circle,
                        border: Border.all(color: REYColors.grey),
                      ),
                    ),
                    const SizedBox(width: REYSizes.sm),
                    Text(
                      transaction.wasteCategory!.color,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
              ]),
            ],

            // User Info
            if (transaction.user != null) ...[
              _buildInfoSection(context, 'User Information', [
                _buildInfoRow('Name', transaction.user!.name),
                _buildInfoRow('User ID', transaction.user!.id),
              ]),
            ],

            // Results (for completed transactions)
            if (transaction.status == 'COMPLETED') ...[
              _buildInfoSection(context, 'Transaction Results', [
                if (transaction.actualWeight != null)
                  _buildInfoRow(
                    'Actual Weight',
                    '${transaction.actualWeight!.toStringAsFixed(2)} kg',
                  ),
                if (transaction.points != null)
                  Row(
                    children: [
                      Text(
                        'Points Earned: ',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Icon(Iconsax.coin_1, size: 16, color: REYColors.primary),
                      const SizedBox(width: REYSizes.xs),
                      Text(
                        transaction.points.toString(),
                        style: Theme.of(context).textTheme.titleMedium
                            ?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: REYColors.primary,
                            ),
                      ),
                    ],
                  ),
                if (transaction.notes != null && transaction.notes!.isNotEmpty)
                  _buildInfoRow('Notes', transaction.notes!),
              ]),
            ],

            // Photos
            if (transaction.photos.isNotEmpty) ...[
              const SizedBox(height: REYSizes.spaceBtwSections),
              Text(
                'Photos',
                style: Theme.of(
                  context,
                ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: REYSizes.spaceBtwItems),
              SizedBox(
                height: 100,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: transaction.photos.length,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: EdgeInsets.only(
                        right: index < transaction.photos.length - 1
                            ? REYSizes.sm
                            : 0,
                      ),
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(REYSizes.sm),
                        border: Border.all(color: REYColors.grey),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(REYSizes.sm),
                        child:
                            transaction.photos[index].startsWith('data:image')
                            ? Container(
                                color: REYColors.grey.withOpacity(0.3),
                                child: const Icon(
                                  Icons.image,
                                  color: REYColors.grey,
                                ),
                              )
                            : Image.network(
                                transaction.photos[index],
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                                  return Container(
                                    color: REYColors.grey.withOpacity(0.3),
                                    child: const Icon(
                                      Icons.broken_image,
                                      color: REYColors.grey,
                                    ),
                                  );
                                },
                              ),
                      ),
                    );
                  },
                ),
              ),
            ],

            // Action buttons for pending transactions
            if (transaction.status.toUpperCase() == 'PENDING') ...[
              const SizedBox(height: REYSizes.spaceBtwSections),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () async {
                        final controller = Get.find<TransactionController>();
                        await controller.cancelTransaction(transaction.id);
                        Get.back(); // Go back after action
                      },
                      icon: const Icon(
                        Iconsax.close_circle,
                        color: REYColors.error,
                      ),
                      label: Text(
                        'cancel'.tr,
                        style: TextStyle(color: REYColors.error),
                      ),
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: REYColors.error),
                        padding: const EdgeInsets.symmetric(
                          vertical: REYSizes.md,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: REYSizes.spaceBtwItems),
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () async {
                        final controller = Get.find<TransactionController>();
                        await controller.processTransaction(transaction.id);
                        Get.back(); // Go back after action
                      },
                      icon: const Icon(
                        Iconsax.tick_circle,
                        color: REYColors.white,
                      ),
                      label: Text(
                        'confirm'.tr,
                        style: TextStyle(color: REYColors.white),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: REYColors.success,
                        padding: const EdgeInsets.symmetric(
                          vertical: REYSizes.md,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildInfoSection(
    BuildContext context,
    String title,
    List<Widget> children,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(
            context,
          ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: REYSizes.spaceBtwItems),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(REYSizes.md),
          decoration: BoxDecoration(
            color: REYHelperFunctions.isDarkMode(context)
                ? REYColors.dark
                : REYColors.light,
            borderRadius: BorderRadius.circular(REYSizes.cardRadiusMd),
            border: Border.all(
              color: REYHelperFunctions.isDarkMode(context)
                  ? REYColors.darkerGrey
                  : REYColors.grey.withOpacity(0.3),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: children
                .map(
                  (child) => Padding(
                    padding: const EdgeInsets.only(bottom: REYSizes.sm),
                    child: child,
                  ),
                )
                .toList(),
          ),
        ),
        const SizedBox(height: REYSizes.spaceBtwSections),
      ],
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Builder(
      builder: (context) => Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              '$label:',
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w500),
            ),
          ),
          Expanded(
            child: Text(value, style: Theme.of(context).textTheme.bodyMedium),
          ),
        ],
      ),
    );
  }
}
