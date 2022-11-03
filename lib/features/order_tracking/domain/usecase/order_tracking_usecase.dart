import 'package:dartz/dartz.dart';
import 'package:zstore_flutter/core/error/failures.dart';
import 'package:zstore_flutter/features/order_tracking/data/models/order_tracking_request_model.dart';

import '../../../../../core/usecases/usecase.dart';
import '../../data/models/order_tracking_response_model.dart';
import '../repository/order_tracking_repo.dart';


class OredrTrackingUsecase extends UseCase<OrderTrackingResponseModel, OrderTrackingRequestModel> {
  OrderTrackingRepository repository;

  OredrTrackingUsecase(this.repository);

  @override
  Future<Either<Failure, OrderTrackingResponseModel>> call(OrderTrackingRequestModel params) async {
    return await repository.trackOrder(params);
  }
}