import 'package:flutter_simple_dependency_injection/injector.dart';
import 'package:zenfoodapp/features/domain/usecases/login_usecases.dart';
import 'package:zenfoodapp/features/domain/usecases/signup_usecases.dart';

class UsecaseDependencies {
  static Injector initialise(Injector injector) {
    injector.map<SignupUsecases>((injector) => SignupUsecases(),
        isSingleton: true);
    injector.map<LoginUsecases>((injector) => LoginUsecases(),
        isSingleton: true);
    return injector;
  }
}
