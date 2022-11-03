import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:zstore_flutter/features/authentication/presentation/auth_view_model/authentication_view_model.dart';
import 'package:zstore_flutter/features/my_points/domain/usecases/my_points_usecase.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/utils/globals/globals.dart';
import '../../../../core/utils/globals/show_app_bar.dart';
import '../../data/models/get_total_points_response_model.dart';

class MyPointsViewModel extends ChangeNotifier {
  MyPointsViewModel(this.getTotalPointsUsecase);
  GetTotalPointsUsecase getTotalPointsUsecase;
  GetTotalPointsResponseModel? getTotalPointsResponseModel;
  ValueNotifier<bool> isGotTotalPointsNotifier = ValueNotifier(false);

  Future<void> getTotalPoints() async {
    print('it is calling getTotalPointsResponseModel');
    isGotTotalPointsNotifier.value = true;
AuthViewModel authViewModel =sl();
    var getTotalPointsEither = await getTotalPointsUsecase.call( authViewModel.userDetails!.data.userId.toString(),);

    if (getTotalPointsEither.isLeft()) {
      handleError(getTotalPointsEither);
      isGotTotalPointsNotifier.value = false;
    } else if (getTotalPointsEither.isRight()) {
      getTotalPointsEither.foldRight(null, (response, _) {
        getTotalPointsResponseModel = response;
        print('hi');
        notifyListeners();
        print(
            'this is the response of getProductByIdResponseModel $getTotalPointsResponseModel');
      });
      isGotTotalPointsNotifier.value = false;

      //
    }
  }

  void handleError(Either<Failure, dynamic> either) {
    either.fold((l) => ShowSnackBar.show(l.message), (r) => null);
  }
}
