import 'package:eco_waste/common/widgets/appbar.dart';
import 'package:eco_waste/features/personalization/controllers/user_list_controller.dart';
import 'package:eco_waste/features/personalization/screens/settings/widgets/user_list_card.dart';
import 'package:eco_waste/utils/constants/colors.dart';
import 'package:eco_waste/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class UserListScreen extends StatelessWidget {
  const UserListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final UserListController userController = Get.put(UserListController());

    // Fetch users when screen is built
    WidgetsBinding.instance.addPostFrameCallback((_) {
      userController.fetchUsersList();
    });

    return Scaffold(
      appBar: REYAppBar(
        showBackArrow: true,
        title: Text(
          'users'.tr,
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
      body: Obx(() {
        // Loading State
        if (userController.isLoading.value) {
          return const Center(
            child: CircularProgressIndicator(color: REYColors.primary),
          );
        }

        // Empty State
        if (userController.usersList.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Iconsax.people,
                  size: REYSizes.iconLg,
                  color: REYColors.grey,
                ),
                const SizedBox(height: REYSizes.spaceBtwItems),
                Text(
                  'no_users_found'.tr,
                  style: Theme.of(
                    context,
                  ).textTheme.titleMedium?.copyWith(color: REYColors.darkGrey),
                ),
                const SizedBox(height: REYSizes.spaceBtwItems / 2),
                Text(
                  'no_users_description'.tr,
                  style: Theme.of(
                    context,
                  ).textTheme.bodyMedium?.copyWith(color: REYColors.grey),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: REYSizes.spaceBtwSections),
                ElevatedButton.icon(
                  onPressed: () => userController.fetchUsersList(),
                  icon: const Icon(Iconsax.refresh),
                  label: Text('refresh'.tr),
                ),
              ],
            ),
          );
        }

        // Users List
        return RefreshIndicator(
          onRefresh: userController.fetchUsersList,
          color: REYColors.primary,
          child: Column(
            children: [
              // Users List
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.all(REYSizes.defaultSpace),
                  itemCount: userController.usersList.length,
                  itemBuilder: (context, index) {
                    final user = userController.usersList[index];
                    return UserListCard(
                      user: user,
                      rank: index + 1,
                      onTap: () {},
                    );
                  },
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
