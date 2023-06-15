import '../../core/either.dart';
import '../core/firestore_failure.dart';
import 'delivery_fee.dart';

abstract class IDeliveryRepository{
  Future<Either<FirestoreFailure, Map<String, DeliveryFee>>> updateDelivery();
}