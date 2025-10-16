import 'dart:convert';
import 'package:eco_waste/features/authentication/controllers/user_controller.dart';
import 'package:eco_waste/features/trash_bank/controllers/locations_controller.dart';
import 'package:eco_waste/features/trash_bank/models/locations_model.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:latlong2/latlong.dart';

class AddressController extends GetxController {
  // Dependencies
  final UserController userController = Get.find<UserController>();
  final LocationsController locationsController =
      Get.find<LocationsController>();

  // State variables
  Rx<LatLng?> locationCoordinates = Rx<LatLng?>(null);
  Rx<bool> isLoadingLocation = true.obs;

  @override
  void onInit() {
    super.onInit();
    geocodeLocation();
  }

  Future<void> geocodeLocation() async {
    isLoadingLocation.value = true;

    try {
      final user = userController.userModel.value;
      final location = locationsController.getLocationById(user.locationId);

      if (location == null) {
        _setFallbackLocation();
        return;
      }

      // Build the search query
      final query =
          '${location.desa}, ${location.kecamatan}, ${location.kabupaten}, Indonesia';

      // Use Nominatim geocoding API
      final url = Uri.parse(
        'https://nominatim.openstreetmap.org/search?q=${Uri.encodeComponent(query)}&format=json&limit=1',
      );

      final response = await http.get(
        url,
        headers: {'User-Agent': 'EcoWaste App'},
      );

      if (response.statusCode == 200) {
        final List<dynamic> results = json.decode(response.body);

        if (results.isNotEmpty) {
          final lat = double.parse(results[0]['lat']);
          final lon = double.parse(results[0]['lon']);

          locationCoordinates.value = LatLng(lat, lon);
          isLoadingLocation.value = false;
        } else {
          _setFallbackLocation();
        }
      } else {
        _setFallbackLocation();
      }
    } catch (e) {
      _setFallbackLocation();
    }
  }

  void _setFallbackLocation() {
    // Fallback to Bandung if location not found or error occurs
    locationCoordinates.value = const LatLng(-6.9175, 107.6191);
    isLoadingLocation.value = false;
  }

  LocationsModel? getCurrentLocation() {
    final user = userController.userModel.value;
    return locationsController.getLocationById(user.locationId);
  }
}
