import 'package:firebase_auth/firebase_auth.dart';
import 'package:gd_store/src/auth/models/auth_result.dart';
import 'package:gd_store/src/auth/models/constants/constants.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Authenticator {
  const Authenticator();

  UserId? get userId => FirebaseAuth.instance.currentUser?.uid;
  bool get isAlreadyLoggedIn => userId != null;
  String get displayName =>
      FirebaseAuth.instance.currentUser?.displayName ?? '';
  String? get email => FirebaseAuth.instance.currentUser?.email;

  Future<void> logOut() async {
    // Sign out of all possible account forms
    await FirebaseAuth.instance.signOut();
    await GoogleSignIn().signOut();
  }

  Future<AuthResult> loginWithGoogle() async {
    // Signing in with google credentials
    final googleSignIn = GoogleSignIn(scopes: [AuthConstants.emailScope]);
    final signInAccount = await googleSignIn.signIn();

    // On error or termination of Signin
    if (signInAccount == null) {
      return AuthResult.failure;
    }

    final googleAuth = await signInAccount.authentication;
    final oauthCredential = GoogleAuthProvider.credential(
      idToken: googleAuth.idToken,
      accessToken: googleAuth.accessToken,
    );

    // Passing to firebase
    try {
      await FirebaseAuth.instance.signInWithCredential(oauthCredential);
      return AuthResult.success;
    } catch (e) {
      return AuthResult.failure;
    }
  }
}

typedef UserId = String;
