import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:zenfoodapp/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:zenfoodapp/core/global/global.dart';
import 'package:zenfoodapp/features/domain/repositories/login_repository.dart';

class LoginRepositoryImpl implements LoginRepository {
  @override
  Future<Either<Failure, bool>> login(String email, String password) async {
    try {
      User? currentUser;
      await firebaseAuth
          .signInWithEmailAndPassword(
        email: email,
        password: password,
      )
          .then((auth) {
        currentUser = auth.user!;
      }).catchError((error) {
        return null;
      });
      if (currentUser != null) {
        await readDataAndSetDataLocally(currentUser!).then((value) {});
        return const Right(true);
      }
      return const Right(false);
    } catch (e) {
      return Left(GeneralFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> logout() async {
    try {
      firebaseAuth.signOut().then((value) {
        clearDataWhenLogout();
        return const Right(true);
      });
      return const Right(false);
    } catch (e) {
      return Left(GeneralFailure(message: e.toString()));
    }
  }

  Future clearDataWhenLogout() async {
    await sharedPreferences!.remove("uid");
    await sharedPreferences!.remove("email");
    await sharedPreferences!.remove("name");
    await sharedPreferences!.remove("photoUrl");
  }

  Future readDataAndSetDataLocally(User currentUser) async {
    await FirebaseFirestore.instance
        .collection("sellers")
        .doc(currentUser.uid)
        .get()
        .then((snapshot) async {
      await sharedPreferences!.setString("uid", currentUser.uid);
      await sharedPreferences!
          .setString("email", snapshot.data()!["sellerEmail"]);
      await sharedPreferences!
          .setString("name", snapshot.data()!["sellerName"]);
      await sharedPreferences!
          .setString("photoUrl", snapshot.data()!["sellerAvatarUrl"]);
    });
  }
}
