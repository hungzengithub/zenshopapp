import 'package:flutter_simple_dependency_injection/injector.dart';

import 'package:zenfoodapp/core/dependencies/bloc_dependencies.dart';
import 'package:zenfoodapp/core/dependencies/repository_dependencies.dart';
import 'package:zenfoodapp/core/dependencies/usecase_dependencies.dart';

class AppDependencies {
  static Injector injector = AppDependencies().initialise(Injector());
  Injector initialise(Injector injector) {
    RepositoryDependencies.initialise(injector);
    UsecaseDependencies.initialise(injector);
    BlocDependencies.initialise(injector);

    return injector;
  }
}
