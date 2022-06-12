import 'package:flutter_simple_dependency_injection/injector.dart';
import 'package:zenfoodapp/features/data/repositories/login_repository_impl.dart';
import 'package:zenfoodapp/features/data/repositories/signup_repository_impl.dart';
import 'package:zenfoodapp/features/domain/repositories/login_repository.dart';
import 'package:zenfoodapp/features/domain/repositories/signup_repository.dart';

class RepositoryDependencies {
  static Injector initialise(Injector injector) {
    injector.map<SignupRepository>((injector) => SignupReporsitoryImpl(),
        isSingleton: true);
    injector.map<LoginRepository>((injector) => LoginRepositoryImpl(),
        isSingleton: true);
    return injector;
  }
}
