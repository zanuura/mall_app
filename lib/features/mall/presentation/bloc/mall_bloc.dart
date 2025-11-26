import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mall_mobile_test/features/mall/data/models/product_models.dart';
import 'package:mall_mobile_test/features/mall/presentation/bloc/mall_event.dart';
import 'package:mall_mobile_test/features/mall/presentation/bloc/mall_state.dart';

class MallBloc extends Bloc<MallEvent, MallState> {
  // Simpan daftar produk lengkap di Bloc
  final List<ProductModel> _allProducts = products;

  MallBloc() : super(MallInitial()) {
    on<LoadMallProducts>(_onLoadMallProducts);
    on<SearchProducts>(_onSearchProducts);
    on<FilterProducts>(_onFilterProducts);
  }

  void _onLoadMallProducts(
    LoadMallProducts event,
    Emitter<MallState> emit,
  ) async {
    emit(MallLoading());
    try {
      await Future.delayed(const Duration(milliseconds: 500));
      emit(MallLoaded(products: _allProducts));
    } catch (e) {
      emit(const MallError(message: 'Gagal memuat produk', products: []));
    }
  }

  void _onSearchProducts(SearchProducts event, Emitter<MallState> emit) async {
    final query = event.query.toLowerCase();

    // Tampilkan loading jika query tidak kosong
    if (query.isNotEmpty) {
      emit(MallLoading());
    }

    try {
      await Future.delayed(const Duration(milliseconds: 300));

      final filtered = _allProducts.where((p) {
        return p.title.toLowerCase().contains(query) ||
            p.salonName.toLowerCase().contains(query);
      }).toList();

      emit(MallLoaded(products: filtered, searchQuery: event.query));
    } catch (e) {
      emit(
        MallError(message: 'Gagal mencari produk', products: state.products),
      );
    }
  }

  void _onFilterProducts(FilterProducts event, Emitter<MallState> emit) async {
    emit(MallLoading());
    try {
      // Simulasi logika filter kompleks (bisa berdasarkan harga, rating, dll.)
      await Future.delayed(const Duration(milliseconds: 500));

      // Implementasi filter berdasarkan 'filters' map di sini
      final filtered = _allProducts.where((p) {
        // Contoh: filter berdasarkan diskon
        if (event.filters['hasDiscount'] == true) {
          return p.oldPrice != null;
        }
        return true;
      }).toList();

      emit(MallLoaded(products: filtered, searchQuery: state.searchQuery));
    } catch (e) {
      emit(
        MallError(message: 'Gagal memfilter produk', products: state.products),
      );
    }
  }
}
