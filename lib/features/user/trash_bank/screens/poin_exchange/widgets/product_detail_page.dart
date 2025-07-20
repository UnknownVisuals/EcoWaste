import 'package:eco_waste/common/widgets/appbar.dart';
import 'package:eco_waste/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

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
    return Scaffold(
      appBar: REYAppBar(
        showBackArrow: true,
        title: Text(name, style: Theme.of(context).textTheme.headlineSmall),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.network(
                imageUrl,
                height: 200,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: REYSizes.spaceBtwSections),

            // Product Name
            Text(name, style: Theme.of(context).textTheme.headlineSmall),
            const SizedBox(height: REYSizes.spaceBtwItems / 2),

            // Product Price
            Text(price, style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: REYSizes.spaceBtwItems / 2),

            // Product Description
            Text(
              'Deskripsi produk akan ditampilkan di sini. Ini adalah tempat untuk menjelaskan detail produk, fitur, dan manfaatnya.',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: REYSizes.spaceBtwSections),

            // Add to Cart Button
            ElevatedButton(
              onPressed: () {
                // Handle add to cart action
              },

              child: Text('Tambah ke Keranjang'),
            ),
          ],
        ),
      ),
    );
  }
}
