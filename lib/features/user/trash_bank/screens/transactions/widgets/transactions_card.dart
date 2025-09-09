import 'package:eco_waste/features/user/trash_bank/models/transactions_model.dart';
import 'package:eco_waste/features/user/trash_bank/screens/transactions/transactions_detail.dart';
import 'package:eco_waste/utils/constants/colors.dart';
import 'package:eco_waste/utils/constants/sizes.dart';
import 'package:eco_waste/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';

class TransactionCard extends StatelessWidget {
  const TransactionCard({super.key, required this.transaction});

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
    final dark = REYHelperFunctions.isDarkMode(context);

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
      case 'CANCELLED':
        statusColor = REYColors.error;
        statusIcon = Iconsax.close_circle;
        statusText = 'cancelled'.tr;
        break;
      default:
        statusColor = REYColors.grey;
        statusIcon = Iconsax.info_circle;
        statusText = transaction.status;
    }

    return GestureDetector(
      onTap: () {
        Get.to(() => TransactionDetailScreen(transaction: transaction));
      },
      child: Container(
        padding: const EdgeInsets.all(REYSizes.md),
        decoration: BoxDecoration(
          color: dark ? REYColors.dark : REYColors.light,
          border: Border.all(
            color: dark ? REYColors.darkerGrey : REYColors.grey,
          ),
          borderRadius: BorderRadius.circular(REYSizes.cardRadiusMd),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Transaction Type
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: REYSizes.md,
                    vertical: REYSizes.sm,
                  ),
                  decoration: BoxDecoration(
                    color: transaction.type == 'PICKUP'
                        ? REYColors.primary.withValues(alpha: 0.1)
                        : REYColors.secondary.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(REYSizes.sm),
                  ),
                  child: Text(
                    transaction.type == 'PICKUP' ? 'pickUp'.tr : 'dropOff'.tr,
                    style: Theme.of(context).textTheme.labelMedium?.copyWith(
                      color: transaction.type == 'PICKUP'
                          ? REYColors.primary
                          : REYColors.secondary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                // Status
                Row(
                  children: [
                    Icon(statusIcon, size: REYSizes.iconSm, color: statusColor),
                    const SizedBox(width: REYSizes.spaceBtwItems / 2),
                    Text(
                      statusText,
                      style: Theme.of(context).textTheme.labelMedium?.copyWith(
                        color: statusColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: REYSizes.spaceBtwItems),

            // Waste Category
            if (transaction.wasteCategory != null) ...[
              Row(
                children: [
                  Container(
                    width: 12,
                    height: 12,
                    decoration: BoxDecoration(
                      color: _parseColor(transaction.wasteCategory!.color),
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: REYSizes.spaceBtwItems),
                  Expanded(
                    child: Text(
                      transaction.wasteCategory!.name,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: REYSizes.sm),
            ],

            // Location Detail
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  Iconsax.location,
                  size: REYSizes.iconSm,
                  color: REYColors.darkGrey,
                ),
                const SizedBox(width: REYSizes.spaceBtwItems / 2),
                Expanded(
                  child: Text(
                    transaction.locationDetail,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
              ],
            ),
            const SizedBox(height: REYSizes.sm),

            // Scheduled Date
            Row(
              children: [
                Icon(
                  Iconsax.calendar,
                  size: REYSizes.iconSm,
                  color: REYColors.darkGrey,
                ),
                const SizedBox(width: REYSizes.spaceBtwItems / 2),
                Text(
                  DateFormat(
                    'dd MMM yyyy, HH:mm',
                  ).format(transaction.scheduledDate),
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),

            // Show additional info for completed transactions
            if (transaction.status == 'COMPLETED') ...[
              const SizedBox(height: REYSizes.sm),
              const Divider(),
              const SizedBox(height: REYSizes.sm),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Weight
                  if (transaction.actualWeight != null)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Weight',
                          style: Theme.of(context).textTheme.labelMedium,
                        ),
                        Text(
                          '${transaction.actualWeight!.toStringAsFixed(2)} kg',
                          style: Theme.of(context).textTheme.titleSmall
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  // Points
                  if (transaction.points != null)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          'pointsEarned'.tr,
                          style: Theme.of(context).textTheme.labelMedium,
                        ),
                        Row(
                          children: [
                            Icon(
                              Iconsax.coin_1,
                              size: REYSizes.iconSm,
                              color: REYColors.primary,
                            ),
                            const SizedBox(width: REYSizes.xs),
                            Text(
                              transaction.points.toString(),
                              style: Theme.of(context).textTheme.titleSmall
                                  ?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: REYColors.primary,
                                  ),
                            ),
                          ],
                        ),
                      ],
                    ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }
}
