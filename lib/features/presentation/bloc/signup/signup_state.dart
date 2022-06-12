import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';
import 'package:zenfoodapp/features/domain/entities/seller_position.dart';

abstract class SignupState extends Equatable {}

class SignupInitial extends SignupState {
  @override
  List<Object?> get props => [];
}

class ValidateSuccessState extends SignupState {
  @override
  List<Object?> get props => [];
}

class SigningupSuccessState extends SignupState {
  SigningupSuccessState();

  @override
  List<Object?> get props => [];
}

class SigningupFailedState extends SignupState {
  SigningupFailedState();

  @override
  List<Object?> get props => [];
}

class GetLocationLoading extends SignupState {
  @override
  List<Object?> get props => [];
}

class GetLocationSuccess extends SignupState {
  final SellerPosition position;

  GetLocationSuccess({required this.position});

  @override
  List<Object> get props => [position];
}

class GetImageLoading extends SignupState {
  @override
  List<Object?> get props => [];
}

class GetImageSuccess extends SignupState {
  final XFile? image;

  GetImageSuccess({required this.image});

  @override
  List<Object> get props => [];
}

class SignupSuccess extends SignupState {
  SignupSuccess();

  @override
  List<Object> get props => [];
}

class SignupFail extends SignupState {
  SignupFail();

  @override
  List<Object> get props => [];
}

class Error extends SignupState {
  final String message;

  Error({required this.message});

  @override
  List<Object> get props => [message];
}
