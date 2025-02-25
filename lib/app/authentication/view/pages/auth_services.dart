import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

Future<UserCredential?> signInWithGoogle() async {
  try {
    // Begin interactive sign-in process
    final GoogleSignInAccount? guser = await GoogleSignIn().signIn();
    if (guser == null) {
      // User canceled the sign-in process
      return null;
    }

    // Obtain auth details from the request
    final GoogleSignInAuthentication gauth = await guser.authentication;

    // Create credentials for the user
    final credentials = GoogleAuthProvider.credential(
      accessToken: gauth.accessToken,
      idToken: gauth.idToken,
    );

    // Sign in with Firebase
    return await FirebaseAuth.instance.signInWithCredential(credentials);
  } catch (e) {
    print("Error signing in with Google: $e");
    return null;
  }
}
