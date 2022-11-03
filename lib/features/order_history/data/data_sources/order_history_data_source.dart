import 'dart:async';
import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:zstore_flutter/core/models/no_params.dart';
import '../../../../core/constants/app_messages.dart';
import '../../../../core/constants/app_url.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/models/error_response_model.dart';
import '../../../../core/utils/globals/show_app_bar.dart';
import '../models/clear_order_history_response_model.dart';
import '../models/get_order_history_details_response_model.dart';
import '../models/get_order_history_response_model.dart';

abstract class OrderHistoryDataSource {
  /// This method gets the the email and password
  /// [Input]: [NoParams] contains id
  /// [Output] : if operation successful returns [GetProfileDetailsResponseModel] returns the successful login
  /// if unsuccessful the response will be [Failure]
  Future<GetOrderHistoryResponseModel> getOrderHistory(String params);

  /// This method gets the the email and password
  /// [Input]: [NoParams] contains id
  /// [Output] : if operation successful returns [GetOrderHistoryDetailsResponseModel] returns the successful login
  /// if unsuccessful the response will be [Failure]
  Future<GetOrderHistoryDetailsResponseModel> getOrderHistoryDetails(String params);

  /// This method gets the the email and password
  /// [Input]: [NoParams] contains id
  /// [Output] : if operation successful returns [GetProfileDetailsResponseModel] returns the successful login
  /// if unsuccessful the response will be [Failure]
  Future<ClearOrderHistoryResponseModel> clearOrderHistory(String params);
}

class OrderHistoryDataImp implements OrderHistoryDataSource {
  Dio dio;

  OrderHistoryDataImp({required this.dio});

  @override
  Future<GetOrderHistoryResponseModel> getOrderHistory(String params) async {
    String url = AppUrl.saleManagementBaseUrl + AppUrl.getOrderHistoryUrl + params;
    print('hello buddy this is url $url');

    try {
      final response = await dio.get(
        url,
      );

      print(response.statusMessage);
      if (response.statusCode == 200) {
        var object = GetOrderHistoryResponseModel.fromJson(response.data);
        // ShowSnackBar.show(object.msg);
        return object;
      }

      throw const SomethingWentWrong(AppMessages.somethingWentWrong);
    } on DioError catch (exception) {
      print(exception.response!.data['msg']);
      Logger().i('returning error');
      if (exception.type == DioErrorType.connectTimeout) {
        throw TimeoutException(AppMessages.timeOut);
      } else {
        ErrorResponseModel errorResponseModel =
            ErrorResponseModel(statusMessage: exception.response!.data['msg']);
        print(errorResponseModel.statusMessage.toString());
        ShowSnackBar.show(errorResponseModel.statusMessage.toString());
        throw SomethingWentWrong(errorResponseModel.statusMessage);
      }
    } catch (e) {
      throw SomethingWentWrong(e.toString());
    }
  }

  @override
  Future<GetOrderHistoryDetailsResponseModel> getOrderHistoryDetails(
      String params) async {
    String url =
        AppUrl.saleManagementBaseUrl + AppUrl.getOrderHistoryDetailsUrl + params;

    try {
      final response = await dio.get(
        url,
      );

      print(response.statusMessage);
      if (response.statusCode == 200) {
        var object = GetOrderHistoryDetailsResponseModel.fromJson(response.data);
        ShowSnackBar.show(object.msg);
        return object;
      }

      throw const SomethingWentWrong(AppMessages.somethingWentWrong);
    } on DioError catch (exception) {
      print(exception.response!.data['msg']);
      Logger().i('returning error');
      if (exception.type == DioErrorType.connectTimeout) {
        throw TimeoutException(AppMessages.timeOut);
      } else {
        ErrorResponseModel errorResponseModel =
            ErrorResponseModel(statusMessage: exception.response!.data['msg']);
        print(errorResponseModel.statusMessage.toString());
        ShowSnackBar.show(errorResponseModel.statusMessage.toString());
        throw SomethingWentWrong(errorResponseModel.statusMessage);
      }
    } catch (e) {
      throw SomethingWentWrong(e.toString());
    }
  }
  Future<ClearOrderHistoryResponseModel> clearOrderHistory(
      String params) async {
    String url =
        AppUrl.saleManagementBaseUrl + AppUrl.clearOrderHistoryUrl + params;
print(url);
    try {
      final response = await dio.get(
        url,
      );

      print(response.statusMessage);
      if (response.statusCode == 200) {
        var object = ClearOrderHistoryResponseModel.fromJson(response.data);
        // ShowSnackBar.show(object.msg);
        return object;
      }

      throw const SomethingWentWrong(AppMessages.somethingWentWrong);
    } on DioError catch (exception) {
      print(exception.response!.data['msg']);
      Logger().i('returning error');
      if (exception.type == DioErrorType.connectTimeout) {
        throw TimeoutException(AppMessages.timeOut);
      } else {
        ErrorResponseModel errorResponseModel =
            ErrorResponseModel(statusMessage: exception.response!.data['msg']);
        print(errorResponseModel.statusMessage.toString());
        ShowSnackBar.show(errorResponseModel.statusMessage.toString());
        throw SomethingWentWrong(errorResponseModel.statusMessage);
      }
    } catch (e) {
      throw SomethingWentWrong(e.toString());
    }
  }
}
