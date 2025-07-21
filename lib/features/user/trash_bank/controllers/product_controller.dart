import 'package:get/get.dart';

class ProductController extends GetxController {
  var items = <Map<String, String>>[].obs;

  void addToCart(Map<String, String> product) {
    items.add(product);
  }

  void removeFromCart(int index) {
    items.removeAt(index);
  }

  void clearCart() {
    items.clear();
  }

  int get itemCount => items.length;

  int get totalPrice {
    int total = 0;
    for (var item in items) {
      String? priceStr = item['price'];
      if (priceStr != null) {
        // Remove currency symbol and spaces
        priceStr = priceStr.replaceAll('Rp', '').replaceAll(' ', '');
        // Remove thousands separator
        priceStr = priceStr.replaceAll('.', '');
        // Replace comma with dot for decimal
        priceStr = priceStr.replaceAll(',', '.');
        // Parse as double, then round to int
        double value = double.tryParse(priceStr) ?? 0.0;
        total += value.round();
      }
    }
    return total;
  }
}
