// ignore_for_file: deprecated_member_use

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:mall_mobile_test/core/constants/app_assets.dart';
import 'package:mall_mobile_test/core/constants/app_colors.dart';
import 'package:mall_mobile_test/core/constants/app_text_styles.dart';
import 'package:mall_mobile_test/core/widgets/buttons/icon_circle_buttons.dart';
import 'package:mall_mobile_test/core/widgets/cards/product_card.dart';
import 'package:mall_mobile_test/features/home/domain/entities/location_entity.dart';
import 'package:mall_mobile_test/features/home/presentation/bloc/home_bloc.dart';
import 'package:mall_mobile_test/features/home/presentation/bloc/home_state.dart';
import 'package:mall_mobile_test/features/home/presentation/widgets/location_section.dart';
import 'package:mall_mobile_test/features/mall/data/models/product_models.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ScrollController _pageScrollController = ScrollController();
  final ScrollController _shopPlantScrollController = ScrollController();
  bool showAppbar = false;

  @override
  void initState() {
    super.initState();
    _pageScrollController.addListener(() {
      // log("Initial Scroll Offset ${_pageScrollController.offset}");
      if (_pageScrollController.offset > 60) {
        setState(() {
          showAppbar = true;
        });
      } else if (_pageScrollController.offset < 60) {
        setState(() {
          showAppbar = false;
        });
      }
      // else {
      //   setState(() {
      //     showAppbar = false;
      //   });
      // }
    });
  }

  final List<LocationDetail> dummyLocations = [
    const LocationDetail(
      name: 'Sunway Pyramid',
      address:
          '10 Floor, Lorem Ipsum Mall, Jalan ss23 Lorem, Selangor, Malaysia',
      hours: '10am - 10pm',
    ),
    const LocationDetail(
      name: 'The Gardens Mall',
      address:
          '10 Floor, Lorem Ipsum Mall, Jalan ss23 Lorem, Selangor, Malaysia',
      hours: '10am - 10pm',
    ),
  ];

  // @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: showAppbar
          ? AppBar(
              title: Text(
                'LOGO',
                style: AppTextStyles.title.copyWith(
                  color: AppColors.white,
                  fontSize: 50,
                ),
              ),
              centerTitle: true,
              elevation: 0,
              automaticallyImplyLeading: false,
              forceMaterialTransparency: false,
              backgroundColor: AppColors.primaryGreen,
            )
          : null,
      backgroundColor: AppColors.white,
      body: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          // Tampilkan loading saat HomeLoading
          if (state is HomeLoading) {
            return const Center(
              child: CircularProgressIndicator(color: AppColors.primaryGreen),
            );
          }

          // Tampilkan error jika HomeError
          if (state is HomeError) {
            return Center(
              child: Text(
                'Error: ${state.message}',
                style: AppTextStyles.bodyBold.copyWith(color: AppColors.red),
              ),
            );
          }

          // Tampilkan data jika HomeLoaded
          if (state is HomeLoaded) {
            return SingleChildScrollView(
              controller: _pageScrollController,
              physics: BouncingScrollPhysics(),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildHeader(context),
                  _buildAppointmentInfo(state), // Gunakan state.data
                  _buildBanner(),
                  _buildHomeButtons(),
                  _buildShopPlantCategories(),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.only(top: 24),
                    decoration: BoxDecoration(color: Colors.grey.shade100),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        _buildNewServices(state),
                        const SizedBox(height: 24),
                        _buildShopPlantCategoriesScrollBar(),
                        const SizedBox(height: 24),
                        _buildTrendingServices(state),
                      ],
                    ),
                  ), // Gunakan state.data
                  LocationSection(locations: dummyLocations),
                  const SizedBox(height: 50),
                ],
              ),
            );
          }

          // Default state atau HomeInitial
          return const Center(child: Text('Selamat datang di Aplikasi Mall.'));
        },
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 50, left: 16, right: 16, bottom: 8),
      width: double.infinity,
      color: AppColors.primaryGreen,
      // color: AppColors.darkGreen,
      child: Center(
        child: Text(
          showAppbar ? '' : 'LOGO',
          style: AppTextStyles.title.copyWith(
            color: AppColors.white,
            fontSize: 50,
          ),
        ),
      ),
    );
  }

  Widget textLineAround({
    String? text,
    Color? textColor,
    Color? lineColor,
    double? fontSize,
  }) {
    return Row(
      children: [
        // Garis kiri
        Expanded(
          child: Divider(
            color:
                lineColor ??
                AppColors.white, // Sesuaikan dengan warna putih pada gambar
            thickness: 1,
            height: 1,
            indent: 0,
            endIndent: 8, // Jarak dari teks
          ),
        ),
        // Teks NEXT APPOINTMENT
        Text(
          text ?? '',
          style: AppTextStyles.caption.copyWith(
            color: textColor ?? AppColors.white.withOpacity(0.7),
            letterSpacing: 0.5, // Menambah sedikit jarak antar huruf
            fontSize: fontSize,
          ),
        ),
        // Garis kanan
        Expanded(
          child: Divider(
            color:
                lineColor ??
                AppColors.white, // Sesuaikan dengan warna putih pada gambar
            thickness: 1,
            height: 1,
            indent: 8, // Jarak dari teks
            endIndent: 0,
          ),
        ),
      ],
    );
  }

  Widget _buildAppointmentInfo(HomeLoaded state) {
    // Menggunakan data dari state
    final appointment = state.data.appointment;
    final summary = state.data.summary;

    return Container(
      color: AppColors.primaryGreen,
      padding: const EdgeInsets.only(bottom: 16), // left: 16, right: 16,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Text(
          //   'NEXT APPOINTMENT',
          //   style: AppTextStyles.caption.copyWith(
          //     color: AppColors.white.withOpacity(0.7),
          //   ),
          // ),
          textLineAround(
            text: 'NEXT APPOINTMENT',
            fontSize: 10,
            textColor: AppColors.white,
          ),
          const SizedBox(height: 8),
          SizedBox(
            // fit: BoxFit.fitWidth,
            height: 30,
            child: Row(
              children: [
                Flexible(
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.fromLTRB(24, 0, 24, 0),

                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Image.asset(
                            AppAssets.icCalendar,
                            width: 16,
                            height: 16,
                            color: AppColors.white,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            appointment.date,
                            style: AppTextStyles.caption.copyWith(
                              color: AppColors.white,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(width: 12),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Image.asset(
                            AppAssets.icClock,
                            width: 16,
                            height: 16,
                            color: AppColors.white,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            appointment.time,
                            style: AppTextStyles.caption.copyWith(
                              color: AppColors.white,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(width: 12),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Image.asset(
                            AppAssets.icLocation,
                            width: 16,
                            height: 16,
                            color: AppColors.white,
                          ),
                          const SizedBox(width: 4),
                          Flexible(
                            child: Text(
                              appointment.location,
                              style: AppTextStyles.caption.copyWith(
                                color: AppColors.white,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(width: 50),
                    ],
                  ),
                ),
                Image.asset(
                  AppAssets.icArrowRight,
                  width: 26,
                  height: 26,
                  // color: AppColors.grey,
                ),
                const SizedBox(width: 20),
              ],
            ),
          ),
          const SizedBox(height: 12),
          // Credit/Points/Package Card
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Row(
              children: [
                _infoCard(
                  'CREDIT',
                  summary.credit,
                  BorderRadius.only(
                    topLeft: Radius.circular(30),
                    bottomLeft: Radius.circular(30),
                  ),
                  EdgeInsets.zero,
                  EdgeInsets.fromLTRB(20, 8, 10, 8),
                ),
                _infoCard(
                  'POINTS',
                  summary.points.toString(),
                  BorderRadius.circular(0),
                  EdgeInsets.symmetric(horizontal: 1),
                  null,
                ),
                _infoCard(
                  'PACKAGE',
                  summary.packages.toString(),
                  BorderRadius.only(
                    topRight: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  ),
                  EdgeInsets.zero,
                  EdgeInsets.fromLTRB(10, 8, 20, 8),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _infoCard(
    String label,
    String value,
    BorderRadius? borderRadius,
    EdgeInsets? margin,
    EdgeInsets? padding,
  ) {
    return Expanded(
      child: Container(
        margin: margin ?? const EdgeInsets.symmetric(horizontal: 4),
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: borderRadius ?? BorderRadius.circular(8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              label,
              style: AppTextStyles.caption.copyWith(
                color: AppColors.primaryGreen,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              value,
              style: AppTextStyles.subtitle.copyWith(
                color: AppColors.primaryGreen,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBanner() {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: Image.asset(AppAssets.imgHomeBanner, fit: BoxFit.fitWidth),
    );
  }

  Widget _buildHomeButtons() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _homePillButton(AppAssets.btnShop),
          _homePillButton(AppAssets.btnServices),
          _homePillButton(AppAssets.btnPosts),
        ],
      ),
    );
  }

  Widget _homePillButton(String asset) {
    return Expanded(flex: 3, child: Image.asset(asset, fit: BoxFit.cover));
  }

  Widget _buildShopPlantCategories() {
    final categories = [
      AppAssets.icShopPlant1,
      AppAssets.icShopPlant2,
      AppAssets.icShopPlant3,
      AppAssets.icShopPlant4,
      AppAssets.icShopPlant5,
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: SizedBox(
        height: 70, // Adjust height as needed
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 24),
          itemCount: categories.length,
          separatorBuilder: (_, __) => const SizedBox(width: 12),
          itemBuilder: (_, i) {
            return IconCircleButton(
              assetIcon: categories[i],
              size: 70,
              backgroundColor: AppColors.lightGrey.withOpacity(0.3),
              onTap: () {},
            );
          },
        ),
      ),
    );
  }

  Widget _buildShopPlantCategoriesScrollBar() {
    final categories = [
      AppAssets.icShopPlant1,
      AppAssets.icShopPlant2,
      AppAssets.icShopPlant3,
      AppAssets.icShopPlant4,
      AppAssets.icShopPlant5,
    ];

    return Padding(
      padding: const EdgeInsets.only(top: 20, bottom: 8),
      child: SizedBox(
        height: 110,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Positioned.fill(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Scrollbar(
                      controller: _shopPlantScrollController,
                      thumbVisibility: true,
                      thickness: 4,
                      trackVisibility: true,
                      interactive: true,
                      scrollbarOrientation: ScrollbarOrientation.bottom,
                      radius: const Radius.circular(6),
                      child: ListView.separated(
                        controller: _shopPlantScrollController,
                        scrollDirection: Axis.horizontal,
                        padding: const EdgeInsets.only(
                          left: 120, // ruang untuk logo
                          right: 24,
                          bottom: 24,
                        ),
                        itemCount: categories.length,
                        separatorBuilder: (_, __) => const SizedBox(width: 14),
                        itemBuilder: (_, i) {
                          return IconCircleButton(
                            size: 50,
                            assetIcon: categories[i],
                            backgroundColor: AppColors.white.withOpacity(0.6),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),

            Positioned(
              // left: 24,
              top: -10,
              child: Container(
                height: 110,
                width: 110,
                padding: const EdgeInsets.only(left: 10, right: 10),
                decoration: BoxDecoration(color: Colors.grey.shade100),
                child: Image.asset(
                  AppAssets.icShopPlantLogo, // logo seperti di gambar
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNewServices(HomeLoaded state) {
    final newServices = state.data.newServices;

    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'NEW SERVICES',
                      style: AppTextStyles.subtitle.copyWith(
                        color: AppColors.primaryGreen,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 16.0),
                      child: Text(
                        'View All',
                        style: AppTextStyles.body.copyWith(
                          color: AppColors.primaryGreen,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  'Recommended based on your preference',
                  style: AppTextStyles.captionGrey,
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          // Horizontal Product List
          SizedBox(
            height: 250, // Height to fit product card, adjust as needed
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: newServices.length,
              padding: EdgeInsets.symmetric(horizontal: 24),
              separatorBuilder: (_, __) => const SizedBox(width: 12),
              itemBuilder: (_, i) => SizedBox(
                width: 160,
                child: ProductCard(
                  imagePath: newServices[i].imagePath,
                  title: newServices[i].title,
                  subtitle: newServices[i].salonName,
                  price: newServices[i].priceText,
                  oldPrice: newServices[i].oldPriceText,
                  discountText: newServices[i].discountPercentText,
                  onTap: () {},
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTrendingServices(HomeLoaded state) {
    // 1. Perbaikan Akses State
    final productsToDisplay =
        state.products; // Menggunakan state.data.newServices

    if (productsToDisplay.isEmpty) {
      return const SizedBox.shrink(); // Lebih aman daripada Center(child: Text...)
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // HEADER SECTION (WAJIB ADA agar Masonry Grid punya konteks)
        // Padding(
        //   padding: const EdgeInsets.only(left: 16, top: 8, right: 16),
        //   child: Row(
        //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //     children: [
        //       Text(
        //         'NEW SERVICES',
        //         style: AppTextStyles.subtitle.copyWith(
        //           color: AppColors.primaryGreen,
        //         ),
        //       ),
        //       Text(
        //         'View All',
        //         style: AppTextStyles.body.copyWith(
        //           color: AppColors.primaryGreen,
        //         ),
        //       ),
        //     ],
        //   ),
        // ),
        // Padding(
        //   padding: const EdgeInsets.only(left: 16.0),
        //   child: Text(
        //     'Recommended based on your preference',
        //     style: AppTextStyles.captionGrey,
        //   ),
        // ),
        SizedBox(
          width: double.infinity,
          child: Image.asset(AppAssets.imgTrendingDiscoveries),
        ),

        Container(
          padding: const EdgeInsets.fromLTRB(24, 0, 24, 50),
          decoration: BoxDecoration(color: AppColors.darkGreen),
          child: MasonryGridView.count(
            crossAxisCount: 2,
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
            itemCount: productsToDisplay.length,

            // KUNCI PERBAIKAN: Harus ada untuk bersarang di SingleChildScrollView
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,

            itemBuilder: (context, i) {
              final p = productsToDisplay[i];
              return ProductCard(
                imagePath: p.imagePath,
                title: p.title,
                subtitle: p.salonName,
                price: p.priceText,
                oldPrice: p.oldPriceText,
                discountText: p.discountPercentText,
                onTap: () {},
              );
            },
          ),
        ),
      ],
    );
  }

  // Dummy Product Model creation for Home Page
  ProductModel _dummyProduct(int index) {
    return ProductModel(
      imagePath: AppAssets.imgProductPlaceholder,
      title: 'New Service $index: Sample Product Title',
      salonName: 'The Green Salon',
      price: index % 2 == 0 ? 80.00 : 120.00,
      oldPrice: index % 2 == 0 ? 100.00 : null,
    );
  }
}
