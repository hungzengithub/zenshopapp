import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  @override
  List<Object> get props => [];
}

// General failures

class GeneralFailure extends Failure {
  final String message;

  GeneralFailure({required this.message});
}

class ServerFailure extends Failure {}

class CacheFailure extends Failure {}
