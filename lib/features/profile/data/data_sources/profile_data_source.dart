import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:zstore_flutter/features/authentication/data/modals/login_response_modal.dart';
import '../../../../core/constants/app_messages.dart';
import '../../../../core/constants/app_url.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/models/error_response_model.dart';
import '../../../../core/utils/globals/show_app_bar.dart';
import '../models/get_profile_details_request_model.dart';
import '../models/get_profile_details_response_model.dart';
import '../models/profile_image_request_model.dart';
import '../models/profile_image_response_model.dart';
import '../models/update_profile_details_request_model.dart';

abstract class ProfileDataSource {
  /// This method gets profile details
  /// [Input]: [GetProfileDetailsRequestModel] contains userId
  /// [Output] : if operation successful returns [GetProfileDetailsResponseModel] returns the successful profile details
  /// if unsuccessful the response will be [Failure]
  Future<GetProfileDetailsResponseModel> getProfileDetails(
      GetProfileDetailsRequestModel params);

  /// This method gets profile details
  /// [Input]: [UpdateProfileDetailsRequestModel] contains name,address and
  /// [Output] : if operation successful returns [LoginResponseModel] returns the successful update login response
  /// if unsuccessful the response will be [Failure]
  Future<LoginResponseModel> updateProfileDetails(
      UpdateProfileDetailsRequestModel params);

  /// This method is to change the profile header image in profile header
  /// [Input]: [ProfileImageRequestModel] contains the user id and the image if existing the the value will be true other vice versa
  /// [Output] : if operation successful returns [ProfileImageResponseModel] returns the the updated of profile image
  /// if unsuccessful the response will be [Failure]
  Future<LoginResponseModel> updateProfileImage(
      ProfileImageRequestModel params);
}

class ProfileDataRepoImp implements ProfileDataSource {
  Dio dio;

  ProfileDataRepoImp({required this.dio});

  @override
  Future<GetProfileDetailsResponseModel> getProfileDetails(
      GetProfileDetailsRequestModel params) async {
    String url = AppUrl.customerBaseUrl + AppUrl.getProfileDetailsUrl;

    try {
      final response = await dio.post(url, data: params.toJson());
      // final response = await dio.post(url,);

      print(response.statusMessage);
      if (response.statusCode == 200) {
        var object = GetProfileDetailsResponseModel.fromJson(response.data);
        ShowSnackBar.show(object.StatusMessage);
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
  Future<LoginResponseModel> updateProfileDetails(
      UpdateProfileDetailsRequestModel params) async {
    String url = AppUrl.customerBaseUrl + AppUrl.updateProfileDetailsUrl;
    print(jsonEncode(params));
    print(url);
    try {
      final response = await dio.patch(url, data: params.toJson());
      // final response = await dio.post(url,);

      print(response.statusMessage);
      if (response.statusCode == 200) {
        var object = LoginResponseModel.fromJson(response.data);
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
  Future<LoginResponseModel> updateProfileImage(
      ProfileImageRequestModel params) async {
    String url = AppUrl.customerBaseUrl + AppUrl.profileImageUrl;
    log(jsonEncode(params));
    try {
      final response = await dio.patch(
        url,
        data: params.toJson(),
      );

      if (response.statusCode == 200) {
        return LoginResponseModel.fromJson(response.data);
      }

      throw const SomethingWentWrong(AppMessages.somethingWentWrong);
    } on DioError catch (exception) {
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
