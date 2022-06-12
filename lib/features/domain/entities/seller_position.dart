import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';

class SellerPosition extends Equatable {
  final String address;
  final Position position;

  const SellerPosition({
    required this.address,
    required this.position,
  });

  @override
  List<Object> get props => [address, position];
}
