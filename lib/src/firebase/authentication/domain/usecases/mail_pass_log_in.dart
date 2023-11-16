import 'package:equatable/equatable.dart';
import 'package:storm/core/usecase/usecase.dart';
import 'package:storm/core/utils/typedef.dart';
import 'package:storm/src/firebase/authentication/domain/repositories/authentication_repository.dart';

class MailPassLogIn extends UseCaseWithParams<void, MailPassParams> {
  const MailPassLogIn(this._repository);

  final AuthenticationRepository _repository;

  @override
  ResultVoid call(MailPassParams params) async =>
      _repository.mailPassLogIn(mail: params.mail, password: params.password);
}

class MailPassParams extends Equatable {
  const MailPassParams({
    required this.mail,
    required this.password,
  });

  const MailPassParams.empty()
      : this(mail: "_empty.mail", password: "_empty.password");

  final String mail;
  final String password;

  @override
  List<Object?> get props => [mail, password];
}
