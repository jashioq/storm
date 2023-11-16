import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mocktail/mocktail.dart';
import 'package:storm/core/errors/exceptions.dart';
import 'package:storm/src/firebase/authentication/data/datasources/authentication_remote_datasource.dart';

class MockFirebaseAuth extends Mock implements FirebaseAuth {}
class MockGoogleSignIn extends Mock implements GoogleSignIn {}
class MockUserCredential extends Mock implements UserCredential {}
class MockAuthenticationRemoteDatasource extends Mock
    implements AuthenticationRemoteDatasource {}

void main() {
  late AuthenticationRemoteDatasourceImpl authRemoteDatasourceImpl;
  late MockFirebaseAuth mockFirebaseAuth;
  late MockGoogleSignIn mockGoogleSignIn;
  late MockUserCredential mockUserCredential;

  const testException = APIException(
    message: 'Unknown Error Occurred',
    statusCode: 500,
  );
  const mail = 'test@test.com';
  const password = 'testPassword';

  setUp(() {
    mockFirebaseAuth = MockFirebaseAuth();
    mockGoogleSignIn = MockGoogleSignIn();
    mockUserCredential = MockUserCredential();
    authRemoteDatasourceImpl =
        AuthenticationRemoteDatasourceImpl(mockFirebaseAuth, mockGoogleSignIn);
  });

  group(
    'mailPassLogIn',
      () {
        test('should call [signInWithEmailAndPassword()] with correct email and password', () async {
          when(() => mockFirebaseAuth.signInWithEmailAndPassword(
              email: any(named: 'email'), password: any(named: 'password')))
              .thenAnswer((_) async => mockUserCredential);

          final methodCall = authRemoteDatasourceImpl.mailPassLogIn(
              mail: mail, password: password);

          expect(methodCall, completes);

          verify(() => mockFirebaseAuth.signInWithEmailAndPassword(
              email: mail,
              password: password)).called(1);

          verifyNoMoreInteractions(mockFirebaseAuth);
        });

        test('should return [APIException] when [signInWithEmailAndPassword()] throws an exception', () async {
          when(() => mockFirebaseAuth.signInWithEmailAndPassword(
              email: any(named: 'email'), password: any(named: 'password')))
              .thenThrow(testException);

          final methodCall = authRemoteDatasourceImpl.mailPassLogIn(
              mail: mail, password: password);

          expect(methodCall, throwsA(testException));

          verify(() => mockFirebaseAuth.signInWithEmailAndPassword(
              email: mail,
              password: password)).called(1);

          verifyNoMoreInteractions(mockFirebaseAuth);
        });
      }
  );

  group(
    'signOut',
      () {
        test('should call [signOut] and complete successfully', () async {
          when(() => mockFirebaseAuth.signOut()).thenAnswer((_) async {});

          final methodCall = authRemoteDatasourceImpl.signOut();

          expect(methodCall, completes);

          verify(() => mockFirebaseAuth.signOut()).called(1);

          verifyNoMoreInteractions(mockFirebaseAuth);
        });

        test('should return [APIException] when [signOut()] throws an exception', () async {
          when(() => mockFirebaseAuth.signOut()).thenThrow(testException);

          final methodCall = authRemoteDatasourceImpl.signOut();

          expect(methodCall, throwsA(testException));

          verify(() => mockFirebaseAuth.signOut()).called(1);

          verifyNoMoreInteractions(mockFirebaseAuth);
        });
      }
  );
}
