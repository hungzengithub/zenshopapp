import 'package:dartz/dartz.dart';
import 'package:zenfoodapp/core/dependencies/app_dependencies.dart';
import 'package:zenfoodapp/core/error/failures.dart';
import 'package:zenfoodapp/core/usecases/usecase.dart';
import 'package:zenfoodapp/features/domain/entities/account.dart';
import 'package:zenfoodapp/features/domain/repositories/login_repository.dart';

class LoginUsecases implements UseCase<Account, NoParams> {
  final LoginRepository repository =
      AppDependencies.injector.get<LoginRepository>();

  Future<Either<Failure, bool>> login(String email, String password) async {
    return repository.login(email, password);
  }

  Future<Either<Failure, bool>> logout() async {
    return repository.logout();
  }
}
