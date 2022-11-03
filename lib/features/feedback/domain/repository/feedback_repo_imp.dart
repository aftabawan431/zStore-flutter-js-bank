import 'package:dartz/dartz.dart';
import 'package:zstore_flutter/features/feedback/data/models/get_feedback_response_model.dart';
import '../../../../../core/error/failures.dart';
import '../../../../../core/utils/network/network_info.dart';
import '../../../../core/constants/app_messages.dart';
import '../../data/data_sources/feedback_data_source.dart';
import '../../data/models/feedback_request_model.dart';
import '../../data/models/feedback_response_model.dart';
import '../../domain/repository/feedback_repo.dart';

class FeedbackRepoImp implements FeedbackRepository {
  final NetworkInfo networkInfo;

  final FeedbackDataSource dataSource;

  FeedbackRepoImp({
    required this.networkInfo,
    required this.dataSource,
  });


  @override
  Future<Either<Failure, FeedbackResponseModel>> addFeedback(FeedbackRequestModel params) async {
    if (!await networkInfo.isConnected) {
      return Left(const NetworkFailure(AppMessages.noInternet));
    }
    try {
      return Right(await dataSource.feedback(params));
    } on Failure catch (e) {
    return Left(e);
    } catch (e) {
    return Left(ServerFailure(e));
    }
  }



  @override
  Future<Either<Failure, GetFeedbackResponseModel>> getFeedback(String params) async {
    if (!await networkInfo.isConnected) {
      return Left(const NetworkFailure(AppMessages.noInternet));
    }
    try {
      return Right(await dataSource.getFeedback(params));
    } on Failure catch (e) {
    return Left(e);
    } catch (e) {
    return Left(ServerFailure(e));
    }
  }



}
