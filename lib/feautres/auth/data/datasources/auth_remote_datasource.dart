import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

abstract class AuthRemoteDataSource {
  Future<User> signInWithGoogle();
  Future<void> signOut();
  User? getCurrentUser();
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final FirebaseAuth _firebaseAuth;

  AuthRemoteDataSourceImpl({FirebaseAuth? firebaseAuth})
      : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance;

  @override
  Future<User> signInWithGoogle() async {
    // google_sign_in v7: initialize with serverClientId from
    // google-services.json (oauth_client -> client_id where client_type == 3)
    // Then authenticate() returns a GoogleSignInAccount with .authentication
    // which in v7 exposes idToken via serverAuthCode flow.
    //
    // For Firebase Auth the cleanest v7 approach is:
    // 1. Call GoogleSignIn.instance.authenticate()
    // 2. Use the returned GoogleSignInAccount.authentication
    //    which gives GoogleSignInAuthentication with idToken
    // 3. Pass idToken to GoogleAuthProvider.credential()
    //    (accessToken is optional for Firebase — idToken alone is enough)

    final googleSignIn = GoogleSignIn.instance;

    // Trigger the Google authentication flow
    final GoogleSignInAccount googleUser = await googleSignIn.authenticate();

    // Get the authentication object — in v7 this is synchronous
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    // Build Firebase credential — idToken is sufficient, accessToken optional
    final OAuthCredential credential = GoogleAuthProvider.credential(
      idToken: googleAuth.idToken,
      // accessToken removed — not available directly in v7
    );

    final UserCredential userCredential =
        await _firebaseAuth.signInWithCredential(credential);

    final User? user = userCredential.user;
    if (user == null) throw Exception('Firebase user is null after sign-in');
    return user;
  }

  @override
  Future<void> signOut() async {
    await GoogleSignIn.instance.signOut();
    await _firebaseAuth.signOut();
  }

  @override
  User? getCurrentUser() => _firebaseAuth.currentUser;
}
