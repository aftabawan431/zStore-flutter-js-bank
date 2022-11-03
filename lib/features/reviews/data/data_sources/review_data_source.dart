import 'dart:async';
import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:zstore_flutter/features/reviews/data/models/add_review_details_response_model.dart';
import 'package:zstore_flutter/features/reviews/data/models/add_reviews_request_model.dart';
import '../../../../core/constants/app_messages.dart';
import '../../../../core/constants/app_url.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/models/error_response_model.dart';
import '../../../../core/utils/globals/show_app_bar.dart';
import '../models/get_all_reviews_response_model.dart';
import '../models/see_review_details_response_model.dart';

abstract class ReviewsDataSource {
  /// This method gets the the email and password
  /// [Input]: [String] contains productId
  /// [Output] : if operation successful returns [GetAllReviewsResponseModel] returns the successful reviews of that product
  /// if unsuccessful the response will be [Failure]
  Future<GetAllReviewsResponseModel> getAllReviews(String params);

  /// This method gets the the email and password
  /// [Input]: [String] contains reviewId
  /// [Output] : if operation successful returns [SeeReviewDetailsResponseModel] returns the successful details
  /// if unsuccessful the response will be [Failure]
  Future<SeeReviewDetailsResponseModel> seeReviewDetails(String params);

  /// This method gets the the email and password
  /// [Input]: [AddReviewRequestModel] contains images,comments and rating
  /// [Output] : if operation successful returns [AddReviewResponseModel] returns the successful added review
  /// if unsuccessful the response will be [Failure]
  Future<AddReviewResponseModel> addReviews(AddReviewRequestModel params);
}

class ReviewsDataImp implements ReviewsDataSource {
  Dio dio;

  ReviewsDataImp({required this.dio});

  Future<AddReviewResponseModel> addReviews(
      AddReviewRequestModel params) async {
    String url = AppUrl.saleManagementBaseUrl + AppUrl.addReviewsUrl;
    print(params.toJson());
    print(params.toJson());

    try {
      final response = await dio.post(url, data: params.toJson());
      print(response.statusMessage);
      if (response.statusCode == 200) {
        var object = AddReviewResponseModel.fromJson(response.data);
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

  @override
  Future<GetAllReviewsResponseModel> getAllReviews(String params) async {
    String url =
        AppUrl.saleManagementBaseUrl + AppUrl.getAllReviewsUrl + params;
    print('helllo dear aftab $url');
    try {
      final response = await dio.get(
        url,
      );

      print(response.statusCode);
      if (response.statusCode == 200) {
        var object = GetAllReviewsResponseModel.fromJson(response.data);
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

  @override
  Future<SeeReviewDetailsResponseModel> seeReviewDetails(String params) async {
    String url =
        AppUrl.saleManagementBaseUrl + AppUrl.getAllReviewsDetailsUrl + params;
    print('helllo dear aftab $url');
    try {
      final response = await dio.get(
        url,
      );

      print(response.statusCode);
      if (response.statusCode == 200) {
        var object = SeeReviewDetailsResponseModel.fromJson(response.data);
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
