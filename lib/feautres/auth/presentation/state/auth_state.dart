import 'package:lvt/feautres/auth/domain/entities/user_entity.dart';

/// BLoC-style sealed state for authentication
class AuthState {
  const AuthState._();

  // Named constructors for each state
  const factory AuthState.initial() = _InitialState;
  const factory AuthState.loading() = _LoadingState;
  const factory AuthState.authenticated(UserEntity user) = _AuthenticatedState;
  const factory AuthState.unauthenticated() = _UnauthenticatedState;
  const factory AuthState.error(String message) = _ErrorState;

  /// Pattern-match helper (like Bloc's mapEventToState)
  T when<T>({
    required T Function() initial,
    required T Function() loading,
    required T Function(UserEntity user) authenticated,
    required T Function() unauthenticated,
    required T Function(String message) error,
  }) {
    final s = this;
    if (s is _InitialState) return initial();
    if (s is _LoadingState) return loading();
    if (s is _AuthenticatedState) return authenticated(s.user);
    if (s is _UnauthenticatedState) return unauthenticated();
    if (s is _ErrorState) return error(s.message);
    throw StateError('Unknown AuthState: $s');
  }
}

class _InitialState extends AuthState {
  const _InitialState() : super._();
}

class _LoadingState extends AuthState {
  const _LoadingState() : super._();
}

class _AuthenticatedState extends AuthState {
  final UserEntity user;
  const _AuthenticatedState(this.user) : super._();
}

class _UnauthenticatedState extends AuthState {
  const _UnauthenticatedState() : super._();
}

class _ErrorState extends AuthState {
  final String message;
  const _ErrorState(this.message) : super._();
}
