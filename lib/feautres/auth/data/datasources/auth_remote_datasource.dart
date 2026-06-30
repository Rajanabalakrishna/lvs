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
    await GoogleSignIn.instance.initialize(
      serverClientId: '76682411676-4kpv6okt2g29b02p65k8pnmsq3rkj975.apps.googleusercontent.com',
    );
    final GoogleSignInAccount googleUser = await GoogleSignIn.instance.authenticate();

    final googleAuth = googleUser.authentication;
    final credential = GoogleAuthProvider.credential(
      idToken: googleAuth.idToken,  // idToken alone is enough for Firebase
    );

    final userCredential =
        await _firebaseAuth.signInWithCredential(credential);
    final user = userCredential.user;
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
