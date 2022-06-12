import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:zenfoodapp/core/dependencies/app_dependencies.dart';
import 'package:zenfoodapp/features/domain/usecases/signup_usecases.dart';

import 'signup_event.dart';
import 'signup_state.dart';

class SignupBloc extends Bloc<SignupEvent, SignupState> {
  final SignupUsecases _signupUsecases =
      AppDependencies.injector.get<SignupUsecases>();
  SignupBloc() : super(SignupInitial()) {
    on<GetLocationEvent>((event, emit) async {
      emit(GetLocationLoading());
      try {
        var position = await _signupUsecases.getLocation();
        position.fold(
          (failure) => emit(Error(message: failure.toString())),
          (position) => emit(GetLocationSuccess(position: position)),
        );
      } on SocketException catch (_) {
        emit(Error(message: 'no internet'));
      } catch (ex) {
        emit(Error(message: ex.toString()));
      }
    });
    on<PickupImageEvent>((event, emit) async {
      emit(GetImageLoading());
      try {
        var image = await _signupUsecases.getImage(event.picker);
        image.fold(
          (failure) => emit(Error(message: failure.toString())),
          (image) => emit(GetImageSuccess(image: image)),
        );
      } on SocketException catch (_) {
        emit(Error(message: 'no internet'));
      } catch (ex) {
        emit(Error(message: ex.toString()));
      }
    });
    on<RequestSignupEvent>((event, emit) async {
      emit(GetImageLoading());
      try {
        var signupResult =
            await _signupUsecases.authenticateSellerAndSignUp(event.account);
        signupResult.fold(
          (failure) => emit(Error(message: failure.toString())),
          (check) {
            if (check) {
              emit(SignupSuccess());
            } else {
              emit(SignupFail());
            }
          },
        );
      } on SocketException catch (_) {
        emit(Error(message: 'no internet'));
      } catch (ex) {
        emit(Error(message: ex.toString()));
      }
    });
  }
}
