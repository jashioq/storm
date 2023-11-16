import 'package:storm/core/usecase/usecase.dart';
import 'package:storm/src/firebase/authentication/domain/repositories/authentication_repository.dart';
import 'package:storm/core/utils/typedef.dart';

class SignOut extends UseCaseWithoutPrams<void> {
  const SignOut(this._repository);

final AuthenticationRepository _repository;

@override
ResultVoid call() async => _repository.signOut();
}