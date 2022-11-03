import 'package:dartz/dartz.dart';
import 'package:zstore_flutter/features/authentication/data/modals/registration_request_model.dart';
import 'package:zstore_flutter/features/authentication/data/modals/registration_response_model.dart';

import '../../../../../core/error/failures.dart';
import '../../data/modals/forget_password_,request_model.dart';
import '../../data/modals/forget_password_response_model.dart';
import '../../data/modals/login_request_model.dart';
import '../../data/modals/login_response_modal.dart';
import '../../data/modals/logout_request_model.dart';
import '../../data/modals/logout_response_model.dart';
import '../../data/modals/update_password_request_model.dart';
import '../../data/modals/update_password_response_model.dart';
import '../../data/modals/validate_otp_request_model.dart';
import '../../data/modals/validate_otp_response_model.dart';

abstract class AuthRepository {
  /// [Input]: [LoginRequestModel] contains email and password
  /// [Output] : if operation successful returns [LoginResponseModel] returns the userId with image,userName and phoneNumber etc
  /// if unsuccessful the response will be [Failure]
  Future<Either<Failure, LoginResponseModel>> loginUser(LoginRequestModel params);
  /// [Input]: [LogoutRequestModel] contains userId
  /// [Output] : if operation successful returns [LogoutResponseModel] returns the expiration of token and session
  /// if unsuccessful the response will be [Failure]
  Future<Either<Failure, LogoutResponseModel>> logoutUser(LogoutRequestModel params);
  /// [Input]: [GenerateOtpRequestModel] contains email
  /// [Output] : if operation successful returns [ForgetPasswordResponseModel] returns the message of otp pin code
  /// if unsuccessful the response will be [Failure]
  Future<Either<Failure, ForgetPasswordResponseModel>> generateOtp(GenerateOtpRequestModel params);
  /// [Input]: [ValidateOtpRequestModel] contains otp and email
  /// [Output] : if operation successful returns [ValidateOtpResponseModel] returns the success message
  /// if unsuccessful the response will be [Failure]
  Future<Either<Failure, ValidateOtpResponseModel>> validateOtp(ValidateOtpRequestModel params);
  /// [Input]: [UpdatePasswordRequestModel] contains email,passcode and confirmPasscode
  /// [Output] : if operation successful returns [UpdatePasswordResponseModel] returns the success message
  /// if unsuccessful the response will be [Failure]
  Future<Either<Failure, UpdatePasswordResponseModel>> updatePassword(UpdatePasswordRequestModel params);
  /// [Input]: [RegistrationRequestModel] contains firstName,lastName,phoneNum,email,passcode,address and gender etc
  /// [Output] : if operation successful returns [RegistrationResponseModel] returns the success message
  /// if unsuccessful the response will be [Failure]
  Future<Either<Failure, RegistrationResponseModel>> registerUser(RegistrationRequestModel params);
}