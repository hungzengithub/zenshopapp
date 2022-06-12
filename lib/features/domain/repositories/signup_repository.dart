import 'package:dartz/dartz.dart';
import 'package:image_picker/image_picker.dart';
import 'package:zenfoodapp/features/domain/entities/account.dart';

import '../../../../core/error/failures.dart';
import '../entities/seller_position.dart';

abstract class SignupRepository {
  Future<Either<Failure, bool>> checkSignup(int number);
  Future<Either<Failure, SellerPosition>> getLocation();
  Future<Either<Failure, bool>> authenticateSellerAndSignUp(Account account);
  Future<Either<Failure, XFile?>> getImage(ImagePicker picker);
}
