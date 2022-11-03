import 'dart:async';

import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:zstore_flutter/features/order_tracking/data/models/order_tracking_request_model.dart';
import 'package:zstore_flutter/features/order_tracking/data/models/order_tracking_response_model.dart';

import '../../../../core/constants/app_messages.dart';
import '../../../../core/constants/app_url.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/models/error_response_model.dart';
import '../../../../core/utils/globals/show_app_bar.dart';

abstract class OrderTrackingDataSource {
  Future<OrderTrackingResponseModel> trackOrder(
      OrderTrackingRequestModel params);

}
class OrderTrackingDataImp implements OrderTrackingDataSource {
  Dio dio;

  OrderTrackingDataImp({required this.dio});



  @override
  Future<OrderTrackingResponseModel> trackOrder(OrderTrackingRequestModel params) async {
    String url = AppUrl.saleManagementBaseUrl + AppUrl.getOrderHistoryUrl ;
    print('hello buddy this is url $url');

    try {
      final response = await dio.get(
        url,
      );

      print(response.statusMessage);
      if (response.statusCode == 200) {
        var object = OrderTrackingResponseModel.fromJson(response.data);
        // ShowSnackBar.show(object.msg);
        return object;
      }

      throw  SomethingWentWrong(AppMessages.somethingWentWrong);
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

