// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:mall_mobile_test/core/constants/app_assets.dart';
import 'package:mall_mobile_test/core/constants/app_colors.dart';
import 'package:mall_mobile_test/core/constants/app_text_styles.dart';
import 'package:mall_mobile_test/core/widgets/cards/product_card.dart';
import 'package:mall_mobile_test/features/mall/presentation/bloc/mall_bloc.dart';
import 'package:mall_mobile_test/features/mall/presentation/bloc/mall_event.dart';
import 'package:mall_mobile_test/features/mall/presentation/bloc/mall_state.dart';

class MallPage extends StatefulWidget {
  const MallPage({super.key});

  @override
  State<MallPage> createState() => _MallPageState();
}

class _MallPageState extends State<MallPage> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Tambahkan listener untuk event search
    _searchController.addListener(() {
      context.read<MallBloc>().add(
        SearchProducts(query: _searchController.text),
      );
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(72), // tinggi appbar total
        child: AppBar(
          backgroundColor: AppColors.white,
          elevation: 0,
          automaticallyImplyLeading: false,
          titleSpacing: 0,
          bottomOpacity: 0,
          // foregroundColor: AppColors.white,
          forceMaterialTransparency: false,
          // kita pakai title, bukan actions
          title: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            child: Row(
              children: [
                InkWell(
                  onTap: () => Navigator.of(context).pop(),
                  borderRadius: BorderRadius.circular(20),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(
                      Icons.arrow_back_ios_new_rounded,
                      color: AppColors.primaryGreen,
                      size: 20,
                    ),
                    // child: Image.asset(
                    //   AppAssets.icArrowRight,
                    //   width: 20,
                    //   height: 20,
                    //   // color: AppColors.primaryGreen,
                    // ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Container(
                    height: 44, // atur tinggi search bar di sini
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(25),
                      border: Border.all(color: AppColors.lightGrey),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.08),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Center(
                      child: TextField(
                        controller: _searchController,
                        decoration: InputDecoration(
                          hintText: 'Search Salon',
                          hintStyle: AppTextStyles.captionGrey.copyWith(
                            fontSize: 14,
                          ),
                          border: InputBorder.none,
                          isCollapsed: true,
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 0,
                            horizontal: 4,
                          ),
                          prefixIcon: Padding(
                            padding: const EdgeInsets.only(left: 4, right: 8),
                            child: Image.asset(
                              AppAssets.icSearch,
                              width: 20,
                              height: 20,
                              color: AppColors.grey,
                            ),
                          ),
                          prefixIconConstraints: const BoxConstraints(
                            minWidth: 20,
                            minHeight: 20,
                          ),
                          suffixIcon: InkWell(
                            onTap: () {
                              context.read<MallBloc>().add(
                                const FilterProducts(
                                  filters: {'hasDiscount': true},
                                ),
                              );
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(right: 4),
                              // child: Icon(Icons.accesi),
                              child: Image.asset(
                                AppAssets.icFilter,
                                width: 20,
                                height: 20,
                                color: AppColors.grey,
                              ),
                            ),
                          ),
                          suffixIconConstraints: const BoxConstraints(
                            minWidth: 20,
                            minHeight: 20,
                          ),
                        ),
                        style: AppTextStyles.body,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 20),
              ],
            ),
          ),
        ),
      ),

      body: BlocBuilder<MallBloc, MallState>(
        builder: (context, state) {
          if (state is MallLoading) {
            return const Center(
              child: CircularProgressIndicator(color: AppColors.primaryGreen),
            );
          }

          if (state is MallError) {
            if (state.products.isNotEmpty) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Error: ${state.message}'),
                  backgroundColor: AppColors.red,
                ),
              );
            } else {
              return Center(
                child: Text(
                  'Gagal memuat: ${state.message}',
                  style: AppTextStyles.bodyBold.copyWith(color: AppColors.red),
                ),
              );
            }
          }

          final productsToDisplay = state.products;

          if (productsToDisplay.isEmpty) {
            return const Center(child: Text('Tidak ada produk ditemukan.'));
          }

          return MasonryGridView.count(
            crossAxisCount: 2, // Jumlah kolom (seperti crossAxisCount)
            mainAxisSpacing: 12, // Spasi vertikal (mainAxisSpacing)
            crossAxisSpacing: 12, // Spasi horizontal (crossAxisSpacing)
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
            itemCount: productsToDisplay.length,
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
            // Bagian utama Masonry Grid: menentukan span (tinggi) setiap item
            // staggeredTileBuilder: (int index) {
            //   final p = productsToDisplay[index];
            //   // Di sini Anda dapat mengatur tinggi yang berbeda-beda.
            //   // Jika harga diskon ada (oldPrice != null), buat item sedikit lebih tinggi.
            //   // Nilai 1.4, 1.6, dst. adalah rasio tinggi (mainAxis) terhadap lebar (crossAxis).
            //   if (p.oldPrice != null) {
            //     // Contoh: Produk dengan diskon sedikit lebih tinggi (misalnya karena badge diskon)
            //     return  StaggeredGridTile.count(
            //       crossAxisCellCount: 1,
            //       mainAxisCellCount: 1.6, // Taller item (1.6 * lebar item)
            //     );
            //   } else {
            //     return  StaggeredGridTile.count(
            //       crossAxisCellCount: 1,
            //       mainAxisCellCount: 1.4, // Shorter item (1.4 * lebar item)
            //     );
            //   }
            // },
          );
          // return GridView.builder(
          //   padding: const EdgeInsets.all(12),
          //   gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          //     crossAxisCount: 2,
          //     mainAxisSpacing: 12,
          //     crossAxisSpacing: 12,
          //     childAspectRatio: 0.65,
          //   ),
          //   itemCount: productsToDisplay.length,
          //   itemBuilder: (_, i) {
          //     final p = productsToDisplay[i];
          //     return ProductCard(
          //       imagePath: p.imagePath,
          //       title: p.title,
          //       subtitle: p.salonName,
          //       price: p.priceText,
          //       oldPrice: p.oldPriceText,
          //       discountText: p.discountPercentText,
          //       onTap: () {},
          //     );
          //   },
          // );
        },
      ),
    );
  }
}
