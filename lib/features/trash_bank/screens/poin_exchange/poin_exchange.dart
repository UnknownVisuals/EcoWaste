import 'package:eco_waste/common/widgets/appbar.dart';
import 'package:eco_waste/common/widgets/product_card.dart';
import 'package:eco_waste/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class PoinExchangeScreen extends StatelessWidget {
  const PoinExchangeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: REYAppBar(
        showBackArrow: true,
        title: Text(
          'Tukar Poin',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          itemCount: 10,
          shrinkWrap: true,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: REYSizes.gridViewSpacing,
            crossAxisSpacing: REYSizes.gridViewSpacing,
            mainAxisExtent: 270,
          ),
          itemBuilder: (context, index) {
            return REYProductCard();
          },
        ),
      ),
    );
  }
}
