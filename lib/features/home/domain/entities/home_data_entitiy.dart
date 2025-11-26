import 'package:equatable/equatable.dart';
import 'package:mall_mobile_test/features/mall/data/models/product_models.dart';

class NextAppointment extends Equatable {
  final String date;
  final String time;
  final String location;

  const NextAppointment({
    required this.date,
    required this.time,
    required this.location,
  });

  @override
  List<Object> get props => [date, time, location];
}

class UserSummary extends Equatable {
  final String credit;
  final int points;
  final int packages;

  const UserSummary({
    required this.credit,
    required this.points,
    required this.packages,
  });

  @override
  List<Object> get props => [credit, points, packages];
}

class HomeDataEntity extends Equatable {
  final NextAppointment appointment;
  final UserSummary summary;
  final List<ProductModel> newServices;
  // Anda bisa menambahkan field lain (seperti kategori, banner)

  const HomeDataEntity({
    required this.appointment,
    required this.summary,
    required this.newServices,
  });

  @override
  List<Object> get props => [appointment, summary, newServices];
}
