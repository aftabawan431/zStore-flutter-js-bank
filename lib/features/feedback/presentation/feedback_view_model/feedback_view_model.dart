import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:zstore_flutter/core/error/failures.dart';
import 'package:zstore_flutter/core/models/on_error_message_model.dart';
import 'package:zstore_flutter/core/utils/globals/globals.dart';
import 'package:zstore_flutter/features/authentication/presentation/auth_view_model/authentication_view_model.dart';
import 'package:zstore_flutter/features/feedback/data/models/feedback_request_model.dart';
import 'package:zstore_flutter/features/feedback/data/models/feedback_response_model.dart';
import 'package:zstore_flutter/features/feedback/data/models/get_feedback_response_model.dart';
import 'package:zstore_flutter/features/feedback/domain/usecases/feedback_usecase.dart';

import '../../../../core/utils/globals/show_app_bar.dart';

class FeedbackViewModel extends ChangeNotifier {
  FeedbackViewModel(this.feedbackUsecase, this.getFeedbackUsecase);
  AuthViewModel authViewModel = sl();
  ValueChanged<OnErrorMessageModel>? onErrorMessage;
  TextEditingController commentsController = TextEditingController();

  TextEditingController ratingController = TextEditingController();
  final FeedbackUsecase feedbackUsecase;
  FeedbackRequestModel? feedbackRequestModel;
  ValueNotifier<bool> isGetFeedback = ValueNotifier(false);
  FeedbackResponseModel? feedbackResponseModel;
  GetFeedbackResponseModel? getFeedbackResponseModel;

  final GetFeedbackUsecase getFeedbackUsecase;

  Future<void> postFeedback() async {
    var params = FeedbackRequestModel(
        customerId: authViewModel.userDetails!.data.userId.toString(),
        channel: 1,
        rating: int.parse(ratingController.text),
        comments: commentsController.text);

    print(authViewModel.userDetails!.data.userId.toString());
    var getProductByIdEither = await feedbackUsecase.call(params);
    if (getProductByIdEither.isLeft()) {
      handleError(getProductByIdEither);
    } else if (getProductByIdEither.isRight()) {
      getProductByIdEither.foldRight(null, (response, _) async {
        feedbackResponseModel = response;

        getFeedbackResponseModel = null;
        getFeedback();
        notifyListeners();
      });
    }
  }

  Future<void> getFeedback() async {
    isGetFeedback.value = true;
    var params = authViewModel.userDetails!.data.userId.toString();

    var getProductByIdEither = await getFeedbackUsecase.call(params);
    if (getProductByIdEither.isLeft()) {
      handleError(getProductByIdEither);
      isGetFeedback.value = false;
    } else if (getProductByIdEither.isRight()) {
      getProductByIdEither.foldRight(null, (response, _) async {
        getFeedbackResponseModel = response;
        isGetFeedback.value = false;
        notifyListeners();
      });
    }
  }

  void handleError(Either<Failure, dynamic> either) {
    either.fold((l) => ShowSnackBar.show(l.message), (r) => null);
  }
}
