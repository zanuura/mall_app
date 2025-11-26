// lib/features/location/presentation/widgets/location_section.dart
import 'package:flutter/material.dart';
import 'package:mall_mobile_test/core/constants/app_colors.dart';
import 'package:mall_mobile_test/core/constants/app_text_styles.dart';
import 'package:mall_mobile_test/core/constants/app_assets.dart';
import 'package:mall_mobile_test/core/widgets/maps/map_box.dart';
import 'package:mall_mobile_test/features/home/domain/entities/location_entity.dart';

class LocationSection extends StatelessWidget {
  final List<LocationDetail> locations;
  // final String mapImagePath; // Asset path untuk gambar peta

  const LocationSection({
    super.key,
    required this.locations,
    // required this.mapImagePath,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 24),
        // Header
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Text(
            'LOCATION',
            style: AppTextStyles.subtitle.copyWith(color: AppColors.grey),
          ),
        ),

        // Map Image (Placeholder)
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: MapBox(),
            // child: Image.asset(
            //   mapImagePath,
            //   fit: BoxFit.cover,
            //   // Asumsi tinggi peta tetap
            //   height: 180,
            //   width: double.infinity,
            // ),
          ),
        ),

        // List of Location Details
        ...locations.map((loc) => _LocationCard(detail: loc)).toList(),
      ],
    );
  }
}

class _LocationCard extends StatelessWidget {
  final LocationDetail detail;

  const _LocationCard({required this.detail});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Location Name
          Text(
            detail.name,
            style: AppTextStyles.subtitle.copyWith(color: AppColors.black),
          ),
          const SizedBox(height: 8),

          // Address
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(
                AppAssets.icLocation,
                width: 16,
                height: 16,
                color: AppColors.primaryGreen,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  detail.address,
                  style: AppTextStyles.body.copyWith(
                    color:
                        AppColors.primaryGreen, // Address berwarna hijau/link
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),

          // Hours
          Row(
            children: [
              Image.asset(
                AppAssets.icClock,
                width: 16,
                height: 16,
                color: AppColors.primaryGreen,
              ),
              const SizedBox(width: 8),
              Text(
                detail.hours,
                style: AppTextStyles.body.copyWith(color: AppColors.black),
              ),
            ],
          ),
          // const Divider(height: 24),
        ],
      ),
    );
  }
}
