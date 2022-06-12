import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';

class Account extends Equatable {
  final String fullname;
  final String email;
  final String phone;
  final String password;
  final String location;
  final Position? position;
  final String imageURL;

  const Account({
    required this.fullname,
    required this.email,
    required this.phone,
    required this.password,
    required this.location,
    required this.imageURL,
    required this.position,
  });

  @override
  List<Object> get props => [fullname, email, phone, password, location];
}
