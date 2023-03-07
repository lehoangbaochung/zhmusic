import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:src/exports/entities.dart';

class Account {
  final String id;
  final String? name;
  final String? email;
  final String? avatar;

  const Account._(
    this.id, {
    required this.name,
    required this.email,
    required this.avatar,
  });

  factory Account.fromJson(String id, Map<String, dynamic> fields) {
    return Account._(
      id,
      name: fields['name'] ?? empty,
      email: fields['email'] ?? empty,
      avatar: fields['avatar'] ?? empty,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      id: {
        'name': name,
        'email': email,
        'avatar': avatar,
      },
    };
  }

  static const anonymous = Account._(
    '',
    name: null,
    email: null,
    avatar: null,
  );

  static final _auth = FirebaseAuth.instance;

  static Account? get instance => _auth.currentUser?.toAccount();

  static Stream<Account?> get changes => _auth.userChanges().map((user) => user?.toAccount());

  static Future<void> signOut() => _auth.signOut();

  static Future<Account?> signInWithGoogle() async {
    final googleUser = await GoogleSignIn().signIn();
    final googleAuth = await googleUser?.authentication;
    final authCredential = GoogleAuthProvider.credential(
      idToken: googleAuth?.idToken,
      accessToken: googleAuth?.accessToken,
    );
    final userCredential = await _auth.signInWithCredential(authCredential);
    await userCredential.user?.reauthenticateWithCredential(authCredential);
    return userCredential.user?.toAccount();
  }
}

extension UserX on User {
  Account toAccount() {
    return Account._(
      uid,
      name: displayName,
      email: email,
      avatar: photoURL,
    );
  }
}
