import 'package:dartz/dartz.dart';
import 'package:image_picker/image_picker.dart';
import 'package:zenfoodapp/core/dependencies/app_dependencies.dart';
import 'package:zenfoodapp/core/error/failures.dart';
import 'package:zenfoodapp/core/usecases/usecase.dart';
import 'package:zenfoodapp/features/domain/entities/account.dart';
import 'package:zenfoodapp/features/domain/repositories/signup_repository.dart';

import '../entities/seller_position.dart';

class SignupUsecases implements UseCase<Account, NoParams> {
  final SignupRepository repository =
      AppDependencies.injector.get<SignupRepository>();

  Future<Either<Failure, SellerPosition>> getLocation() async {
    return await repository.getLocation();
  }

  Future<Either<Failure, bool>> authenticateSellerAndSignUp(
      Account account) async {
    return repository.authenticateSellerAndSignUp(account);
  }

  Future<Either<Failure, XFile?>> getImage(ImagePicker picker) async {
    return repository.getImage(picker);
  }
}
