import 'dart:async';
import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import '../../../../core/constants/app_messages.dart';
import '../../../../core/constants/app_url.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/models/error_response_model.dart';
import '../../../../core/utils/globals/show_app_bar.dart';
import '../models/feedback_request_model.dart';
import '../models/feedback_response_model.dart';
import '../models/get_feedback_response_model.dart';

abstract class FeedbackDataSource {
  /// This method add the feedback
  /// [Input]: [FeedbackRequestModel] contains comment,rating and channel
  /// [Output] : if operation successful returns [FeedbackResponseModel] returns the successful addedFeedback
  /// if unsuccessful the response will be [Failure]
  Future<FeedbackResponseModel> feedback(FeedbackRequestModel params);

  /// This method gets the feedback
  /// [Input]: [NoParams] contains no parameters
  /// [Output] : if operation successful returns [GetFeedbackResponseModel] returns the successful submission of your feedback
  /// if unsuccessful the response will be [Failure]
  Future<GetFeedbackResponseModel> getFeedback(String params);
}

class FeedbackDataImp implements FeedbackDataSource {
  Dio dio;

  FeedbackDataImp({required this.dio});

  @override
  Future<FeedbackResponseModel> feedback(FeedbackRequestModel params) async {
    String url = AppUrl.saleManagementBaseUrl + AppUrl.feedbacksUrl;

    try {
      final response = await dio.post(url, data: params.toJson());
      // final response = await dio.post(url,);

      print(response.statusMessage);
      if (response.statusCode == 200) {
        var object = FeedbackResponseModel.fromJson(response.data);
        ShowSnackBar.show('Feedback Posted Successful');
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

  Future<GetFeedbackResponseModel> getFeedback(String params) async {
    String url = AppUrl.saleManagementBaseUrl + AppUrl.getFeedbacksUrl + params;

    try {
      final response = await dio.get(url);
      // final response = await dio.post(url,);

      print(response.statusMessage);
      if (response.statusCode == 200) {
        var object = GetFeedbackResponseModel.fromJson(response.data);
        ShowSnackBar.show('Feedback  Successful');
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
