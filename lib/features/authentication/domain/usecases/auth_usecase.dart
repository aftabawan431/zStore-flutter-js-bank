import 'package:dartz/dartz.dart';
import 'package:zstore_flutter/features/authentication/data/modals/registration_request_model.dart';
import 'package:zstore_flutter/features/authentication/data/modals/registration_response_model.dart';

import '../../../../../core/error/failures.dart';
import '../../../../../core/usecases/usecase.dart';
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
import '../repository/auth_repo.dart';

class LoginUsecase extends UseCase<LoginResponseModel, LoginRequestModel> {
  AuthRepository repository;
  LoginUsecase(this.repository);

  @override
  Future<Either<Failure, LoginResponseModel>> call(LoginRequestModel params) async {
    return await repository.loginUser(params);
  }
}


///registration
class RegisterationUsecase extends UseCase<RegistrationResponseModel, RegistrationRequestModel> {
  AuthRepository repository;
  RegisterationUsecase(this.repository);

  @override
  Future<Either<Failure, RegistrationResponseModel>> call(RegistrationRequestModel params) async {
    return await repository.registerUser(params);
  }
}


class LogoutUsecase extends UseCase<LogoutResponseModel, LogoutRequestModel> {
  AuthRepository repository;
  LogoutUsecase(this.repository);

  @override
  Future<Either<Failure, LogoutResponseModel>> call(LogoutRequestModel params) async {
    return await repository.logoutUser(params);
  }
}

class GenerateOtpUsecase extends UseCase<ForgetPasswordResponseModel, GenerateOtpRequestModel> {
  AuthRepository repository;
  GenerateOtpUsecase(this.repository);

  @override
  Future<Either<Failure, ForgetPasswordResponseModel>> call(GenerateOtpRequestModel params) async {
    return await repository.generateOtp(params);
  }
}

class ValidateOtpUsecase extends UseCase<ValidateOtpResponseModel, ValidateOtpRequestModel> {
  AuthRepository repository;
  ValidateOtpUsecase(this.repository);

  @override
  Future<Either<Failure, ValidateOtpResponseModel>> call(ValidateOtpRequestModel params) async {
    return await repository.validateOtp(params);
  }
}

class UpdatePasswordUsecase extends UseCase<UpdatePasswordResponseModel, UpdatePasswordRequestModel> {
  AuthRepository repository;
  UpdatePasswordUsecase(this.repository);

  @override
  Future<Either<Failure, UpdatePasswordResponseModel>> call(UpdatePasswordRequestModel params) async {
    return await repository.updatePassword(params);
  }
}
