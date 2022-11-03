import 'package:dartz/dartz.dart';
import 'package:zstore_flutter/core/error/failures.dart';
import 'package:zstore_flutter/features/order_history/data/models/get_order_history_response_model.dart';
import 'package:zstore_flutter/features/order_tracking/data/models/order_tracking_request_model.dart';
import 'package:zstore_flutter/features/order_tracking/data/models/order_tracking_response_model.dart';

abstract class OrderTrackingRepository {
  Future<Either<Failure, OrderTrackingResponseModel>> trackOrder(OrderTrackingRequestModel params);

}
