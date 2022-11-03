import 'package:dartz/dartz.dart';
import 'package:zstore_flutter/features/reviews/data/models/add_review_details_response_model.dart';
import 'package:zstore_flutter/features/reviews/data/models/add_reviews_request_model.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../../data/models/get_all_reviews_response_model.dart';
import '../../data/models/see_review_details_response_model.dart';
import '../repository/reviews_repo.dart';

class GetReviewsUsecase
    extends UseCase< GetAllReviewsResponseModel, String> {
  ReviewsRepository repository;
  GetReviewsUsecase(this.repository);
  @override
  Future<Either<Failure, GetAllReviewsResponseModel>> call(
      String params) async {
    return await repository.getReviews(params);
  }
}
class SeeReviewDetailsUsecase
    extends UseCase< SeeReviewDetailsResponseModel, String> {
  ReviewsRepository repository;
  SeeReviewDetailsUsecase(this.repository);
  @override
  Future<Either<Failure, SeeReviewDetailsResponseModel>> call(
      String params) async {
    return await repository.seeReviews(params);
  }
}
class AddReviewsUsecase
    extends UseCase< AddReviewResponseModel, AddReviewRequestModel> {
  ReviewsRepository repository;

  AddReviewsUsecase(this.repository);

  @override
  Future<Either<Failure, AddReviewResponseModel>> call(
      AddReviewRequestModel params) async {
    return await repository.addReviews(params);
  }
}
