import 'package:dartz/dartz.dart';
import 'package:geolocator/geolocator.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';
import 'package:zenfoodapp/core/error/failures.dart';
import 'package:zenfoodapp/features/data/repositories/signup_repository_impl.dart';
import 'package:zenfoodapp/features/domain/entities/seller_position.dart';
import 'package:zenfoodapp/features/domain/repositories/signup_repository.dart';

class MockClient extends Mock implements SignupRepository {}

main() {
  var repository = SignupReporsitoryImpl();
  var position = SellerPosition(
      address: 'test address',
      position: Position(
          accuracy: 0,
          altitude: 0,
          heading: 0,
          latitude: 0,
          speed: 0,
          speedAccuracy: 0,
          timestamp: DateTime.now(),
          longitude: 0));
  group('getLocation', () {
    test(
      'should return exception when the call to get location is unsuccessful',
      () async {
        // act
        final result = await repository.getLocation();

        // assert
        expect(result, equals(Left(GeneralFailure(message: ''))));
      },
    );

    test(
      'should return last locally cached data when the cached data is present',
      () async {
        final result = await repository.getLocation();

        expect(result, equals(Right(position)));
      },
    );
  });
}
