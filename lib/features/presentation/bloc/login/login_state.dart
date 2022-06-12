import 'package:equatable/equatable.dart';

abstract class LoginState extends Equatable {}

class LoginInitial extends LoginState {
  @override
  List<Object?> get props => [];
}

class LoginSuccessState extends LoginState {
  @override
  List<Object?> get props => [];
}

class LoginFailState extends LoginState {
  @override
  List<Object?> get props => [];
}

class LogoutSuccessState extends LoginState {
  @override
  List<Object?> get props => [];
}

class LogoutFailState extends LoginState {
  @override
  List<Object?> get props => [];
}

class LoginLoadingState extends LoginState {
  @override
  List<Object?> get props => [];
}

class Error extends LoginState {
  final String message;

  Error({required this.message});

  @override
  List<Object> get props => [message];
}
