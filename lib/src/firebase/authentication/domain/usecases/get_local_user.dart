import 'package:storm/core/usecase/usecase.dart';
import 'package:storm/core/utils/typedef.dart';
import 'package:storm/src/firebase/authentication/domain/entities/local_user.dart';
import 'package:storm/src/firebase/authentication/domain/repositories/authentication_repository.dart';

class GetLocalUser extends UseCaseWithoutPrams<LocalUser> {
  const GetLocalUser(this._repository);

  final AuthenticationRepository _repository;

  @override
  ResultFuture<LocalUser> call() async => _repository.getLocalUser();
}