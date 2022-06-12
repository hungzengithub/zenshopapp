import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';
import 'package:zenfoodapp/features/domain/entities/account.dart';

@immutable
abstract class SignupEvent extends Equatable {}

class ValidateFormEvent extends SignupEvent {
  ValidateFormEvent();
  @override
  List<Object> get props => [];
}

class GetLocationEvent extends SignupEvent {
  GetLocationEvent();

  @override
  List<Object> get props => [];
}

class PickupImageEvent extends SignupEvent {
  final ImagePicker picker;
  PickupImageEvent(this.picker);
  @override
  List<Object> get props => [];
}

class RequestSignupEvent extends SignupEvent {
  final Account account;
  RequestSignupEvent(this.account);

  @override
  List<Object> get props => [account];
}
