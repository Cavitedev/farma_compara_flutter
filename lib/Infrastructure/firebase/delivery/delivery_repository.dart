
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farma_compara_flutter/domain/delivery/delivery_fee.dart';
import 'package:farma_compara_flutter/infrastructure/firebase/core/firebase_user_helper.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/either.dart';
import '../../../domain/delivery/i_delivery_repository.dart';
import '../../../domain/items/firestore_failure.dart';
import '../core/codes.dart';

final deliveryRepositoryProvider = Provider((ref) => DeliveryRepository(FirebaseFirestore.instance));

class DeliveryRepository implements IDeliveryRepository  {
  final FirebaseFirestore firestore;

  DeliveryRepository(this.firestore);

  @override
  Future<Either<FirestoreFailure, Map<String, DeliveryFee>>> updateDelivery() async {
    try {
      final CollectionReference<Map<String, dynamic>> collection = firestore.deliveryCollection();

      final QuerySnapshot<Map<String, dynamic>> firebaseQuery = await collection.get();

      final deliveryFees = Map.fromEntries(firebaseQuery.docs.map((doc) => MapEntry(doc.id, DeliveryFee.fromMap(doc.data()))));

      return Right(deliveryFees);

    } catch (e) {
      return Left(_handleException(e));
    }
  }


  FirestoreFailure _handleException(Object e) {
    if (e is PlatformException && (e.message!.contains(PERMISSIONDENIEDCODE) || e.code == UNATHORIZED)) {
      return const FirestoreFailureInsufficientPermissions();
    } else if (e is PlatformException && e.message!.contains(NOTFOUNDCODE)) {
      return const FirestoreFailureNotFound();
    } else {
      return const FirestoreFailureUnexpected();
    }
  }
}
