import 'dart:async';
import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import '../../../../../core/constants/app_messages.dart';
import '../../../../../core/constants/app_url.dart';
import '../../../../../core/error/failures.dart';
import '../../../../../core/models/error_response_model.dart';
import '../../../../../core/utils/globals/show_app_bar.dart';
import '../models/get_total_points_response_model.dart';

abstract class MyPointsDataSource {

  /// This method gets the the userId
  /// [Input]: [NoParams] contains no parameters
  /// [Output] : if operation successful returns [GetTotalPointsResponseModel] returns the successful login
  /// if unsuccessful the response will be [Failure]
  Future<GetTotalPointsResponseModel> getTotalPoints(String params);


}

class MyPointsDataImp implements MyPointsDataSource {
  Dio dio;

  MyPointsDataImp({required this.dio});


  @override
  Future<GetTotalPointsResponseModel> getTotalPoints(String params) async {
    String url =
        AppUrl.saleManagementBaseUrl + AppUrl.getTotalPointsUrl + params;
    print(url);
    try {
      final response = await dio.get(
        url,
      );
      if (response.statusCode == 200) {

        var object = GetTotalPointsResponseModel.fromJson(response.data);
        print('helllo dear aftab ${object.toJson()}');

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

}

