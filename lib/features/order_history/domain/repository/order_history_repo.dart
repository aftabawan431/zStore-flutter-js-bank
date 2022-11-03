import 'package:dartz/dartz.dart';

import '../../../../../core/error/failures.dart';
import '../../data/models/clear_order_history_response_model.dart';
import '../../data/models/get_order_history_details_response_model.dart';
import '../../data/models/get_order_history_response_model.dart';

abstract class OrderHistoryRepository {

  /// This method gets the orderHistory
  /// [Input]: [NoParams] contains no parameters
  /// [Output] : if operation successful returns [GetOrderHistoryResponseModel] returns the All the orders
  /// if unsuccessful the response will be [Failure]
  Future<Either<Failure, GetOrderHistoryResponseModel>> getOrderHistory(String params);

  /// This method gets the feedback
  /// [Input]: [NoParams] contains no parameters
  /// [Output] : if operation successful returns [GetOrderHistoryDetailsResponseModel] returns the successful submission of your feedback
  /// if unsuccessful the response will be [Failure]
  Future<Either<Failure, GetOrderHistoryDetailsResponseModel>> getOrderHistoryDetails(String params);

  /// This method gets the feedback
  /// [Input]: [NoParams] contains no parameters
  /// [Output] : if operation successful returns [ClearOrderHistoryResponseModel] returns the successful result of clear order history
  /// if unsuccessful the response will be [Failure]
  Future<Either<Failure, ClearOrderHistoryResponseModel>> clearOrderHistory(String params);
}
