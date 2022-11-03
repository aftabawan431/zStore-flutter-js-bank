import 'package:dartz/dartz.dart';
import '../../../../../core/error/failures.dart';
import '../../data/models/feedback_request_model.dart';
import '../../data/models/feedback_response_model.dart';
import '../../data/models/get_feedback_response_model.dart';

abstract class FeedbackRepository {
  /// This method add the feedback
  /// [Input]: [FeedbackRequestModel] contains comment,rating and channel
  /// [Output] : if operation successful returns [FeedbackResponseModel] returns the successful addedFeedback
  /// if unsuccessful the response will be [Failure]
  Future<Either<Failure, FeedbackResponseModel>> addFeedback(FeedbackRequestModel params);
  /// This method gets the feedback
  /// [Input]: [NoParams] contains no parameters
  /// [Output] : if operation successful returns [GetFeedbackResponseModel] returns the successful submission of your feedback
  /// if unsuccessful the response will be [Failure]
  Future<Either<Failure, GetFeedbackResponseModel>> getFeedback(String params);
}
