import 'package:flutter/services.dart';

import '../../../domain/core/firestore_failure.dart';

class FirebaseErrors{
  static const String permissionDeniedCode = "PERMISSION_DENIED";
  static const String unathorized = "unauthorized";
  static const String notFoundCode = "NOT_FOUND";
  static const String notAvailable =  "UNAVAILABLE";

  static FirestoreFailure handleException(Object e) {
    if (e is PlatformException && (e.message!.contains(permissionDeniedCode) || e.code == unathorized)) {
      return const FirestoreFailureInsufficientPermissions();
    } else if (e is PlatformException && e.message!.contains(notFoundCode)) {
      return const FirestoreFailureNotFound();
    } else if (e is PlatformException && e.message!.contains(notAvailable)) {
      return const FirestoreConnectionFailure();
    }   else {
      return const FirestoreFailureUnexpected();
    }
  }

}


