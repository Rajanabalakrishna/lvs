import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lvt/feautres/auth/data/datasources/auth_remote_datasource.dart';
import 'package:lvt/feautres/auth/data/repositories/auth_repository_impl.dart';
import 'package:lvt/feautres/auth/domain/entities/user_entity.dart';
import 'package:lvt/feautres/auth/domain/usecases/sign_in_with_google_usecase.dart';
import 'package:lvt/feautres/auth/domain/usecases/sign_out_usecase.dart';
import 'package:lvt/feautres/auth/presentation/state/auth_state.dart';

// ── Dependency Providers ─────────────────────────────────────
final authRemoteDataSourceProvider = Provider<AuthRemoteDataSource>(
  (ref) => AuthRemoteDataSourceImpl(),
);

final authRepositoryProvider = Provider<AuthRepositoryImpl>(
  (ref) => AuthRepositoryImpl(
    remoteDataSource: ref.watch(authRemoteDataSourceProvider),
  ),
);

final signInWithGoogleUseCaseProvider = Provider<SignInWithGoogleUseCase>(
  (ref) => SignInWithGoogleUseCase(
    repository: ref.watch(authRepositoryProvider),
  ),
);

final signOutUseCaseProvider = Provider<SignOutUseCase>(
  (ref) => SignOutUseCase(
    repository: ref.watch(authRepositoryProvider),
  ),
);

// ── Auth Notifier (BLoC-style StateNotifier) ─────────────────
class AuthNotifier extends StateNotifier<AuthState> {
  final SignInWithGoogleUseCase _signInWithGoogle;
  final SignOutUseCase _signOut;
  final AuthRemoteDataSource _dataSource;

  AuthNotifier({
    required SignInWithGoogleUseCase signInWithGoogle,
    required SignOutUseCase signOut,
    required AuthRemoteDataSource dataSource,
  })  : _signInWithGoogle = signInWithGoogle,
        _signOut = signOut,
        _dataSource = dataSource,
        super(const AuthState.initial()) {
    _checkCurrentUser();
  }

  void _checkCurrentUser() {
    final firebaseUser = _dataSource.getCurrentUser();
    if (firebaseUser != null) {
      final user = UserEntity(
        uid: firebaseUser.uid,
        email: firebaseUser.email ?? '',
        displayName: firebaseUser.displayName ?? '',
        photoUrl: firebaseUser.photoURL,
      );
      state = AuthState.authenticated(user);
    } else {
      state = const AuthState.unauthenticated();
    }
  }

  Future<void> signInWithGoogle() async {
    state = const AuthState.loading();
    final result = await _signInWithGoogle();
    result.fold(
      (error) => state = AuthState.error(error),
      (user) => state = AuthState.authenticated(user),
    );
  }

  Future<void> signOut() async {
    state = const AuthState.loading();
    final result = await _signOut();
    result.fold(
      (error) => state = AuthState.error(error),
      (_) => state = const AuthState.unauthenticated(),
    );
  }
}

final authNotifierProvider =
    StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  return AuthNotifier(
    signInWithGoogle: ref.watch(signInWithGoogleUseCaseProvider),
    signOut: ref.watch(signOutUseCaseProvider),
    dataSource: ref.watch(authRemoteDataSourceProvider),
  );
});
