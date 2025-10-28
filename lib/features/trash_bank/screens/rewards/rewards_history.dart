import 'package:eco_waste/common/widgets/appbar.dart';
import 'package:eco_waste/common/widgets/chip_filter.dart';
import 'package:eco_waste/features/trash_bank/controllers/rewards_controller.dart';
import 'package:eco_waste/features/trash_bank/models/rewards_history_model.dart';
import 'package:eco_waste/utils/constants/colors.dart';
import 'package:eco_waste/utils/constants/sizes.dart';
import 'package:eco_waste/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';

class RewardsHistoryScreen extends StatefulWidget {
  const RewardsHistoryScreen({super.key});

  @override
  State<RewardsHistoryScreen> createState() => _RewardsHistoryScreenState();
}

class _RewardsHistoryScreenState extends State<RewardsHistoryScreen> {
  late final RewardsController rewardsController;

  @override
  void initState() {
    rewardsController = Get.isRegistered<RewardsController>()
        ? Get.find<RewardsController>()
        : Get.put(RewardsController());
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      rewardsController.fetchRewardsHistory();
    });
  }

  Color _statusColor(String status) {
    switch (status.toUpperCase()) {
      case 'APPROVED':
        return REYColors.success;
      case 'REJECTED':
      case 'DECLINED':
        return REYColors.error;
      case 'PENDING':
      default:
        return REYColors.warning;
    }
  }

  String _statusLabel(String status) {
    final String normalized = status.replaceAll('_', ' ').toLowerCase();
    return normalized.capitalizeFirst ?? normalized;
  }

  @override
  Widget build(BuildContext context) {
    final bool dark = REYHelperFunctions.isDarkMode(context);
    final ThemeData theme = Theme.of(context);
    final NumberFormat pointsFormatter = NumberFormat.decimalPattern('id_ID');

    return Scaffold(
      appBar: REYAppBar(
        showBackArrow: true,
        title: Text(
          'rewardsHistoryTitle'.tr,
          style: theme.textTheme.headlineSmall,
        ),
      ),
      body: Obx(() {
        final bool isHistoryLoading = rewardsController.isHistoryLoading.value;
        final RxList<RewardsHistoryModel> history =
            rewardsController.filteredRewardsHistory;
        final RxList<RewardsHistoryModel> allHistory =
            rewardsController.rewardsHistory;
        final bool hasAnyHistory = allHistory.isNotEmpty;

        return Column(
          children: [
            _buildFilterBar(),
            Expanded(
              child: isHistoryLoading && !hasAnyHistory
                  ? const Center(
                      child: CircularProgressIndicator(
                        color: REYColors.primary,
                      ),
                    )
                  : RefreshIndicator(
                      color: REYColors.primary,
                      onRefresh: () => rewardsController.fetchRewardsHistory(
                        forceRefresh: true,
                      ),
                      child: history.isEmpty
                          ? ListView(
                              physics: const AlwaysScrollableScrollPhysics(),
                              padding: const EdgeInsets.all(
                                REYSizes.defaultSpace,
                              ),
                              children: [
                                const SizedBox(
                                  height: REYSizes.spaceBtwSections,
                                ),
                                Icon(
                                  hasAnyHistory ? Iconsax.filter : Iconsax.gift,
                                  size: REYSizes.iconLg * 2,
                                  color: dark
                                      ? REYColors.darkGrey
                                      : REYColors.grey,
                                ),
                                const SizedBox(
                                  height: REYSizes.spaceBtwSections / 1.5,
                                ),
                                Text(
                                  hasAnyHistory
                                      ? 'noDataFound'.tr
                                      : 'rewardsHistoryEmptyTitle'.tr,
                                  textAlign: TextAlign.center,
                                  style: theme.textTheme.titleLarge,
                                ),
                                const SizedBox(height: REYSizes.sm),
                                Text(
                                  hasAnyHistory
                                      ? 'trySelectingDifferentFilter'.tr
                                      : 'rewardsHistoryEmptySubtitle'.tr,
                                  textAlign: TextAlign.center,
                                  style: theme.textTheme.bodyMedium,
                                ),
                              ],
                            )
                          : ListView.separated(
                              physics: const AlwaysScrollableScrollPhysics(),
                              padding: const EdgeInsets.all(
                                REYSizes.defaultSpace,
                              ),
                              itemBuilder: (context, index) {
                                final RewardsHistoryModel historyItem =
                                    history[index];
                                final Color statusColor = _statusColor(
                                  historyItem.status,
                                );
                                final DateTime? redeemedAt =
                                    historyItem.redeemedAt;
                                final String formattedDate = redeemedAt != null
                                    ? REYHelperFunctions.getFormattedDate(
                                        redeemedAt,
                                        format: 'dd MMM yyyy, HH:mm',
                                      )
                                    : 'dateNotAvailable'.tr;

                                return Container(
                                  padding: const EdgeInsets.all(REYSizes.md),
                                  decoration: BoxDecoration(
                                    color: dark
                                        ? REYColors.dark
                                        : REYColors.light,
                                    borderRadius: BorderRadius.circular(
                                      REYSizes.cardRadiusMd,
                                    ),
                                    border: Border.all(
                                      color: dark
                                          ? REYColors.darkerGrey
                                          : REYColors.grey,
                                    ),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Expanded(
                                            child: Text(
                                              historyItem.reward.name,
                                              style:
                                                  theme.textTheme.titleMedium,
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                          Container(
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: REYSizes.sm,
                                              vertical: REYSizes.xs,
                                            ),
                                            decoration: BoxDecoration(
                                              color: statusColor.withOpacity(
                                                dark ? 0.25 : 0.15,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(
                                                    REYSizes.borderRadiusMd,
                                                  ),
                                              border: Border.all(
                                                color: statusColor,
                                              ),
                                            ),
                                            child: Text(
                                              _statusLabel(historyItem.status),
                                              style: theme.textTheme.labelMedium
                                                  ?.copyWith(
                                                    color: statusColor,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: REYSizes.spaceBtwItems / 1.5,
                                      ),
                                      Row(
                                        children: [
                                          const Icon(
                                            Iconsax.coin_1,
                                            size: REYSizes.iconSm,
                                            color: REYColors.primary,
                                          ),
                                          const SizedBox(width: REYSizes.xs),
                                          Text(
                                            '${pointsFormatter.format(historyItem.pointsSpent)} ${'points'.tr}',
                                            style: theme.textTheme.bodyMedium
                                                ?.copyWith(
                                                  fontWeight: FontWeight.w600,
                                                ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: REYSizes.xs),
                                      Row(
                                        children: [
                                          Icon(
                                            Iconsax.calendar_1,
                                            size: REYSizes.iconSm,
                                            color: dark
                                                ? REYColors.lightGrey
                                                : REYColors.darkGrey,
                                          ),
                                          const SizedBox(width: REYSizes.xs),
                                          Text(
                                            formattedDate,
                                            style: theme.textTheme.bodySmall,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                );
                              },
                              separatorBuilder: (_, __) => const SizedBox(
                                height: REYSizes.spaceBtwItems,
                              ),
                              itemCount: history.length,
                            ),
                    ),
            ),
          ],
        );
      }),
    );
  }

  Widget _buildFilterBar() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: REYSizes.spaceBtwItems),
      child: Obx(
        () => SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              const SizedBox(width: REYSizes.spaceBtwItems),
              REYChipFilter(
                chipFilterString: 'all'.tr,
                chipFilterColor: REYColors.info,
                chipFilterIcon: Iconsax.filter,
                isSelected:
                    rewardsController.selectedHistoryFilter.value == 'ALL',
                onTap: () => rewardsController.setHistoryFilter('ALL'),
              ),
              const SizedBox(width: REYSizes.spaceBtwItems),
              REYChipFilter(
                chipFilterString: 'approved'.tr,
                chipFilterColor: REYColors.success,
                chipFilterIcon: Iconsax.tick_square,
                isSelected:
                    rewardsController.selectedHistoryFilter.value == 'APPROVED',
                onTap: () => rewardsController.setHistoryFilter('APPROVED'),
              ),
              const SizedBox(width: REYSizes.spaceBtwItems),
              REYChipFilter(
                chipFilterString: 'pending'.tr,
                chipFilterColor: REYColors.warning,
                chipFilterIcon: Iconsax.clock,
                isSelected:
                    rewardsController.selectedHistoryFilter.value == 'PENDING',
                onTap: () => rewardsController.setHistoryFilter('PENDING'),
              ),
              const SizedBox(width: REYSizes.spaceBtwItems),
            ],
          ),
        ),
      ),
    );
  }
}
