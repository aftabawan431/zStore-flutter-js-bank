import 'dart:async';

import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:zstore_flutter/core/constants/app_url.dart';
import 'package:zstore_flutter/core/models/error_response_model.dart';
import 'package:zstore_flutter/features/my_favrouits/data/models/add_to_favourite_response_model.dart';
import 'package:zstore_flutter/features/my_favrouits/data/models/add_to_favourites_request_model.dart';
import 'package:zstore_flutter/features/my_favrouits/data/models/delete_favourite_reponse_model.dart';
import 'package:zstore_flutter/features/my_favrouits/data/models/delete_favourite_request_model.dart';
import 'package:zstore_flutter/features/my_favrouits/data/models/get_favourites_response_model.dart';

import '../../../../core/constants/app_messages.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/utils/globals/show_app_bar.dart';

abstract class FavouriteDataSource {
  Future<AddToFavouriteResponseModel> addToFavourite(
      AddToFavouriteRequestModel params);
  Future<GetFavoritesResponseModel> getCustomerFavourites(String params);
  Future<DeleteFavouriteResponseModel> delFavourites(
      DeleteFavouriteRequestModel params);
}

class FavouriteDataImp implements FavouriteDataSource {
  Dio dio;

  FavouriteDataImp({required this.dio});

  @override
  Future<AddToFavouriteResponseModel> addToFavourite(
      AddToFavouriteRequestModel params) async {
    String url = AppUrl.saleManagementBaseUrl + AppUrl.addToFavouriteUrl;
    try {
      final response = await dio.post(url, data: params.toJson());

      if (response.statusCode == 200) {
        var object = AddToFavouriteResponseModel.fromJson(response.data);
        return object;
      }

      throw SomethingWentWrong(AppMessages.somethingWentWrong);
    } on DioError catch (exception) {
      print(exception.response!.statusCode.toString());
      Logger().i('returning error');
      if (exception.type == DioErrorType.connectTimeout) {
        throw TimeoutException(AppMessages.timeOut);
      } else {
        ErrorResponseModel errorResponseModel =
            ErrorResponseModel(statusMessage: exception.response!.data['msg']);
        print(errorResponseModel.statusMessage.toString());
        ShowSnackBar.show(errorResponseModel.statusMessage.toString());
        throw SomethingWentWrong(errorResponseModel.statusMessage);
      }
    } catch (e) {
      throw SomethingWentWrong(e.toString());
    }
  }

  @override
  Future<GetFavoritesResponseModel> getCustomerFavourites(String params) async {
    String url = AppUrl.saleManagementBaseUrl + AppUrl.getFavouriteUrl + params;
    try {
      final response = await dio.get(url);

      if (response.statusCode == 200) {
        var object = GetFavoritesResponseModel.fromJson(response.data);
        return object;
      }

      throw SomethingWentWrong(AppMessages.somethingWentWrong);
    } on DioError catch (exception) {
      Logger().i('returning error');
      if (exception.type == DioErrorType.connectTimeout) {
        throw TimeoutException(AppMessages.timeOut);
      } else {
        ErrorResponseModel errorResponseModel =
            ErrorResponseModel(statusMessage: exception.response!.data['msg']);
        print(errorResponseModel.statusMessage.toString());
        ShowSnackBar.show(errorResponseModel.statusMessage.toString());
        throw SomethingWentWrong(errorResponseModel.statusMessage);
      }
    } catch (e) {
      throw SomethingWentWrong(e.toString());
    }
  }

  @override
  Future<DeleteFavouriteResponseModel> delFavourites(
      DeleteFavouriteRequestModel params) async {
    String url = AppUrl.saleManagementBaseUrl + AppUrl.deleteFavouriteUrl;
    try {
      final response = await dio.delete(url, data: params.toJson());

      if (response.statusCode == 200) {
        var object = DeleteFavouriteResponseModel.fromJson(response.data);
        return object;
      }

      throw SomethingWentWrong(AppMessages.somethingWentWrong);
    } on DioError catch (exception) {

      Logger().i('returning error');
      if (exception.type == DioErrorType.connectTimeout) {
        throw TimeoutException(AppMessages.timeOut);
      } else {
        ErrorResponseModel errorResponseModel =
            ErrorResponseModel(statusMessage: exception.response!.data['msg']);
        print(errorResponseModel.statusMessage.toString());
        ShowSnackBar.show(errorResponseModel.statusMessage.toString());
        throw SomethingWentWrong(errorResponseModel.statusMessage);
      }
    } catch (e) {
      throw SomethingWentWrong(e.toString());
    }
  }
}
