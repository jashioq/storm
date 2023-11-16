import 'package:storm/core/usecase/usecase.dart';
import 'package:storm/core/utils/typedef.dart';
import 'package:storm/src/firebase/authentication/domain/repositories/authentication_repository.dart';

class GoogleAuthIn extends UseCaseWithoutPrams<void> {
  const GoogleAuthIn(this._repository);

  final AuthenticationRepository _repository;

  @override
  ResultFuture<void> call() async => _repository.googleAuthIn();
}