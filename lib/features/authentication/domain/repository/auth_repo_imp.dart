import 'package:dartz/dartz.dart';
import 'package:logger/logger.dart';
import 'package:zstore_flutter/features/authentication/data/modals/registration_request_model.dart';
import 'package:zstore_flutter/features/authentication/data/modals/registration_response_model.dart';

import '../../../../../core/error/failures.dart';
import '../../../../../core/utils/network/network_info.dart';
import '../../../../core/constants/app_messages.dart';
import 'auth_repo.dart';
import '../../data/data_sources/auth_data_source.dart';
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

class AuthRepoImp implements AuthRepository {
  final NetworkInfo networkInfo;

  final AuthDataSource authDataSource;

  AuthRepoImp({
    required this.networkInfo,
    required this.authDataSource,
  });

  @override
  Future<Either<Failure, LoginResponseModel>> loginUser(LoginRequestModel params) async {
    if (!await networkInfo.isConnected) {
      return Left( NetworkFailure(AppMessages.noInternet));
    }

    try {
      return Right(await authDataSource.loginUser(params));
    } on Failure catch (e) {
      return Left(e);
    } catch (e) {
      return Left(ServerFailure(e));
    }
  }

  @override


  Future<Either<Failure, RegistrationResponseModel>> registerUser(RegistrationRequestModel params) async {
    if (!await networkInfo.isConnected) {
      return Left(const NetworkFailure(AppMessages.noInternet));
    }
    try {
      return Right(await authDataSource.registerUser(params));
    } on Failure catch (e) {
      return Left(e);
    } catch (e) {
      return Left(ServerFailure(e));
    }
  }
  @override
  Future<Either<Failure, LogoutResponseModel>> logoutUser(LogoutRequestModel params) async {
    if (!await networkInfo.isConnected) {
      return const Left(NetworkFailure(AppMessages.noInternet));
    }

    try {
      return Right(await authDataSource.logoutUser(params));
    } on Failure catch (e) {
      return Left(e);
    } catch (e) {
      return Left(ServerFailure(e));
    }
  }

  // @override
  // Future<Either<Failure, ForgetPasswordResponseModel>> forgetPassword(GenerateOtpRequestModel params) async {
  //   if (!await networkInfo.isConnected) {
  //     return Left(const NetworkFailure(AppMessages.noInternet));
  //   }
  //   print('here');
  //   try {
  //     return Right(await remoteDataSource.forgetPassword(params));
  //   } on Failure catch (e) {
  //     return Left(e);
  //   } catch (e) {
  //     return Left(ServerFailure(e));
  //   }
  // }

  @override
  Future<Either<Failure, ForgetPasswordResponseModel>> generateOtp(GenerateOtpRequestModel params) async {
    if (!await networkInfo.isConnected) {
      return const Left(NetworkFailure(AppMessages.noInternet));
    }
    try {
      return Right(await authDataSource.generateOtp(params));
    } on Failure catch (e) {
      return Left(e);
    } catch (e) {
      return Left(ServerFailure(e));
    }
  }

  @override
  Future<Either<Failure, ValidateOtpResponseModel>> validateOtp(ValidateOtpRequestModel params) async {
    if (!await networkInfo.isConnected) {
      return const Left(NetworkFailure(AppMessages.noInternet));
    }
    print('validate otp');
    try {
      return Right(await authDataSource.validateOtp(params));
    } on Failure catch (e) {
      Logger().v('here i am');
      Logger().v(e.toString());
      return Left(e);
    } catch (e) {
      return Left(ServerFailure(e));
    }
  }

  @override
  Future<Either<Failure, UpdatePasswordResponseModel>> updatePassword(UpdatePasswordRequestModel params) async {
    if (!await networkInfo.isConnected) {
      return const Left(NetworkFailure(AppMessages.noInternet));
    }
    print('validate otp');
    try {
      return Right(await authDataSource.updatePassword(params));
    } on Failure catch (e) {
      Logger().v('here i am');
      Logger().v(e.toString());
      return Left(e);
    } catch (e) {
      return Left(ServerFailure(e));
    }
  }
}
