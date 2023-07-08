import 'package:farma_compara/domain/core/failure.dart';

class FirestoreFailure extends Failure {
  const FirestoreFailure();
}

class FirestoreFailureInsufficientPermissions extends FirestoreFailure {
  const FirestoreFailureInsufficientPermissions();
}

class FirestoreFailureNotFound extends FirestoreFailure {
  const FirestoreFailureNotFound();
}

class FirestoreFailureUnexpected extends FirestoreFailure {
  const FirestoreFailureUnexpected();
}

class FirestoreConnectionFailure extends FirestoreFailure{
  const FirestoreConnectionFailure();
}