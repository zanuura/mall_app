import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:mall_mobile_test/core/constants/app_colors.dart';

class MapBox extends StatelessWidget {
  final LatLng? initialCenter;
  const MapBox({super.key, this.initialCenter});

  // final MapController _mapController = MapController();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        // color: AppColors.lightGrey,
      ),
      child: FlutterMap(
        // mapController: _mapController,
        options: MapOptions(
          initialCenter:
              initialCenter ?? LatLng(0.7893, 113.9213), // Koordinat default
          initialZoom: 8.0,
          minZoom: 4.0,
          backgroundColor: AppColors.lightGrey,
          interactionOptions: InteractionOptions(),
        ),
        children: [
          TileLayer(
            // urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
            urlTemplate: "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
            userAgentPackageName: 'com.example.mall_mobile_test',
            // subdomains: const ['a', 'b', 'c'],
          ),
          MarkerLayer(
            markers: [
              Marker(
                point: initialCenter ?? LatLng(0.7893, 113.9213),
                child: Icon(
                  Icons.location_on_rounded,
                  color: AppColors.primaryGreen,
                  size: 40,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
