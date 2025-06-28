import 'package:eco_waste/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class ThemeTest extends StatefulWidget {
  const ThemeTest({super.key});

  @override
  State<ThemeTest> createState() => _ThemeTestState();
}

class _ThemeTestState extends State<ThemeTest> {
  bool _isChecked = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Theme Test')),
      body: Padding(
        padding: const EdgeInsets.all(REYSizes.defaultSpace),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'This is a themed text',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: REYSizes.spaceBtwItems),
            ElevatedButton(
              onPressed: () {},
              child: const Text('Elevated Button'),
            ),
            const SizedBox(height: REYSizes.spaceBtwItems),
            OutlinedButton(
              onPressed: () {},
              child: const Text('Outlined Button'),
            ),
            const SizedBox(height: REYSizes.spaceBtwItems),
            Checkbox(
              value: _isChecked,
              onChanged: (value) {
                setState(() {
                  _isChecked = value ?? false;
                });
              },
            ),
            const SizedBox(height: REYSizes.spaceBtwItems),
            Chip(label: const Text('Chip'), onDeleted: () {}),
            const SizedBox(height: REYSizes.spaceBtwItems),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Text Field',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: REYSizes.spaceBtwItems),
            BottomSheet(
              onClosing: () {},
              builder: (context) {
                return Container(
                  padding: const EdgeInsets.all(REYSizes.defaultSpace),
                  child: const Text('Bottom Sheet'),
                );
              },
            ),
            const SizedBox(height: REYSizes.spaceBtwItems),
          ],
        ),
      ),
    );
  }
}
