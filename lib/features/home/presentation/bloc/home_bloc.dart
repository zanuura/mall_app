import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mall_mobile_test/features/home/domain/entities/home_data_entitiy.dart';
import 'package:mall_mobile_test/features/home/presentation/bloc/home_event.dart';
import 'package:mall_mobile_test/features/home/presentation/bloc/home_state.dart';
import 'package:mall_mobile_test/features/mall/data/models/product_models.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final List<ProductModel> _allProducts = products;
  HomeBloc() : super(HomeInitial()) {
    on<LoadHomeData>(_onLoadHomeData);
  }

  void _onLoadHomeData(LoadHomeData event, Emitter<HomeState> emit) async {
    emit(HomeLoading());
    try {
      // Simulasi pemanggilan Use Case/Repository
      await Future.delayed(const Duration(seconds: 1));

      final dummyData = HomeDataEntity(
        appointment: const NextAppointment(
          date: '14 Oct 2020',
          time: '12:30 PM',
          location: '123 Plant Street, 1/1 ...',
        ),
        summary: const UserSummary(credit: 'RM100.00', points: 10, packages: 1),
        // Menggunakan dummy product data dari Mall
        newServices: products.take(3).toList(),
      );

      emit(HomeLoaded(data: dummyData, products: _allProducts));
    } catch (e) {
      emit(const HomeError(message: 'Gagal memuat data Home'));
    }
  }
}
