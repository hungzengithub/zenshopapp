import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';

abstract class LoginRepository {
  Future<Either<Failure, bool>> login(String email, String password);
  Future<Either<Failure, bool>> logout();
}
