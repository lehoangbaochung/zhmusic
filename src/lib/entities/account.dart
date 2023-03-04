import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Account {
  final String id;
  final String? name;
  final String? email;
  final String? photoUrl;

  const Account._(
    this.id, {
    required this.name,
    required this.email,
    required this.photoUrl,
  });

  static const empty = Account._(
    '',
    name: null,
    email: null,
    photoUrl: null,
  );

  static final _auth = FirebaseAuth.instance;

  static Account? get instance => _auth.currentUser?.toAccount();

  static Stream<Account?> get authStateChanges => _auth.authStateChanges().map((user) => user?.toAccount());

  static Future<void> signOut() => _auth.signOut();

  static Future<Account?> signInWithGoogle() async {
    final googleUser = await GoogleSignIn().signIn();
    final googleAuth = await googleUser?.authentication;
    final authCredential = GoogleAuthProvider.credential(
      idToken: googleAuth?.idToken,
      accessToken: googleAuth?.accessToken,
    );
    final userCredential = await _auth.signInWithCredential(authCredential);
    return userCredential.user?.toAccount();
  }
}

extension UserX on User {
  Account toAccount() {
    return Account._(
      uid,
      name: displayName,
      email: email,
      photoUrl: photoURL,
    );
  }
}
