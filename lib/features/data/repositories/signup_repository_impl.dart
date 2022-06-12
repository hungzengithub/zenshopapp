import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zenfoodapp/core/global/global.dart';
import 'package:zenfoodapp/features/domain/entities/seller_position.dart';
import 'package:zenfoodapp/features/domain/repositories/signup_repository.dart';

import '../../../../core/error/failures.dart';
import '../../domain/entities/account.dart';

class SignupReporsitoryImpl implements SignupRepository {
  @override
  Future<Either<Failure, bool>> checkSignup(int number) {
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, SellerPosition>> getLocation() async {
    try {
      Position newPosition = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      var position = newPosition;
      var placeMarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );
      Placemark pMark = placeMarks[0];
      var completeAddress =
          '${pMark.subThoroughfare} ${pMark.thoroughfare}, ${pMark.subLocality} ${pMark.locality}, ${pMark.subAdministrativeArea}, ${pMark.administrativeArea} ${pMark.postalCode}, ${pMark.country}';
      var sellerPosition =
          SellerPosition(address: completeAddress, position: position);
      return Right(sellerPosition);
    } catch (e) {
      return Left(GeneralFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> authenticateSellerAndSignUp(
      Account account) async {
    User? currentUser;
    try {
      await firebaseAuth
          .createUserWithEmailAndPassword(
              email: account.email, password: account.password)
          .then((auth) {
        currentUser = auth.user;
      }).catchError((error) {
        return null;
      });
      if (currentUser != null) {
        saveDataToFirestore(currentUser!, account).then((value) {
          return const Right(true);
        });
      } else {
        return const Right(false);
      }
      return const Right(true);
    } catch (e) {
      return Left(GeneralFailure(message: e.toString()));
    }
  }

  Future saveDataToFirestore(User currentUser, Account account) async {
    FirebaseFirestore.instance.collection("sellers").doc(currentUser.uid).set({
      "sellerUID": currentUser.uid,
      "sellerEmail": currentUser.email,
      "sellerName": account.fullname,
      "sellerAvatarUrl": account.imageURL,
      "phone": account.phone,
      "address": account.location,
      "status": "approved",
      "earnings": 0.0,
      "lat": account.position!.latitude,
      "lng": account.position!.longitude,
    });

    //save data locally
    sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences!.setString("uid", currentUser.uid);
    await sharedPreferences!.setString("email", currentUser.email.toString());
    await sharedPreferences!.setString("name", account.fullname);
    await sharedPreferences!.setString("photoUrl", account.imageURL);
  }

  @override
  Future<Either<Failure, XFile?>> getImage(ImagePicker picker) async {
    try {
      var imageXFile = await picker.pickImage(source: ImageSource.gallery);
      return Right(imageXFile);
    } catch (e) {
      return Left(GeneralFailure(message: e.toString()));
    }
  }
}
