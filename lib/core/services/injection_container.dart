import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:storm/src/firebase/authentication/data/datasources/authentication_remote_datasource.dart';
import 'package:storm/src/firebase/authentication/data/repositories/authentication_repositorym_impl.dart';
import 'package:storm/src/firebase/authentication/domain/repositories/authentication_repository.dart';
import 'package:storm/src/firebase/authentication/domain/usecases/get_local_user.dart';
import 'package:storm/src/firebase/authentication/domain/usecases/google_auth_in.dart';
import 'package:storm/src/firebase/authentication/domain/usecases/mail_pass_log_in.dart';
import 'package:storm/src/firebase/authentication/domain/usecases/sign_out.dart';
import 'package:storm/src/firebase/authentication/presentation/cubit/authentication_cubit.dart';

final serviceLocator = GetIt.instance;

Future<void> init() async {
  serviceLocator
    // App Logic
    ..registerFactory(
      () => AuthenticationCubit(
        mailPassLogIn: serviceLocator(),
        signOut: serviceLocator(),
        getLocalUser: serviceLocator(),
        googleAuthIn: serviceLocator(),
      ),
    )

    // Use cases
    ..registerLazySingleton(() => MailPassLogIn(serviceLocator()))
    ..registerLazySingleton(() => GoogleAuthIn(serviceLocator()))
    ..registerLazySingleton(() => SignOut(serviceLocator()))
    ..registerLazySingleton(() => GetLocalUser(serviceLocator()))

    // Repositories
    ..registerLazySingleton<AuthenticationRepository>(
        () => AuthenticationRepositoryImpl(serviceLocator()))

    // Data sources
    ..registerLazySingleton<AuthenticationRemoteDatasource>(
        () => AuthenticationRemoteDatasourceImpl(serviceLocator(), serviceLocator()))

    // External dependencies
    ..registerLazySingleton<FirebaseAuth>(() => FirebaseAuth.instance)
    ..registerLazySingleton<GoogleSignIn>(() => GoogleSignIn());
}
