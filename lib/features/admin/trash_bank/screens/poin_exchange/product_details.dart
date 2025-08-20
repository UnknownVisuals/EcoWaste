import 'package:badges/badges.dart' as badges; // <-- Import the badges package
import 'package:eco_waste/common/widgets/appbar.dart';
import 'package:eco_waste/features/user/trash_bank/screens/poin_exchange/widgets/cart_bottom_sheet.dart';
import 'package:eco_waste/features/user/trash_bank/controllers/reward_controller.dart';
import 'package:eco_waste/features/user/trash_bank/models/reward_model.dart';
import 'package:eco_waste/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class ProductDetailsPage extends StatelessWidget {
  final String name;
  final String price;
  final String imageUrl;

  const ProductDetailsPage({
    super.key,
    required this.name,
    required this.price,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    final RewardController cartController = Get.find<RewardController>();

    return Scaffold(
      appBar: REYAppBar(
        showBackArrow: true,
        title: Text(name, style: Theme.of(context).textTheme.headlineSmall),
        actions: [
          Obx(
            () => badges.Badge(
              position: badges.BadgePosition.topEnd(top: -4, end: 4),
              showBadge: cartController.itemCount > 0,
              badgeContent: Text(
                cartController.itemCount.toString(),
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  color: Colors.white,
                  fontSize: 10,
                ),
              ),
              badgeAnimation: const badges.BadgeAnimation.scale(
                animationDuration: Duration(milliseconds: 150),
              ),
              child: IconButton(
                icon: const Icon(Iconsax.shopping_cart),
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    builder: (_) => const CartBottomSheet(),
                  );
                },
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(REYSizes.defaultSpace),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(REYSizes.cardRadiusLg),
              child: AspectRatio(
                aspectRatio: 16 / 9,
                child: Image.network(
                  imageUrl,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
            ),

            const SizedBox(height: REYSizes.spaceBtwItems),

            Text(name, style: Theme.of(context).textTheme.headlineSmall),
            Text(price, style: Theme.of(context).textTheme.titleMedium),

            const SizedBox(height: REYSizes.spaceBtwItems),

            Text(
              'Deskripsi produk akan ditampilkan di sini. Ini adalah tempat untuk menjelaskan detail produk, fitur, dan manfaatnya.',
              style: Theme.of(context).textTheme.bodyMedium,
            ),

            const SizedBox(height: REYSizes.spaceBtwSections),

            ElevatedButton(
              onPressed: () {
                final reward = RewardModel(
                  id: DateTime.now().millisecondsSinceEpoch.toString(),
                  name: name,
                  pointsRequired:
                      int.tryParse(price.replaceAll(RegExp(r'[^0-9]'), '')) ??
                      0,
                  imageUrl: imageUrl,
                );
                cartController.addToCart(reward);
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  builder: (_) => const CartBottomSheet(),
                );
              },
              child: const Text('Tambah ke Keranjang'),
            ),
          ],
        ),
      ),
    );
  }
}
