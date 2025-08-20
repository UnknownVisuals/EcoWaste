import 'package:eco_waste/common/widgets/section_heading.dart';
import 'package:eco_waste/features/user/trash_bank/controllers/reward_controller.dart';
import 'package:eco_waste/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class CartBottomSheet extends StatelessWidget {
  const CartBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final RewardController rewardController = Get.find<RewardController>();

    return Container(
      padding: const EdgeInsets.all(REYSizes.defaultSpace),
      child: Obx(() {
        if (rewardController.cartItems.isEmpty) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: REYSizes.spaceBtwSections),

              const Icon(
                Iconsax.shopping_cart,
                size: REYSizes.iconLg * 2,
                color: Colors.grey,
              ),
              const SizedBox(height: REYSizes.spaceBtwItems),
              Text(
                'Keranjang Anda kosong',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: REYSizes.spaceBtwItems),
              Text(
                'Tambahkan produk ke keranjang untuk melanjutkan.',
                style: Theme.of(context).textTheme.bodyMedium,
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: REYSizes.spaceBtwSections * 2),
            ],
          );
        }
        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // -- Title
            REYSectionHeading(
              title: 'Keranjang Anda',
              showActionButton: true,
              buttonTitle: 'Hapus semua',
              onPressed: () {
                rewardController.clearCart();
                Navigator.pop(context);
              },
            ),

            const SizedBox(height: REYSizes.spaceBtwItems),

            // -- Cart Items
            Flexible(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: rewardController.cartItems.length,
                itemBuilder: (context, index) {
                  final reward = rewardController.cartItems[index];
                  return ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(
                        REYSizes.cardRadiusMd,
                      ),
                      child: Image.network(
                        reward.imageUrl ?? 'https://picsum.photos/48/48',
                        width: 48,
                        height: 48,
                        fit: BoxFit.cover,
                      ),
                    ),
                    title: Text(
                      reward.name,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    subtitle: Text(
                      '${reward.pointsRequired} pts',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    trailing: IconButton(
                      icon: const Icon(Iconsax.trash, color: Colors.red),
                      onPressed: () => rewardController.removeFromCart(index),
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: REYSizes.spaceBtwItems),

            // -- Summary
            const Divider(),
            const SizedBox(height: REYSizes.spaceBtwItems / 2),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Total item:',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                Text(
                  '${rewardController.itemCount}',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Total Poin:',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                Text(
                  '${rewardController.totalPointsRequired} pts',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ],
            ),
            const SizedBox(height: REYSizes.spaceBtwItems / 2),
            const Divider(),

            const SizedBox(height: REYSizes.spaceBtwSections),

            // -- Checkout Button
            ElevatedButton(
              onPressed: rewardController.canRedeemCart
                  ? () {
                      Get.back();
                      rewardController.redeemCartItems();
                    }
                  : null,
              child: Text(
                rewardController.canRedeemCart
                    ? 'Tukar Poin'
                    : 'Poin Tidak Cukup',
              ),
            ),
            const SizedBox(height: REYSizes.spaceBtwSections * 2),
          ],
        );
      }),
    );
  }
}
