part of 'authentication_cubit.dart';

abstract class AuthenticationState extends Equatable {
  const AuthenticationState();

  @override
  List<Object> get props => [];
}

class AuthenticationError extends AuthenticationState {
  const AuthenticationError(this.message);

  final String message;

  @override
  List<String> get props => [message];
}

class AuthenticationInitial extends AuthenticationState {
  const AuthenticationInitial();
}

class LoggingIn extends AuthenticationState {
  const LoggingIn();
}

class LoggedIn extends AuthenticationState {
  const LoggedIn();
}

class SigningOut extends AuthenticationState {
  const SigningOut();
}

class GettingLocalUser extends AuthenticationState {
  const GettingLocalUser();
}

class GotLocalUser extends AuthenticationState {
  const GotLocalUser(this.user);

  final LocalUser user;

  @override
  List<Object> get props => [user.uid];
}
