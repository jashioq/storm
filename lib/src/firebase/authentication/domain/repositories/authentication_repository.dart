import 'package:storm/core/utils/typedef.dart';
import 'package:storm/src/firebase/authentication/domain/entities/local_user.dart';

abstract class AuthenticationRepository {
  const AuthenticationRepository();

  ResultVoid mailPassLogIn({
    required String mail,
    required String password,
  });

  ResultVoid googleAuthIn();

  ResultVoid signOut();

  ResultFuture<LocalUser> getLocalUser();
}
