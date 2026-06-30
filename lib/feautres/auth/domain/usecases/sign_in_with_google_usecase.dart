import 'package:dartz/dartz.dart';
import '../entities/user_entity.dart';
import '../repositories/auth_repository.dart';

class SignInWithGoogleUseCase {
  final AuthRepository repository;

  const SignInWithGoogleUseCase({required this.repository});

  Future<Either<String, UserEntity>> call() async {
    return repository.signInWithGoogle();
  }
}
