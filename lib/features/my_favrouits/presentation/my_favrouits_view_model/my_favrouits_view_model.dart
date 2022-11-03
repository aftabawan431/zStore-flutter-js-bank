import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:zstore_flutter/core/error/failures.dart';
import 'package:zstore_flutter/core/utils/globals/globals.dart';
import 'package:zstore_flutter/features/authentication/presentation/auth_view_model/authentication_view_model.dart';
import 'package:zstore_flutter/features/home/data/models/get_product_by_id_response_model.dart';
import 'package:zstore_flutter/features/home/presentation/home_view_model/home_view_model.dart';
import 'package:zstore_flutter/features/my_favrouits/data/models/add_to_favourite_response_model.dart';
import 'package:zstore_flutter/features/my_favrouits/data/models/add_to_favourites_request_model.dart';
import 'package:zstore_flutter/features/my_favrouits/data/models/delete_favourite_request_model.dart';
import 'package:zstore_flutter/features/my_favrouits/data/models/get_favourites_response_model.dart';
import 'package:zstore_flutter/features/my_favrouits/domain/usecases/favourite%20_usecase.dart';
import '../../../../core/models/on_error_message_model.dart';
import '../../../../core/router/app_state.dart';
import '../../../../core/router/models/page_action.dart';
import '../../../../core/router/models/page_config.dart';
import '../../../../core/utils/enums/page_state_enum.dart';
import '../../data/models/delete_favourite_reponse_model.dart';
class FavouriteViewModel extends ChangeNotifier {
  FavouriteViewModel(this.addToFavouriteUsecase, this.getFavouritesUSeCase,
      this.deleteFavouriteUsecase);
  final DeleteFavouriteUSseCaase deleteFavouriteUsecase;
  AddToFavouriteRequestModel? addToFavouriteRequestModel;
  AddToFavouriteResponseModel? addToFavouriteResponseModel;
  final GetFavouritesUSeCase getFavouritesUSeCase;
  GetProductByIdResponseModel? getProductByIdResponseModel;
  ValueChanged<OnErrorMessageModel>? onErrorMessage;
  final AddToFavouriteUsecase addToFavouriteUsecase;
  DeleteFavouriteResponseModel? deleteFavouriteResponseModel;
  DeleteFavouriteRequestModel? deleteFavouriteRequestModel;
  ValueNotifier<bool> isGetFavourites = ValueNotifier(false);
  GetFavoritesResponseModel? getFavoritesResponseModel;
  bool isFavouriote = false;
  AuthViewModel authViewModel = sl();
  HomeViewModel homeViewModel = sl();
  changeValue() {
    isFavouriote = !isFavouriote;
    notifyListeners();
  }
  Future<void> addToFavourite({required String productId}) async {
    var params = AddToFavouriteRequestModel(
        customerId: authViewModel.userDetails!.data.userId.toString(),
        productId: productId);
    var getProductByIdEither = await addToFavouriteUsecase.call(params);
    if (getProductByIdEither.isLeft()) {
      handleError(getProductByIdEither);
    } else if (getProductByIdEither.isRight()) {
      getProductByIdEither.foldRight(null, (response, _) async {
        addToFavouriteResponseModel = response;
        getFavourites();
        notifyListeners();
      });
    }
  }
  Future<void> getFavourites() async {
    var params = authViewModel.userDetails!.data.userId.toString();
    isGetFavourites.value = true;
    var getProductByIdEither = await getFavouritesUSeCase.call(params);
    if (getProductByIdEither.isLeft()) {
      handleError(getProductByIdEither);
      isGetFavourites.value = false;
      // isGotProductsBySubCategoryNotifier.value = false;
    } else if (getProductByIdEither.isRight()) {
      getProductByIdEither.foldRight(null, (response, _) async {
        getFavoritesResponseModel = response;
        isGetFavourites.value = false;
        //homeViewModel.getProductById(productId: productId);
        //       changeValue();
        notifyListeners();
      });
    }
  }
  Future<void> delFavourites({required String favouriteId}) async {
    var params = DeleteFavouriteRequestModel(favouriteId: favouriteId);
    var getProductByIdEither = await deleteFavouriteUsecase.call(params);
    if (getProductByIdEither.isLeft()) {
      handleError(getProductByIdEither);
      // isGotProductsBySubCategoryNotifier.value = false;
    } else if (getProductByIdEither.isRight()) {
      getProductByIdEither.foldRight(null, (response, _) async {
        deleteFavouriteResponseModel = response;
        getFavourites();
        //homeViewModel.getProductById(productId: productId);
        //       changeValue();
        notifyListeners();
      });
    }
  }
  void handleError(Either<Failure, dynamic> either) {
    //isGotDetailsNotifier.value = false;
    either.fold(
            (l) => onErrorMessage?.call(OnErrorMessageModel(message: l.message)),
            (r) => null);
  }
  void moveToMapScreen() {
    AppState appState = GetIt.I.get<AppState>();
    appState.currentAction =
        PageAction(state: PageState.addPage, page: PageConfigs.mapScreenPage);
  }
}