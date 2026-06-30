import 'package:dartz/dartz.dart';
import '../entities/user_entity.dart';

abstract class AuthRepository {
  Future<Either<String, UserEntity>> signInWithGoogle();
  Future<Either<String, void>> signOut();
  UserEntity? getCurrentUser();
}
