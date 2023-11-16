import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:storm/src/firebase/authentication/domain/entities/local_user.dart';
import 'package:storm/src/firebase/authentication/domain/usecases/get_local_user.dart';
import 'package:storm/src/firebase/authentication/domain/usecases/google_auth_in.dart';
import 'package:storm/src/firebase/authentication/domain/usecases/mail_pass_log_in.dart';
import 'package:storm/src/firebase/authentication/domain/usecases/sign_out.dart';

part 'authentication_state.dart';

class AuthenticationCubit extends Cubit<AuthenticationState> {
  AuthenticationCubit({
    required MailPassLogIn mailPassLogIn,
    required GoogleAuthIn googleAuthIn,
    required SignOut signOut,
    required GetLocalUser getLocalUser,
  })  : _mailPassLogIn = mailPassLogIn,
        _googleAuthIn = googleAuthIn,
        _signOut = signOut,
        _getLocalUser = getLocalUser,
        super(const AuthenticationInitial());

  final MailPassLogIn _mailPassLogIn;
  final GoogleAuthIn _googleAuthIn;
  final SignOut _signOut;
  final GetLocalUser _getLocalUser;

  Future<void> mailPassLogIn({
    required String mail,
    required String password,
  }) async {
    emit(const LoggingIn());

    final result = await _mailPassLogIn(
      MailPassParams(
        mail: mail,
        password: password,
      ),
    );

    result.fold(
      (failure) => emit(AuthenticationError(failure.errorMessage)),
      (user) => emit(const LoggedIn()),
    );
  }

  Future<void> googleAuthIn() async {
    emit(const LoggingIn());

    final result = await _googleAuthIn();

    result.fold(
      (failure) => emit(AuthenticationError(failure.errorMessage)),
      (_) => emit(const LoggedIn()),
    );
  }

  Future<void> signOut() async {
    emit(const SigningOut());

    final result = await _signOut();

    result.fold(
          (failure) => emit(AuthenticationError(failure.errorMessage)),
          (_) => emit(const AuthenticationInitial()),
    );
  }

  Future<void> getLocalUser() async {
    emit(const GettingLocalUser());

    final result = await _getLocalUser();

    result.fold(
          (failure) => emit(AuthenticationError(failure.errorMessage)),
          (user) => emit(GotLocalUser(user)),
    );
  }
}
