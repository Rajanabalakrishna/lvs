import 'package:dartz/dartz.dart';
import '../repositories/auth_repository.dart';

class SignOutUseCase {
  final AuthRepository repository;

  const SignOutUseCase({required this.repository});

  Future<Either<String, void>> call() async {
    return repository.signOut();
  }
}
