import 'package:dartz/dartz.dart';
import 'package:zstore_flutter/core/models/no_params.dart';
import 'package:zstore_flutter/features/order_history/data/models/clear_order_history_response_model.dart';
import 'package:zstore_flutter/features/order_history/data/models/get_order_history_response_model.dart';

import '../../../../../core/error/failures.dart';
import '../../../../../core/utils/network/network_info.dart';
import '../../../../core/constants/app_messages.dart';
import '../../data/data_sources/order_history_data_source.dart';
import '../../data/models/get_order_history_details_response_model.dart';
import 'order_history_repo.dart';

class OrderHistoryRepoImp implements OrderHistoryRepository {
  final NetworkInfo networkInfo;

  final OrderHistoryDataSource orderHistoryDataSource;

  OrderHistoryRepoImp({
    required this.networkInfo,
    required this.orderHistoryDataSource,
  });


  @override
  Future<Either<Failure, GetOrderHistoryResponseModel>> getOrderHistory(String  params)async {
    if (!await networkInfo.isConnected) {
      return const Left(NetworkFailure(AppMessages.noInternet));
    }
    try {
      return Right(await orderHistoryDataSource.getOrderHistory(params));
    } on Failure catch (e) {
    return Left(e);
    } catch (e) {
    return Left(ServerFailure(e));
    }
  }

  @override
  Future<Either<Failure, GetOrderHistoryDetailsResponseModel>> getOrderHistoryDetails(String params)async {
    if (!await networkInfo.isConnected) {
      return const Left(NetworkFailure(AppMessages.noInternet));
    }
    try {
      return Right(await orderHistoryDataSource.getOrderHistoryDetails(params));
    } on Failure catch (e) {
    return Left(e);
    } catch (e) {
    return Left(ServerFailure(e));
    }
  }

  @override
  Future<Either<Failure, ClearOrderHistoryResponseModel>> clearOrderHistory(String params) async{
    if (!await networkInfo.isConnected) {
      return const Left(NetworkFailure(AppMessages.noInternet));
    }
    try {
      return Right(await orderHistoryDataSource.clearOrderHistory(params));
    } on Failure catch (e) {
    return Left(e);
    } catch (e) {
    return Left(ServerFailure(e));
    }
  }

}
