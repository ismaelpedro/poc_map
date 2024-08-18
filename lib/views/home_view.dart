import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:poc_map/models/poi_model.dart';

import '../controllers/location_controller.dart';
import '../controllers/poi_controller.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final locationController = Get.find<LocationController>();
    final poiController = Get.find<POIController>();

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("POC Map"),
      ),
      body: Obx(() {
        if (locationController.currentPosition.value == null) {
          return const Center(child: CircularProgressIndicator());
        }
        return SafeArea(
          child: GoogleMap(
            myLocationButtonEnabled: false,
            initialCameraPosition: CameraPosition(
              target: LatLng(
                locationController.currentPosition.value!.latitude,
                locationController.currentPosition.value!.longitude,
              ),
              zoom: 20,
            ),
            onTap: (LatLng position) {
              showDialog(
                context: context,
                builder: (context) {
                  final titleController = TextEditingController();
                  final descriptionController = TextEditingController();
                  final categoryController = TextEditingController();

                  return AlertDialog(
                    title: const Text('Adicionar POI'),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextField(
                          controller: titleController,
                          decoration: const InputDecoration(labelText: 'Título'),
                        ),
                        TextField(
                          controller: descriptionController,
                          decoration: const InputDecoration(labelText: 'Descrição'),
                        ),
                        TextField(
                          controller: categoryController,
                          decoration: const InputDecoration(labelText: 'Categoria'),
                        ),
                      ],
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          if (titleController.text.isEmpty ||
                              descriptionController.text.isEmpty ||
                              categoryController.text.isEmpty) {
                            return;
                          }
                          poiController.addPOI(
                            POI(
                              title: titleController.text,
                              description: descriptionController.text,
                              category: categoryController.text,
                              latitude: position.latitude,
                              longitude: position.longitude,
                            ),
                          );
                          Navigator.of(context).pop();
                        },
                        child: const Text('Adicionar'),
                      ),
                    ],
                  );
                },
              );
            },
            markers: {
              Marker(
                markerId: const MarkerId('current_location'),
                position: LatLng(
                  locationController.currentPosition.value!.latitude,
                  locationController.currentPosition.value!.longitude,
                ),
              ),
              ...poiController.pois.map((poi) {
                return Marker(
                  markerId: MarkerId(poi.id.toString()),
                  position: LatLng(poi.latitude, poi.longitude),
                  infoWindow: InfoWindow(
                    title: poi.title,
                    snippet: '${poi.category}: ${poi.description}',
                  ),
                  icon: BitmapDescriptor.defaultMarkerWithHue(
                    poi.category == 'Restaurante'
                        ? BitmapDescriptor.hueRed
                        : poi.category == 'Parque'
                            ? BitmapDescriptor.hueGreen
                            : BitmapDescriptor.hueBlue,
                  ),
                );
              }).toSet(),
            },
          ),
        );
      }),
    );
  }
}
