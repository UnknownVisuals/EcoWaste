import 'package:eco_waste/common/widgets/section_heading.dart';
import 'package:eco_waste/features/user/trash_bank/controllers/product_controller.dart';
import 'package:eco_waste/utils/constants/sizes.dart';
import 'package:eco_waste/utils/popups/loaders.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';

class CartBottomSheet extends StatelessWidget {
  const CartBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final ProductController cartController = Get.find<ProductController>();

    return Container(
      padding: const EdgeInsets.all(REYSizes.defaultSpace),
      child: Obx(() {
        if (cartController.items.isEmpty) {
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
                cartController.clearCart();
                Navigator.pop(context);
              },
            ),

            const SizedBox(height: REYSizes.spaceBtwItems),

            // -- Cart Items
            Flexible(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: cartController.items.length,
                itemBuilder: (context, index) {
                  final item = cartController.items[index];
                  return ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(
                        REYSizes.cardRadiusMd,
                      ),
                      child: Image.network(
                        item['imageUrl'] ?? '',
                        width: 48,
                        height: 48,
                        fit: BoxFit.cover,
                      ),
                    ),
                    title: Text(
                      item['name'] ?? '',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    subtitle: Text(
                      item['price'] ?? '',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    trailing: IconButton(
                      icon: const Icon(Iconsax.trash, color: Colors.red),
                      onPressed: () => cartController.removeFromCart(index),
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
                  '${cartController.itemCount}',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'totalPriceCart'.tr,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                Text(
                  NumberFormat.currency(
                    locale: 'id',
                    symbol: 'Rp',
                    decimalDigits: 2,
                  ).format(cartController.totalPrice),
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ],
            ),
            const SizedBox(height: REYSizes.spaceBtwItems / 2),
            const Divider(),

            const SizedBox(height: REYSizes.spaceBtwSections),

            // -- Checkout Button
            ElevatedButton(
              onPressed: () {
                Get.back();
                REYLoaders.errorSnackBar(
                  title: 'Checkout',
                  message: 'Fitur checkout belum diimplementasikan.',
                );
              },
              child: const Text('Checkout'),
            ),
            const SizedBox(height: REYSizes.spaceBtwSections * 2),
          ],
        );
      }),
    );
  }
}
