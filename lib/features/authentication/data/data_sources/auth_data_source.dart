import 'dart:async';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:zstore_flutter/features/authentication/data/modals/registration_request_model.dart';
import 'package:zstore_flutter/features/authentication/data/modals/registration_response_model.dart';
import '../../../../core/constants/app_messages.dart';
import '../../../../core/constants/app_url.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/models/error_response_model.dart';
import '../../../../core/models/no_params.dart';
import '../../../../core/utils/globals/globals.dart';
import '../../../../core/utils/globals/show_app_bar.dart';
import '../../presentation/auth_view_model/authentication_view_model.dart';
import '../modals/forget_password_,request_model.dart';
import '../modals/forget_password_response_model.dart';
import '../modals/login_request_model.dart';
import '../modals/login_response_modal.dart';
import '../modals/logout_request_model.dart';
import '../modals/logout_response_model.dart';
import '../modals/update_password_request_model.dart';
import '../modals/update_password_response_model.dart';
import '../modals/validate_otp_request_model.dart';
import '../modals/validate_otp_response_model.dart';

abstract class AuthDataSource {
  /// [Input]: [LoginRequestModel] contains email and password
  /// [Output] : if operation successful returns [LoginResponseModel] returns the userId with image,userName and phoneNumber etc
  /// if unsuccessful the response will be [Failure]
  Future<LoginResponseModel> loginUser(LoginRequestModel params);

  /// [Input]: [LogoutRequestModel] contains userId
  /// [Output] : if operation successful returns [LogoutResponseModel] returns the expiration of token and session
  /// if unsuccessful the response will be [Failure]
  Future<LogoutResponseModel> logoutUser(LogoutRequestModel params);

  /// [Input]: [RegistrationRequestModel] contains firstName,lastName,phoneNum,email,passcode,address and gender etc
  /// [Output] : if operation successful returns [RegistrationResponseModel] returns the success message
  /// if unsuccessful the response will be [Failure]
  Future<RegistrationResponseModel> registerUser(RegistrationRequestModel params);

  /// [Input]: [ValidateOtpRequestModel] contains otp and email
  /// [Output] : if operation successful returns [ValidateOtpResponseModel] returns the success message
  /// if unsuccessful the response will be [Failure]
  Future<ValidateOtpResponseModel> validateOtp(ValidateOtpRequestModel params);

  /// This method generates new otp for the specified email
  /// [Input]: [GenerateOtpRequestModel] contains the user old password
  /// [Output] : if operation successful returns [NoParams] returns the just ok status
  /// if unsuccessful the response will be [Failure]
  Future<ForgetPasswordResponseModel> generateOtp(GenerateOtpRequestModel params);
  /// [Input]: [UpdatePasswordRequestModel] contains email,passcode and confirmPasscode
  /// [Output] : if operation successful returns [UpdatePasswordResponseModel] returns the success message
  /// if unsuccessful the response will be [Failure]
  Future<UpdatePasswordResponseModel> updatePassword(UpdatePasswordRequestModel params);
}

class AuthDataSourceImp implements AuthDataSource {
  Dio dio;

  AuthDataSourceImp({required this.dio});

  // Future<LoginResponseModel> loginUser(LoginRequestModel params) async {

  Future<LogoutResponseModel> logoutUser(LogoutRequestModel params) async {
    String url = AppUrl.customerBaseUrl + AppUrl.logoutUrl;
    print(jsonEncode(params));
    AuthViewModel authProvider = sl();
    try {
      // dio.options.headers['Authorization'] = 'Bearer ${authProvider.userDetails!.token.toString()}';
      final response = await dio.post(url, data: params.toJson());

      if (response.statusCode == 200) {
        var object = LogoutResponseModel.fromJson(response.data);

        return object;
      }

      throw const SomethingWentWrong(AppMessages.somethingWentWrong);
    } on DioError catch (exception) {
      Logger().i('returning error');
      if (exception.type == DioErrorType.connectTimeout) {
        throw TimeoutException(AppMessages.timeOut);
      } else {
        throw SomethingWentWrong(exception.response!.data['msg']);
      }
    }
  }


  @override
  Future<LoginResponseModel> loginUser(LoginRequestModel params) async {
    String url = AppUrl.customerBaseUrl + AppUrl.loginUrl;
    print(url);
    print(jsonEncode(params));
    print(jsonEncode(url));
    try {
      print("try ");
      final response = await dio.post(url, data: params.toJson());
      print(response.statusCode);

      if (response.statusCode == 200) {
        var object = LoginResponseModel.fromJson(response.data);
        ShowSnackBar.show(object.msg);


        return object;
      }


      throw const SomethingWentWrong(AppMessages.somethingWentWrong);
    } on DioError catch (exception) {
      Logger().i('returning error');
      if (exception.type == DioErrorType.connectTimeout) {
        throw TimeoutException(AppMessages.timeOut);
      } else {
        ErrorResponseModel errorResponseModel = ErrorResponseModel( statusMessage: exception.response!.data['msg']);
        print(errorResponseModel.statusMessage.toString());

        ShowSnackBar.show(errorResponseModel.statusMessage.toString());
        throw SomethingWentWrong(errorResponseModel.statusMessage);
      }
    } catch (e) {
      throw SomethingWentWrong(e.toString());
    }
  }

  ///register user
  @override
  Future<RegistrationResponseModel> registerUser(RegistrationRequestModel params) async {
    String url = AppUrl.customerBaseUrl + AppUrl.registerUrl;
    print(jsonEncode(params));
    try {
      final response = await dio.post(url, data: params.toJson());
      print(response.statusMessage);
      if (response.statusCode == 200) {
        var object = RegistrationResponseModel.fromJson(response.data);
        ShowSnackBar.show(object.msg);
        return object;
      }
      throw const SomethingWentWrong(AppMessages.somethingWentWrong);
    } on DioError catch (exception) {
      // print(exception.response!.data['msg']);
      Logger().i('returning error');
      if (exception.type == DioErrorType.connectTimeout) {
        throw TimeoutException(AppMessages.timeOut);
      } else {
        ErrorResponseModel errorResponseModel = ErrorResponseModel(statusMessage: exception.response!.data['msg']);
        print(errorResponseModel.statusMessage.toString());
        ShowSnackBar.show(errorResponseModel.statusMessage.toString());
        throw SomethingWentWrong(errorResponseModel.statusMessage);
      }
    } catch (e) {
      throw SomethingWentWrong(e.toString());
    }
  }

  @override
  Future<ValidateOtpResponseModel> validateOtp(ValidateOtpRequestModel params) async {
    String url = AppUrl.customerBaseUrl + AppUrl.validateOtpUrl;
    print(jsonEncode(params));

    try {
      final response = await dio.post(url, data: params.toJson());
      print(response);
      if (response.statusCode == 200) {
        var object = ValidateOtpResponseModel.fromJson(response.data);
        ShowSnackBar.show(object.message);
        return object;
      }
      throw const SomethingWentWrong(AppMessages.somethingWentWrong);
    } on DioError catch (exception) {
      // print(exception.response!.data['message']);
      Logger().i(exception.message);
      if (exception.type == DioErrorType.connectTimeout) {
        throw TimeoutException(AppMessages.timeOut);
      } else {
        ErrorResponseModel errorResponseModel = ErrorResponseModel( statusMessage: exception.response!.data['msg']);
        print(errorResponseModel.statusMessage.toString());
        ShowSnackBar.show(errorResponseModel.statusMessage.toString());
        throw SomethingWentWrong(errorResponseModel.statusMessage);
      }
    } catch (e) {
      throw SomethingWentWrong(e.toString());
    }
  }

  @override
  Future<ForgetPasswordResponseModel> generateOtp(GenerateOtpRequestModel params) async {
    print(params.toJson());
    String url = AppUrl.customerBaseUrl + AppUrl.generateOtpUrl;
    try {
      final response = await dio.post(url, data: params.toJson());
      print(response);
      if (response.statusCode == 200) {
        var object = ForgetPasswordResponseModel.fromJson(response.data);
        ShowSnackBar.show(object.message);
        return object;
      }
      throw const SomethingWentWrong(AppMessages.somethingWentWrong);
    } on DioError catch (exception) {
      // print(exception.response!.data['msg']);
      Logger().i('returning error');
      if (exception.type == DioErrorType.connectTimeout) {
        throw TimeoutException(AppMessages.timeOut);
      } else {
        ErrorResponseModel errorResponseModel = ErrorResponseModel( statusMessage: exception.response!.data['msg']);
        print(errorResponseModel.statusMessage.toString());
        ShowSnackBar.show(errorResponseModel.statusMessage.toString());
        throw SomethingWentWrong(errorResponseModel.statusMessage);
      }
    } catch (e) {
      throw SomethingWentWrong(e.toString());
    }
  }

  @override
  Future<UpdatePasswordResponseModel> updatePassword(UpdatePasswordRequestModel params) async {
    String url = AppUrl.customerBaseUrl + AppUrl.updatePasswordUrl;
    try {
      final response = await dio.post(url, data: params.toJson());
      print(response);
      if (response.statusCode == 200) {
        var object = UpdatePasswordResponseModel.fromJson(response.data);
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
        ErrorResponseModel errorResponseModel = ErrorResponseModel(statusMessage: exception.response!.data['msg']);
        print(errorResponseModel.statusMessage.toString());
        ShowSnackBar.show(errorResponseModel.statusMessage.toString());
        throw SomethingWentWrong(errorResponseModel.statusMessage);
      }
    } catch (e) {
      throw SomethingWentWrong(e.toString());
    }
  }
}
