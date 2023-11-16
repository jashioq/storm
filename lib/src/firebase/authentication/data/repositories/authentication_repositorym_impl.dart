import 'package:dartz/dartz.dart';
import 'package:storm/core/errors/exceptions.dart';
import 'package:storm/core/errors/failures.dart';
import 'package:storm/core/utils/typedef.dart';
import 'package:storm/src/firebase/authentication/data/datasources/authentication_remote_datasource.dart';
import 'package:storm/src/firebase/authentication/domain/entities/local_user.dart';
import 'package:storm/src/firebase/authentication/domain/repositories/authentication_repository.dart';

class AuthenticationRepositoryImpl implements AuthenticationRepository {
  const AuthenticationRepositoryImpl(this._remoteDatasource);

  final AuthenticationRemoteDatasource _remoteDatasource;

  @override
  ResultVoid mailPassLogIn(
      {required String mail, required String password}) async {
    try {
      await _remoteDatasource.mailPassLogIn(mail: mail, password: password);
      return const Right(null);
    } on APIException catch (e) {
      return Left(APIFailure.fromException(e));
    }
  }

  @override
  ResultVoid signOut() async {
    try {
      _remoteDatasource.signOut();
      return const Right(null);
    } on APIException catch (e) {
      return Left(APIFailure.fromException(e));
    }
  }

  @override
  ResultFuture<LocalUser> getLocalUser() async {
    try {
      final result = await _remoteDatasource.getLocalUser();
      return Right(result);
    } on APIException catch (e) {
      return Left(APIFailure.fromException(e));
    }
  }

  @override
  ResultVoid googleAuthIn() async {
    try {
      await _remoteDatasource.googleAuthIn();
      return const Right(null);
    } on APIException catch (e) {
      return Left(APIFailure.fromException(e));
    }
  }
}
