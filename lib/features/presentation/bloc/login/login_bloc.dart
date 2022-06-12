import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:zenfoodapp/core/dependencies/app_dependencies.dart';
import 'package:zenfoodapp/features/domain/usecases/login_usecases.dart';
import 'package:zenfoodapp/features/presentation/bloc/login/login_event.dart';
import 'package:zenfoodapp/features/presentation/bloc/login/login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginUsecases _loginUsecase =
      AppDependencies.injector.get<LoginUsecases>();
  LoginBloc() : super(LoginInitial()) {
    on<RequestLoginEvent>((event, emit) async {
      emit(LoginLoadingState());
      try {
        var position = await _loginUsecase.login(event.email, event.password);
        position.fold((failure) => emit(Error(message: failure.toString())),
            (check) {
          if (check) {
            emit(LoginSuccessState());
          } else {
            emit(LoginFailState());
          }
        });
      } on SocketException catch (_) {
        emit(Error(message: 'no internet'));
      } catch (ex) {
        emit(Error(message: ex.toString()));
      }
    });
    on<RequestLogoutEvent>((event, emit) async {
      emit(LoginLoadingState());
      try {
        var position = await _loginUsecase.logout();
        position.fold((failure) => emit(Error(message: failure.toString())),
            (check) {
          if (check) {
            emit(LogoutSuccessState());
          } else {
            emit(LogoutFailState());
          }
        });
      } on SocketException catch (_) {
        emit(Error(message: 'no internet'));
      } catch (ex) {
        emit(Error(message: ex.toString()));
      }
    });
  }
}
