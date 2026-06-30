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

// ── Auth Notifier (Riverpod v3 — Notifier replaces StateNotifier) ──
class AuthNotifier extends Notifier<AuthState> {
  @override
  AuthState build() {
    final dataSource = ref.read(authRemoteDataSourceProvider);
    final firebaseUser = dataSource.getCurrentUser();
    if (firebaseUser != null) {
      return AuthAuthenticated(UserEntity(
        uid: firebaseUser.uid,
        email: firebaseUser.email ?? '',
        displayName: firebaseUser.displayName ?? '',
        photoUrl: firebaseUser.photoURL,
      ));
    }
    return const AuthUnauthenticated();
  }

  Future<void> signInWithGoogle() async {
    state = const AuthLoading();
    final useCase = ref.read(signInWithGoogleUseCaseProvider);
    final result = await useCase();
    result.fold(
      (error) => state = AuthError(error),
      (user) => state = AuthAuthenticated(user),
    );
  }

  Future<void> signOut() async {
    state = const AuthLoading();
    final useCase = ref.read(signOutUseCaseProvider);
    final result = await useCase();
    result.fold(
      (error) => state = AuthError(error),
      (_) => state = const AuthUnauthenticated(),
    );
  }
}

final authNotifierProvider =
    NotifierProvider<AuthNotifier, AuthState>(AuthNotifier.new);
