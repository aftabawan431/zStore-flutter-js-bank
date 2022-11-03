import 'package:dartz/dartz.dart';
import 'package:zstore_flutter/features/profile/data/models/update_profile_details_request_model.dart';

import '../../../../../core/error/failures.dart';
import '../../../authentication/data/modals/login_response_modal.dart';
import '../../data/models/get_profile_details_request_model.dart';
import '../../data/models/get_profile_details_response_model.dart';
import '../../data/models/profile_image_request_model.dart';
import '../../data/models/profile_image_response_model.dart';

abstract class ProfileRepository {
  /// This method gets profile details
  /// [Input]: [GetProfileDetailsRequestModel] contains userId
  /// [Output] : if operation successful returns [GetProfileDetailsResponseModel] returns the successful profile details
  /// if unsuccessful the response will be [Failure]
  Future<Either<Failure, GetProfileDetailsResponseModel>> getProfileDetails(
      GetProfileDetailsRequestModel params);

  /// This method gets profile details
  /// [Input]: [UpdateProfileDetailsRequestModel] contains name,address and
  /// [Output] : if operation successful returns [LoginResponseModel] returns the successful update login response
  /// if unsuccessful the response will be [Failure]
  Future<Either<Failure, LoginResponseModel>> updateProfileDetails(
      UpdateProfileDetailsRequestModel params);

  /// This method is to change the profile header image in profile header
  /// [Input]: [ProfileImageRequestModel] contains the user id and the image if existing the the value will be true other vice versa
  /// [Output] : if operation successful returns [ProfileImageResponseModel] returns the the updated of profile image
  /// if unsuccessful the response will be [Failure]
  Future<Either<Failure, LoginResponseModel>> profileImage(
      ProfileImageRequestModel params);
}
