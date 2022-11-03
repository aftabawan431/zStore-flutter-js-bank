import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../error/failures.dart';

class DateTimeViewModel extends ChangeNotifier {
  ValueNotifier<DateTime> date = ValueNotifier(DateTime.now());
  ValueNotifier<DateTime?> time = ValueNotifier(null);
  ValueNotifier<DateTime?> dateTime = ValueNotifier(null);
  ValueNotifier<DateTime?> releaseDate = ValueNotifier(null);
  // ValueNotifier<DateTime?> requiredExpiryDate = ValueNotifier(null);
  ValueChanged<String>? errorMessage;
  ValueNotifier<bool> isLoading = ValueNotifier(false);

  void makeActionsBasedOnError(Failure l) {
    errorMessage?.call(l.message);
  }

  void handleError(Either<Failure, dynamic> either) {
    either.fold((l) {
      makeActionsBasedOnError(l);
    }, (r) => null);
  }
}
