import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:storm/core/errors/exceptions.dart';
import 'package:storm/src/firebase/authentication/data/models/user_model.dart';

abstract class AuthenticationRemoteDatasource {
  Future<void> mailPassLogIn({
    required String mail,
    required String password,
  });

  Future<void> googleAuthIn();

  Future<void> signOut();

  Future<UserModel> getLocalUser();
}

class AuthenticationRemoteDatasourceImpl
    implements AuthenticationRemoteDatasource {
  AuthenticationRemoteDatasourceImpl(this._auth, this._googleSignIn);

  final FirebaseAuth _auth;
  final GoogleSignIn _googleSignIn;

  @override
  Future<void> mailPassLogIn(
      {required String mail, required String password}) async {
    try {
      await _auth.signInWithEmailAndPassword(email: mail, password: password);
    } on APIException {
      rethrow;
    } catch (e) {
      throw APIException(message: e.toString(), statusCode: 505);
    }
  }

  @override
  Future<void> googleAuthIn() async {
    try {
      final googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        throw const APIException(message: 'No user found', statusCode: 505);
      }
      final googleAuth = await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      await _auth.signInWithCredential(credential);
    } on APIException {
      rethrow;
    } catch (e) {
      throw APIException(message: e.toString(), statusCode: 505);
    }
  }



  @override
  Future<void> signOut() async {
    try {
      _auth.signOut();
    } on APIException {
      rethrow;
    } catch (e) {
      throw APIException(message: e.toString(), statusCode: 505);
    }
  }

  @override
  Future<UserModel> getLocalUser() async {
    try {
      final user = _auth.currentUser;
      if (user == null) {
        throw const APIException(message: 'No user found', statusCode: 505);
      }
      return UserModel.fromFirebaseUser(user);
    } on APIException {
      rethrow;
    } catch (e) {
      throw APIException(message: e.toString(), statusCode: 505);
    }
  }
}
