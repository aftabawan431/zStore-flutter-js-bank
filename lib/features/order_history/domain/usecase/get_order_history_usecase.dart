import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../../data/models/clear_order_history_response_model.dart';
import '../../data/models/get_order_history_details_response_model.dart';
import '../../data/models/get_order_history_response_model.dart';
import '../repository/order_history_repo.dart';

class GetOrderHistoryUsecase extends UseCase<GetOrderHistoryResponseModel, String> {
  OrderHistoryRepository repository;

  GetOrderHistoryUsecase(this.repository);

  @override
  Future<Either<Failure, GetOrderHistoryResponseModel>> call(String params) async {
    return await repository.getOrderHistory(params);
  }
}

class GetOrderHistoryDetailsUsecase extends UseCase<GetOrderHistoryDetailsResponseModel, String> {
  OrderHistoryRepository repository;

  GetOrderHistoryDetailsUsecase(this.repository);

  @override
  Future<Either<Failure, GetOrderHistoryDetailsResponseModel>> call(String params) async {
    return await repository.getOrderHistoryDetails(params);
  }
}
class ClearOrderHistoryUsecase extends UseCase<ClearOrderHistoryResponseModel, String> {
  OrderHistoryRepository repository;

  ClearOrderHistoryUsecase(this.repository);

  @override
  Future<Either<Failure, ClearOrderHistoryResponseModel>> call(String params) async {
    return await repository.clearOrderHistory(params);
  }
}