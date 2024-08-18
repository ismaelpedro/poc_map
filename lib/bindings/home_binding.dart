// bindings/home_binding.dart
import 'package:get/get.dart';
import '../controllers/location_controller.dart';
import '../controllers/poi_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LocationController>(() => LocationController());
    Get.lazyPut<POIController>(() => POIController());
  }
}
