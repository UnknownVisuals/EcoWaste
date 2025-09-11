import 'package:eco_waste/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class TransactionsInfoRow extends StatelessWidget {
  const TransactionsInfoRow({
    super.key,
    required this.title,
    required this.value,
  });

  final String title, value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: REYSizes.xs),
      child: Row(
        children: [
          Expanded(
            flex: 4,
            child: Text(
              title,
              style: Theme.of(context).textTheme.bodySmall,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Expanded(
            flex: 6,
            child: Text(
              value,
              style: Theme.of(context).textTheme.bodyMedium,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
