import 'package:eco_waste/common/widgets/appbar.dart';
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
      body: const Center(child: Text("Tukar Poin belum tersedia")),
    );
  }
}
