

abstract class Failure {
  final String message;
  const Failure(this.message);
}

class ServerFailure extends Failure {
  const ServerFailure(super.message);
}

class CancelledFailure extends Failure {
  const CancelledFailure() : super('Sign-in cancelled');
}