import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class LoginEvent extends Equatable {}

class RequestLoginEvent extends LoginEvent {
  final String email;
  final String password;

  RequestLoginEvent(this.email, this.password);
  @override
  List<Object> get props => [];
}

class RequestLogoutEvent extends LoginEvent {
  @override
  List<Object> get props => [];
}
