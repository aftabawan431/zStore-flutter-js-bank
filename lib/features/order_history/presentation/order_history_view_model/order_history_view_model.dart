import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:zstore_flutter/features/authentication/presentation/auth_view_model/authentication_view_model.dart';
import 'package:zstore_flutter/features/order_history/data/models/clear_order_history_response_model.dart';
import 'package:zstore_flutter/features/order_history/data/models/get_order_history_details_response_model.dart';
import 'package:zstore_flutter/features/order_history/domain/usecase/get_order_history_usecase.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/models/on_error_message_model.dart';
import '../../../../core/router/app_state.dart';
import '../../../../core/router/models/page_action.dart';
import '../../../../core/router/models/page_config.dart';
import '../../../../core/utils/enums/page_state_enum.dart';
import '../../../../core/utils/globals/globals.dart';
import '../../data/models/get_order_history_response_model.dart';

class OrderHistoryViewModel extends ChangeNotifier{
  OrderHistoryViewModel(this.getOrderHistoryUsecase, this.getOrderHistoryDetailsUsecase,this.clearOrderHistoryUsecase);
  GetOrderHistoryUsecase getOrderHistoryUsecase;
  GetOrderHistoryDetailsUsecase getOrderHistoryDetailsUsecase;
  GetOrderHistoryResponseModel? getOrderHistoryResponseModel;
  GetOrderHistoryDetailsResponseModel? getOrderHistoryDetailsResponseModel;
  ClearOrderHistoryUsecase clearOrderHistoryUsecase;
  ClearOrderHistoryResponseModel? clearOrderHistoryResponseModel;
  ValueNotifier<bool> isGotOrderHistoryNotifier = ValueNotifier(false);
  ValueNotifier<bool> isClearOrderHistoryNotifier = ValueNotifier(false);
  ValueNotifier<bool> isGotOrderHistoryDetailsNotifier = ValueNotifier(false);
  ValueChanged<OnErrorMessageModel>? onErrorMessage;
AuthViewModel authViewModel =sl();

  Future<void> getOrderHistory({bool reCall=false}) async {
    if(getOrderHistoryResponseModel!=null&&getOrderHistoryResponseModel!.data.isNotEmpty){
      if(reCall==false){
        return;
      }
    }
    print('it is calling getOrderHistoryResponseModel');
    print(authViewModel.userDetails!.data.userId);
    isGotOrderHistoryNotifier.value = true;

    var getOrderHistoryEither = await getOrderHistoryUsecase.call(authViewModel.userDetails!.data.userId);

    if (getOrderHistoryEither.isLeft()) {
      // getOrderHistoryResponseModel=null;
      handleGetOrderHistoryError(getOrderHistoryEither);
      isGotOrderHistoryNotifier.value = false;
    } else if (getOrderHistoryEither.isRight()) {
      getOrderHistoryEither.foldRight(null, (response, _) {
        getOrderHistoryResponseModel = response;
        notifyListeners();
        print(
            'this is the response of getOrderHistoryResponseModel $getOrderHistoryResponseModel');
      });
      isGotOrderHistoryNotifier.value = false;

      //
    }
  }
  Future<void> clearOrderHistory() async {
    print('it is calling clearOrderHistory');
    print(authViewModel.userDetails!.data.userId);
    isClearOrderHistoryNotifier.value = true;

    var clearOrderHistoryEither = await clearOrderHistoryUsecase.call(authViewModel.userDetails!.data.userId);
print('hee');
    if (clearOrderHistoryEither.isLeft()) {
      handleGetOrderHistoryError(clearOrderHistoryEither);
      isClearOrderHistoryNotifier.value = false;
    } else if (clearOrderHistoryEither.isRight()) {
      clearOrderHistoryEither.foldRight(null, (response, _)async {
        clearOrderHistoryResponseModel = response;
        getOrderHistoryResponseModel=null;
        print(
            'this is the response of clearOrderHistory $clearOrderHistoryResponseModel');

      });
      isClearOrderHistoryNotifier.value = false;

      await  getOrderHistory();
      notifyListeners();
      //
    }
  }
  Future<void> getOrderHistoryDetails({required String orderId}) async {
    print('it is calling getOrderHistoryDetailsResponseModel');
    isGotOrderHistoryDetailsNotifier.value = true;

    var getOrderHistoryDetailsEither = await getOrderHistoryDetailsUsecase.call(orderId);

    if (getOrderHistoryDetailsEither.isLeft()) {
      handleGetOrderHistoryDetailsError(getOrderHistoryDetailsEither);
      isGotOrderHistoryDetailsNotifier.value = false;
    } else if (getOrderHistoryDetailsEither.isRight()) {
      getOrderHistoryDetailsEither.foldRight(null, (response, _) {
        getOrderHistoryDetailsResponseModel = response;
        // additionalDescription.value == null;


        print(
            'this is the response of getOrderHistoryDetailsResponseModel $getOrderHistoryDetailsResponseModel');
      });
      isGotOrderHistoryDetailsNotifier.value = false;

      //
    }
  }

  void moveToOrderHistoryPage() {
    AppState appState = GetIt.I.get<AppState>();
    appState.currentAction = PageAction(state: PageState.addPage, page: PageConfigs.orderHistoryConfig);
  }
  void moveToOrderHistoryDetailPage() {
    AppState appState = GetIt.I.get<AppState>();
    appState.currentAction = PageAction(state: PageState.addPage, page: PageConfigs.orderHistoryDetailConfig);
  }
  void moveToOrderTrackingPage() {
    AppState appState = GetIt.I.get<AppState>();
    appState.currentAction = PageAction(state: PageState.addPage, page: PageConfigs.orderTrackingPageConfig);
  }
  void moveToMyPoints() {
    AppState appState = GetIt.I.get<AppState>();
    appState.currentAction = PageAction(state: PageState.addPage, page: PageConfigs.paymentDetailsConfig);
  }

  // Error Handling
  void handleGetOrderHistoryError(Either<Failure, dynamic> either) {
    isGotOrderHistoryNotifier.value = false;
    either.fold(
            (l) => onErrorMessage?.call(OnErrorMessageModel(message: l.message)),
            (r) => null);
  }
  void handleGetOrderHistoryDetailsError(Either<Failure, dynamic> either) {
    isGotOrderHistoryDetailsNotifier.value = false;
    either.fold(
            (l) => onErrorMessage?.call(OnErrorMessageModel(message: l.message)),
            (r) => null);
  }

}

