import 'package:dartz/dartz.dart';
import 'package:zstore_flutter/core/constants/app_messages.dart';
import 'package:zstore_flutter/core/error/failures.dart';
import 'package:zstore_flutter/core/utils/network/network_info.dart';
import 'package:zstore_flutter/features/order_tracking/data/data_sources/order_tracking_data_source.dart';
import 'package:zstore_flutter/features/order_tracking/data/models/order_tracking_request_model.dart';
import 'package:zstore_flutter/features/order_tracking/data/models/order_tracking_response_model.dart';
import 'package:zstore_flutter/features/order_tracking/domain/repository/order_tracking_repo.dart';

class OrderTrackingRepoImp implements OrderTrackingRepository {
  final NetworkInfo networkInfo;

  final OrderTrackingDataSource orderTrackingDataSource;

  OrderTrackingRepoImp({
    required this.networkInfo,
    required this.orderTrackingDataSource,
  });




  @override
  Future<Either<Failure, OrderTrackingResponseModel>> trackOrder(OrderTrackingRequestModel params) async {
    if (!await networkInfo.isConnected) {
      return  Left(NetworkFailure(AppMessages.noInternet));
    }
    try {
      return Right(await orderTrackingDataSource.trackOrder(params));
    } on Failure catch (e) {
    return Left(e);
    } catch (e) {
    return Left(ServerFailure(e));
    }
  }

  }


