import 'package:equatable/equatable.dart';

class LocationDetail extends Equatable {
  final String name;
  final String address;
  final String hours;

  const LocationDetail({
    required this.name,
    required this.address,
    required this.hours,
  });

  @override
  List<Object> get props => [name, address, hours];
}
