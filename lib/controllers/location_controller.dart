import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

import '../services/location_service.dart';

class LocationController extends GetxController {
  var currentPosition = Rxn<Position>();
  final LocationService _locationService = LocationService();

  @override
  void onInit() {
    getCurrentLocation();
    super.onInit();
  }

  void getCurrentLocation() async {
    currentPosition.value = await _locationService.getCurrentLocation();
  }
}
