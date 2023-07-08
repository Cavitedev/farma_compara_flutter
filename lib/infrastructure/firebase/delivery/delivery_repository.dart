
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farma_compara/domain/delivery/delivery_fee.dart';
import 'package:farma_compara/infrastructure/firebase/core/firebase_user_helper.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/either.dart';
import '../../../domain/delivery/i_delivery_repository.dart';
import '../../../domain/core/firestore_failure.dart';
import '../core/firebase_errors.dart';

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
      return Left(FirebaseErrors.handleException(e));
    }
  }



}
