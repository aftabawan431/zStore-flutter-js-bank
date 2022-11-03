import 'package:dartz/dartz.dart';
import 'package:zstore_flutter/features/profile/data/models/get_profile_details_request_model.dart';
import 'package:zstore_flutter/features/profile/data/models/get_profile_details_response_model.dart';
import 'package:zstore_flutter/features/profile/data/models/profile_image_request_model.dart';
import 'package:zstore_flutter/features/profile/data/models/profile_image_response_model.dart';
import 'package:zstore_flutter/features/profile/data/models/update_profile_details_request_model.dart';

import '../../../../../core/error/failures.dart';
import '../../../../../core/utils/network/network_info.dart';
import '../../../../core/constants/app_messages.dart';
import '../../../authentication/data/modals/login_response_modal.dart';
import '../../data/data_sources/profile_data_source.dart';
import '../../data/models/update_profile_details_response_model.dart';
import '../../domain/repository/profile_repo.dart';

class ProfileRepoImp implements ProfileRepository {
  final NetworkInfo networkInfo;

  final ProfileDataSource profileDataSource;

  ProfileRepoImp({
    required this.networkInfo,
    required this.profileDataSource,
  });



  @override
  Future<Either<Failure, GetProfileDetailsResponseModel>> getProfileDetails(GetProfileDetailsRequestModel params) async {
    if (!await networkInfo.isConnected) {
      return Left(const NetworkFailure(AppMessages.noInternet));
    }
    print('here');
    try {
      return Right(await profileDataSource.getProfileDetails(params));
    } on Failure catch (e) {
    return Left(e);
    } catch (e) {
    return Left(ServerFailure(e));
    }
  }

  @override
  Future<Either<Failure, LoginResponseModel>> updateProfileDetails(UpdateProfileDetailsRequestModel params) async {
    if (!await networkInfo.isConnected) {
      return Left(const NetworkFailure(AppMessages.noInternet));
    }
    print('here');
    try {
      return Right(await profileDataSource.updateProfileDetails(params));
    } on Failure catch (e) {
    return Left(e);
    } catch (e) {
    return Left(ServerFailure(e));
    }
  }

  @override
  Future<Either<Failure, LoginResponseModel>> profileImage(ProfileImageRequestModel params) async{
    if (!await networkInfo.isConnected) {
      return Left(const NetworkFailure(AppMessages.noInternet));
    }
    print('here');
    try {
      return Right(await profileDataSource.updateProfileImage(params));
    } on Failure catch (e) {
    return Left(e);
    } catch (e) {
    return Left(ServerFailure(e));
    }
  }


}
