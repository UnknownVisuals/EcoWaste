import 'package:eco_waste/common/widgets/appbar.dart';
import 'package:eco_waste/common/widgets/product_card.dart';
import 'package:eco_waste/features/user/trash_bank/screens/poin_exchange/widgets/product_detail_page.dart';
import 'package:eco_waste/utils/constants/sizes.dart';
import 'package:eco_waste/utils/formatters/formatter.dart';
import 'package:flutter/material.dart';

class PoinExchangeScreen extends StatelessWidget {
  const PoinExchangeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final products = List.generate(
      10,
      (index) => {
        'name': 'Nama Produk $index',
        'price': REYFormatter.formatCurrency(100000 + index * 5000),
        'imageUrl': 'https://picsum.photos/400/40${index}',
      },
    );

    return Scaffold(
      appBar: REYAppBar(
        showBackArrow: true,
        title: Text(
          'Tukar Poin',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(REYSizes.defaultSpace),
        child: Column(
          children: [
            GridView.builder(
              itemCount: products.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: REYSizes.gridViewSpacing,
                mainAxisSpacing: REYSizes.gridViewSpacing,
                mainAxisExtent: 288,
              ),
              itemBuilder: (_, index) {
                final product = products[index];
                return REYProductCard(
                  name: product['name']!,
                  price: product['price']!,
                  imageUrl: product['imageUrl']!,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => ProductDetailsPage(
                          name: product['name']!,
                          price: product['price']!,
                          imageUrl: product['imageUrl']!,
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
