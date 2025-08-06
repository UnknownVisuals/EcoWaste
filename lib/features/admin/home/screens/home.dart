import 'package:eco_waste/common/widgets/appbar.dart';
import 'package:eco_waste/common/widgets/primary_header_container.dart';
import 'package:eco_waste/common/widgets/section_heading.dart';
import 'package:eco_waste/features/authentication/models/user_model.dart';
import 'package:eco_waste/utils/constants/sizes.dart';
import 'package:eco_waste/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:get/get.dart';

class AdminHomeScreen extends StatelessWidget {
  const AdminHomeScreen({super.key, required this.userModel});

  final UserModel userModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Header
          REYPrimaryHeaderContainer(
            child: Column(
              children: [
                REYAppBar(
                  title: Text(
                    'dashboard'.tr,
                    style: Theme.of(
                      context,
                    ).textTheme.headlineMedium!.copyWith(color: Colors.white),
                  ),
                ),
                const SizedBox(height: REYSizes.spaceBtwSections),

                // Admin Stats Cards
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: REYSizes.defaultSpace,
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: _buildStatCard(
                          context,
                          'totalUsers'.tr,
                          '150',
                          Iconsax.people,
                          REYColors.primary,
                        ),
                      ),
                      const SizedBox(width: REYSizes.spaceBtwItems),
                      Expanded(
                        child: _buildStatCard(
                          context,
                          'wasteCollected'.tr,
                          '2.5 Ton',
                          Iconsax.trash,
                          REYColors.success,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: REYSizes.spaceBtwItems),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: REYSizes.defaultSpace,
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: _buildStatCard(
                          context,
                          'pendingConfirmation'.tr,
                          '12',
                          Iconsax.clock,
                          REYColors.warning,
                        ),
                      ),
                      const SizedBox(width: REYSizes.spaceBtwItems),
                      Expanded(
                        child: _buildStatCard(
                          context,
                          'pointsToday'.tr,
                          '1,250',
                          Iconsax.coin,
                          REYColors.info,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: REYSizes.spaceBtwSections),
              ],
            ),
          ),

          // Body
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(REYSizes.defaultSpace),
              child: Column(
                children: [
                  // Quick Actions
                  REYSectionHeading(
                    title: 'quickActions'.tr,
                    showActionButton: false,
                  ),
                  const SizedBox(height: REYSizes.spaceBtwItems),
                  Row(
                    children: [
                      Expanded(
                        child: _buildActionCard(
                          context,
                          'confirmDeposit'.tr,
                          Iconsax.check,
                          REYColors.primary,
                          () {},
                        ),
                      ),
                      const SizedBox(width: REYSizes.spaceBtwItems),
                      Expanded(
                        child: _buildActionCard(
                          context,
                          'manageUsers'.tr,
                          Iconsax.people,
                          REYColors.secondary,
                          () {},
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: REYSizes.spaceBtwItems),
                  Row(
                    children: [
                      Expanded(
                        child: _buildActionCard(
                          context,
                          'viewReports'.tr,
                          Iconsax.chart,
                          REYColors.success,
                          () {},
                        ),
                      ),
                      const SizedBox(width: REYSizes.spaceBtwItems),
                      Expanded(
                        child: _buildActionCard(
                          context,
                          'editRanking'.tr,
                          Iconsax.award,
                          REYColors.warning,
                          () {},
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: REYSizes.spaceBtwSections),

                  // Recent Activity
                  REYSectionHeading(
                    title: 'recentActivity'.tr,
                    showActionButton: true,
                    buttonTitle: 'viewAll'.tr,
                  ),
                  const SizedBox(height: REYSizes.spaceBtwItems),
                  Expanded(
                    child: ListView.builder(
                      itemCount: 5,
                      itemBuilder: (context, index) {
                        return _buildActivityItem(
                          context,
                          'User ${index + 1} menyetor sampah',
                          '${index + 1} menit yang lalu',
                          Iconsax.trash,
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(
    BuildContext context,
    String title,
    String value,
    IconData icon,
    Color color,
  ) {
    return Container(
      padding: const EdgeInsets.all(REYSizes.md),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(REYSizes.md),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 3,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(icon, color: color, size: 24),
              Text(
                value,
                style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                  color: color,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: REYSizes.xs),
          Text(
            title,
            style: Theme.of(
              context,
            ).textTheme.bodyMedium!.copyWith(color: Colors.grey[600]),
          ),
        ],
      ),
    );
  }

  Widget _buildActionCard(
    BuildContext context,
    String title,
    IconData icon,
    Color color,
    VoidCallback onTap,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(REYSizes.md),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(REYSizes.md),
          border: Border.all(color: color.withOpacity(0.3)),
        ),
        child: Column(
          children: [
            Icon(icon, color: color, size: 32),
            const SizedBox(height: REYSizes.xs),
            Text(
              title,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                color: color,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActivityItem(
    BuildContext context,
    String title,
    String time,
    IconData icon,
  ) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: REYColors.primary.withOpacity(0.1),
        child: Icon(icon, color: REYColors.primary, size: 20),
      ),
      title: Text(title),
      subtitle: Text(time),
      trailing: const Icon(Iconsax.arrow_right_3, size: 16),
    );
  }
}
