import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../../../authentication/data/modals/login_response_modal.dart';
import '../../data/models/get_profile_details_request_model.dart';
import '../../data/models/get_profile_details_response_model.dart';
import '../../data/models/profile_image_request_model.dart';
import '../../data/models/profile_image_response_model.dart';
import '../../data/models/update_profile_details_request_model.dart';
import '../../data/models/update_profile_details_response_model.dart';
import '../repository/profile_repo.dart';

class GetProfileDetailsUsecase extends UseCase<GetProfileDetailsResponseModel,
    GetProfileDetailsRequestModel> {
  ProfileRepository repository;
  GetProfileDetailsUsecase(this.repository);
  @override
  Future<Either<Failure, GetProfileDetailsResponseModel>> call(
      GetProfileDetailsRequestModel params) async {
    return await repository.getProfileDetails(params);
  }
}

class UpdateProfileDetailsUsecase extends UseCase<
    LoginResponseModel, UpdateProfileDetailsRequestModel> {
  ProfileRepository repository;
  UpdateProfileDetailsUsecase(this.repository);

  @override
  Future<Either<Failure, LoginResponseModel>> call(
      UpdateProfileDetailsRequestModel params) async {
    return await repository.updateProfileDetails(params);
  }
}
class UpdateProfileImageUsecase extends UseCase<LoginResponseModel, ProfileImageRequestModel> {
  ProfileRepository repository;
  UpdateProfileImageUsecase(this.repository);
  @override
  Future<Either<Failure, LoginResponseModel>> call(ProfileImageRequestModel params) async {
    return await repository.profileImage(params);
  }
}