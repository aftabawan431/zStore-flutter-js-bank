import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/models/on_error_message_model.dart';
import '../../../../core/router/app_state.dart';
import '../../../../core/router/models/page_action.dart';
import '../../../../core/router/models/page_config.dart';
import '../../../../core/utils/enums/page_state_enum.dart';
import '../../../../core/utils/globals/show_app_bar.dart';

class DashboardViewModel extends ChangeNotifier {
  // Value Notifiers
  ValueChanged<OnErrorMessageModel>? onErrorMessage;
  ValueNotifier<int> pageIndex = ValueNotifier(0);
  ValueNotifier<String> dashboardAppbarTitle = ValueNotifier('Home');
  ValueNotifier<bool> fabClicked = ValueNotifier(false);

  // Properties
  PageController pageController = PageController();

  // Getters
  AppState appState = GetIt.I.get<AppState>();

  void moveToNotificationPage() {
    appState.currentAction = PageAction(
        state: PageState.addPage, page: PageConfigs.notificationPage);
  }

  // Error Handling
  void handleError(Either<Failure, dynamic> either) {
    either.fold((l) => ShowSnackBar.show(l.message), (r) => null);
  }
}
