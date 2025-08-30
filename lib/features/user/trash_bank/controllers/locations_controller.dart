import 'package:eco_waste/features/user/trash_bank/models/locations_model.dart';
import 'package:eco_waste/utils/http/http_client.dart';
import 'package:eco_waste/utils/popups/loaders.dart';
import 'package:get/get.dart';

class LocationsController extends GetxController {
  // Dependencies
  REYHttpHelper httpHelper = Get.put(REYHttpHelper());

  // Data variable
  RxList<LocationsModel> locations = <LocationsModel>[].obs;

  // States variable
  Rx<bool> isLoading = false.obs;

  // Helper method to get location by ID
  LocationsModel? getLocationById(String locationId) {
    try {
      return locations.firstWhere((location) => location.id == locationId);
    } catch (e) {
      return null; // Return null if location not found
    }
  }

  // Helper method to get formatted location name
  String getFormattedLocationName(String locationId) {
    final location = getLocationById(locationId);
    if (location != null) {
      return '${location.desa}, ${location.kecamatan}';
    }
    return locationId; // Fallback to ID if location not found
  }

  Future<void> fetchLocations() async {
    isLoading.value = true;

    try {
      final locationsResponse = await httpHelper.getRequest('locations');

      if (locationsResponse.statusCode == 200) {
        final responseBody = locationsResponse.body;

        if (responseBody['status'] == 'success') {
          final List<dynamic> locationJson = responseBody['data'];
          locations.value = locationJson
              .map((location) => LocationsModel.fromJson(location))
              .toList();
        } else {
          REYLoaders.errorSnackBar(
            title: responseBody['status'],
            message: responseBody['message'],
          );
        }
      } else {
        REYLoaders.errorSnackBar(
          title: locationsResponse.body['status'],
          message: locationsResponse.body['message'],
        );
      }
    } catch (e) {
      REYLoaders.errorSnackBar(title: 'Error', message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
