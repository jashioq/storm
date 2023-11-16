import 'package:firebase_auth/firebase_auth.dart';
import 'package:storm/src/firebase/authentication/domain/entities/local_user.dart';

class UserModel extends LocalUser {
  const UserModel({required super.uid});

  const UserModel.empty()
      : this(
    uid: "empty.uid",
  );

  UserModel.fromFirebaseUser(User user)
      : this(
    uid: user.uid
  );

  UserModel copyWith({
    String? uid,
  }) {
    return UserModel(
      uid: uid ?? this.uid,
    );
  }
}
