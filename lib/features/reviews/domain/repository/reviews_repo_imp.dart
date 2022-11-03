import 'package:dartz/dartz.dart';
import 'package:zstore_flutter/features/reviews/data/models/add_review_details_response_model.dart';
import 'package:zstore_flutter/features/reviews/data/models/add_reviews_request_model.dart';
import 'package:zstore_flutter/features/reviews/data/models/get_all_reviews_response_model.dart';
import 'package:zstore_flutter/features/reviews/data/models/see_review_details_response_model.dart';

import '../../../../../core/error/failures.dart';
import '../../../../../core/utils/network/network_info.dart';
import '../../../../core/constants/app_messages.dart';
import '../../data/data_sources/review_data_source.dart';
import 'reviews_repo.dart';

class ReviewsRepoImp implements ReviewsRepository {
  final NetworkInfo networkInfo;

  final ReviewsDataSource dataSource;

  ReviewsRepoImp({
    required this.networkInfo,
    required this.dataSource,
  });



  @override
  Future<Either<Failure, GetAllReviewsResponseModel>> getReviews(String productId) async {
    if (!await networkInfo.isConnected) {
      return const Left(NetworkFailure(AppMessages.noInternet));
    }
    try {
      return Right(await dataSource.getAllReviews(productId));
    } on Failure catch (e) {
    return Left(e);
    } catch (e) {
    return Left(ServerFailure(e));
    }
  }

  @override
  Future<Either<Failure, AddReviewResponseModel>> addReviews(AddReviewRequestModel params)async {
    if (!await networkInfo.isConnected) {
      return const Left(NetworkFailure(AppMessages.noInternet));
    }
    try {
      return Right(await dataSource.addReviews(params));
    } on Failure catch (e) {
    return Left(e);
    } catch (e) {
    return Left(ServerFailure(e));
    }
  }

  @override
  Future<Either<Failure, SeeReviewDetailsResponseModel>> seeReviews(String params) async{
    if (!await networkInfo.isConnected) {
      return const Left( NetworkFailure(AppMessages.noInternet));
    }
    try {
      return Right(await dataSource.seeReviewDetails(params));
    } on Failure catch (e) {
    return Left(e);
    } catch (e) {
    return Left(ServerFailure(e));
    }
  }



}
