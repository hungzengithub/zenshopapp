import 'package:flutter_simple_dependency_injection/injector.dart';
import 'package:zenfoodapp/features/presentation/bloc/login/login_bloc.dart';
import 'package:zenfoodapp/features/presentation/bloc/signup/signup_bloc.dart';

class BlocDependencies {
  static Injector initialise(Injector injector) {
    injector.map<SignupBloc>((injector) => SignupBloc(), isSingleton: true);
    injector.map<LoginBloc>((injector) => LoginBloc(), isSingleton: true);
    return injector;
  }
}
