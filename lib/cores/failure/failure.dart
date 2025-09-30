class Failure implements Exception {
  final String message;
  Failure(this.message);

  @override
  String toString() => message;
}

class ServerFailure extends Failure {
  ServerFailure(super.message);
}

class APIFailure extends Failure {
  APIFailure(super.message);
}

class UnauthorizedFailure extends Failure {
  UnauthorizedFailure(super.message);
}

class NetworkFailure extends Failure {
  NetworkFailure(super.message);
}

class FirebaseFailure extends Failure {
  FirebaseFailure(super.message);
}

class CacheFailure extends Failure {
  CacheFailure(super.message);
}
