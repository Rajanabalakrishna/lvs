import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

abstract class AuthRemoteDataSource {
  Future<User> signInWithGoogle();
  Future<void> signOut();
  User? getCurrentUser();
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final FirebaseAuth _firebaseAuth;

  // Web Client ID (client_type: 3) from google-services.json
  static const String _serverClientId =
      '76682411676-4kpv6okt2g29b02p65k8pnmsq3rkj975.apps.googleusercontent.com';

  AuthRemoteDataSourceImpl({FirebaseAuth? firebaseAuth})
      : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance;

  @override
  Future<User> signInWithGoogle() async {
    // google_sign_in v7: must call initialize() with serverClientId on Android
    await GoogleSignIn.instance.initialize(
      serverClientId: _serverClientId,
    );

    final GoogleSignInAccount googleUser =
        await GoogleSignIn.instance.authenticate();

    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    final OAuthCredential credential = GoogleAuthProvider.credential(
      idToken: googleAuth.idToken,
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
