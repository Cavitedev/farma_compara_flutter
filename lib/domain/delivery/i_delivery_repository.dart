import '../../core/either.dart';
import '../items/firestore_failure.dart';
import 'delivery_fee.dart';

abstract class IDeliveryRepository{
  Future<Either<FirestoreFailure, List<DeliveryFee>>> updateDelivery();
}