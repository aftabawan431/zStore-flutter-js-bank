import 'package:dartz/dartz.dart';
import '../../../../../core/error/failures.dart';
import '../../data/models/add_review_details_response_model.dart';
import '../../data/models/add_reviews_request_model.dart';
import '../../data/models/get_all_reviews_response_model.dart';
import '../../data/models/see_review_details_response_model.dart';

abstract class ReviewsRepository {
  /// This method gets the the email and password
  /// [Input]: [String] contains productId
  /// [Output] : if operation successful returns [GetAllReviewsResponseModel] returns the successful reviews of that product
  /// if unsuccessful the response will be [Failure]
  Future<Either<Failure, GetAllReviewsResponseModel>> getReviews(String params);

  /// This method gets the the email and password
  /// [Input]: [String] contains reviewId
  /// [Output] : if operation successful returns [SeeReviewDetailsResponseModel] returns the successful details
  /// if unsuccessful the response will be [Failure]
  Future<Either<Failure, SeeReviewDetailsResponseModel>> seeReviews(
      String params);

  /// This method gets the the email and password
  /// [Input]: [AddReviewRequestModel] contains images,comments and rating
  /// [Output] : if operation successful returns [AddReviewResponseModel] returns the successful added review
  /// if unsuccessful the response will be [Failure]
  Future<Either<Failure, AddReviewResponseModel>> addReviews(
      AddReviewRequestModel params);
}
