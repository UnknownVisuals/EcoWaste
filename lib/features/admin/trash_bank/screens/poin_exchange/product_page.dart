import 'package:badges/badges.dart' as badges;
import 'package:eco_waste/common/widgets/appbar.dart';
import 'package:eco_waste/features/user/trash_bank/controllers/reward_controller.dart';
import 'package:eco_waste/features/user/trash_bank/models/reward_model.dart';
import 'package:eco_waste/features/user/trash_bank/screens/poin_exchange/widgets/product_card.dart'; // Ensure this path is correct
import 'package:eco_waste/features/user/trash_bank/screens/poin_exchange/widgets/cart_bottom_sheet.dart';
import 'package:eco_waste/features/user/trash_bank/screens/poin_exchange/product_details.dart';
import 'package:eco_waste/utils/constants/sizes.dart';
import 'package:eco_waste/utils/formatters/formatter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class ProductPageScreen extends StatelessWidget {
  const ProductPageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // FIX: Updated to use RewardController instead of ProductController
    final RewardController rewardController = Get.put(RewardController());
    final products = List.generate(
      10,
      (index) => {
        'name': 'Nama Produk $index',
        'price': REYFormatter.formatCurrency(10000 + index * 5000),
        'imageUrl': 'https://picsum.photos/400/40$index',
      },
    );

    return Scaffold(
      appBar: REYAppBar(
        showBackArrow: true,
        title: Text(
          'exchangePointsAction'.tr,
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        actions: [
          Obx(
            () => badges.Badge(
              position: badges.BadgePosition.topEnd(top: -4, end: 4),
              showBadge: rewardController.itemCount > 0,
              badgeContent: Text(
                rewardController.itemCount.toString(),
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
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(REYSizes.defaultSpace),
        child: GridView.builder(
          itemCount: products.length,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: REYSizes.gridViewSpacing,
            mainAxisSpacing: REYSizes.gridViewSpacing,
            mainAxisExtent: 262,
          ),
          itemBuilder: (_, index) {
            final product = products[index];
            return ProductCard(
              name: product['name']!,
              price: product['price']!,
              imageUrl: product['imageUrl']!,
              onTap: () => Get.to(
                () => ProductDetailsPage(
                  name: product['name']!,
                  price: product['price']!,
                  imageUrl: product['imageUrl']!,
                ),
              ),
              onAddToCart: () {
                // Create RewardModel from product data
                final reward = RewardModel(
                  id: DateTime.now().millisecondsSinceEpoch.toString(),
                  name: product['name']!,
                  pointsRequired:
                      10000 +
                      index *
                          5000, // Extract numeric value from formatted price
                  description: 'Sample product description',
                  imageUrl: product['imageUrl'],
                  category: 'General',
                  stock: 10,
                  isActive: true,
                );
                rewardController.addToCart(reward);
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  builder: (_) => const CartBottomSheet(),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
