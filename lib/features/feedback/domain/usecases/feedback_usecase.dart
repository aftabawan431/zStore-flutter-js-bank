import 'package:dartz/dartz.dart';
import 'package:zstore_flutter/features/feedback/data/models/get_feedback_response_model.dart';
import 'package:zstore_flutter/features/my_favrouits/data/models/get_favourites_response_model.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../../data/models/feedback_request_model.dart';
import '../../data/models/feedback_response_model.dart';
import '../repository/feedback_repo.dart';

class FeedbackUsecase extends UseCase<FeedbackResponseModel,
    FeedbackRequestModel> {
  FeedbackRepository repository;
  FeedbackUsecase(this.repository);
  @override
  Future<Either<Failure, FeedbackResponseModel>> call(
      FeedbackRequestModel params) async {
    return await repository.addFeedback(params);
  }
}
class GetFeedbackUsecase extends UseCase<GetFeedbackResponseModel,
    String> {
  FeedbackRepository repository;
  GetFeedbackUsecase(this.repository);
  @override
  Future<Either<Failure, GetFeedbackResponseModel>> call(
      String params) async {
    return await repository.getFeedback(params);
  }
}

