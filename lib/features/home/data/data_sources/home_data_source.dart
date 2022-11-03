import 'dart:async';
import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:zstore_flutter/features/home/data/models/get_sub_categories_by_category_response_model.dart';
import '../../../../core/constants/app_messages.dart';
import '../../../../core/constants/app_url.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/models/error_response_model.dart';
import '../../../../core/models/no_params.dart';
import '../../../../core/utils/globals/show_app_bar.dart';
import '../models/checkout_request_model.dart';
import '../models/checkout_response_model.dart';
import '../models/get_categories_products_response_model.dart';
import '../models/get_product_by_id_response_model.dart';
import '../models/get_products_by_sub_category_response_model.dart';

abstract class HomeDataSource {
  /// This method gets the order
  /// [Input]: [CheckoutRequestModel] contains product details,userId etc
  /// [Output] : if operation successful returns [CheckoutResponseModel] returns the successful checkout of order
  /// if unsuccessful the response will be [Failure]
  Future<CheckoutResponseModel> checkout(CheckoutRequestModel params);

  /// This method gets the dashboard details
  /// [Input]: [NoParams] contains no parameters
  /// [Output] : if operation successful returns [GetCategoriesAndProductsResponseModel] returns the successful dashboard detials like products,sub-categories and categories
  /// if unsuccessful the response will be [Failure]
  Future<GetCategoriesAndProductsResponseModel> getCategoriesAndProducts(
      NoParams params);

  /// This method gets the products
  /// [Input]: [NoParams] contains no parameters
  /// [Output] : if operation successful returns [GetProductByIdResponseModel] returns the array of products
  /// if unsuccessful the response will be [Failure]
  Future<GetProductByIdResponseModel> getProductById(String params);

  /// This method gets the products according to specific sub-categories
  /// [Input]: [NoParams] contains no parameters
  /// [Output] : if operation successful returns [GetProductByIdResponseModel] returns the array of products
  /// if unsuccessful the response will be [Failure]
  Future<GetProductsBySubCategoriesResponseModel> getProductBySubCategory(
      String params);

  /// This method gets the sub-categories by categories id
  /// [Input]: [NoParams] contains no parameters
  /// [Output] : if operation successful returns [GetSubCategoriesByCategoryIdResponseModel] returns the sub-categories according to specific Categories id
  /// if unsuccessful the response will be [Failure]
  Future<GetSubCategoriesByCategoryIdResponseModel>
      getSubCategoriesByCategoryId(String params);
}

class HomeDataImp implements HomeDataSource {
  Dio dio;

  HomeDataImp({required this.dio});

  @override
  Future<CheckoutResponseModel> checkout(CheckoutRequestModel params) async {
    String url = AppUrl.saleManagementBaseUrl + AppUrl.addOrderUrl;

    try {
      final response = await dio.post(url, data: params.toJson());
      // final response = await dio.post(url,);

      print(response.statusMessage);
      if (response.statusCode == 200) {
        var object = CheckoutResponseModel.fromJson(response.data);
        print('this is the response buddy ${object.data.trackingId} ');

        ShowSnackBar.show(object.msg);
        return object;
      }

      throw const SomethingWentWrong(AppMessages.somethingWentWrong);
    } on DioError catch (exception) {
      print(exception.response!.data['msg']);
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
  Future<GetCategoriesAndProductsResponseModel> getCategoriesAndProducts(
      NoParams params) async {
    String url = AppUrl.saleManagementBaseUrl + AppUrl.homeDashboardUrl;
    print('helllo dear aftab $url');
    try {
      final response = await dio.get(
        url,
      );

      print(response.statusCode);
      if (response.statusCode == 200) {
        var object =
            GetCategoriesAndProductsResponseModel.fromJson(response.data);
        // ShowSnackBar.show(object.msg);
        return object;
      }

      throw const SomethingWentWrong(AppMessages.somethingWentWrong);
    } on DioError catch (exception) {
      print(exception.response!.data['msg']);
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
  Future<GetProductByIdResponseModel> getProductById(String params) async {
    String url =
        AppUrl.saleManagementBaseUrl + AppUrl.getProductByIdUrl + params;
    print(url);
    try {
      final response = await dio.get(
        url,
      );
      if (response.statusCode == 200) {
        print('my life is a joke');
        var object = GetProductByIdResponseModel.fromJson(response.data);
        print('helllo dear aftab ${object.toJson()}');

        ShowSnackBar.show(object.msg);
        return object;
      }

      throw const SomethingWentWrong(AppMessages.somethingWentWrong);
    } on DioError catch (exception) {
      print(exception.response!.data['msg']);
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
  Future<GetProductsBySubCategoriesResponseModel> getProductBySubCategory(
      String params) async {
    String url = AppUrl.saleManagementBaseUrl +
        AppUrl.getProductsBySubCategoryUrl +
        params;
    print('helllo dear aftab $url');
    try {
      final response = await dio.get(
        url,
      );

      print(response.statusCode);
      if (response.statusCode == 200) {
        var object =
            GetProductsBySubCategoriesResponseModel.fromJson(response.data);
        print("calling f");
        ShowSnackBar.show(object.msg);
        return object;
      }

      throw const SomethingWentWrong(AppMessages.somethingWentWrong);
    } on DioError catch (exception) {
      print(exception.response!.data['msg']);
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

  //subcategories by catid

  @override
  Future<GetSubCategoriesByCategoryIdResponseModel>
      getSubCategoriesByCategoryId(String params) async {
    String url = AppUrl.saleManagementBaseUrl +
        AppUrl.getSubCategoriesByCategoryIdUrl +
        params;
    print('helllo dear aftab $url');
    try {
      final response = await dio.get(
        url,
      );

      print(response.statusCode);
      if (response.statusCode == 200) {
        var object =
            GetSubCategoriesByCategoryIdResponseModel.fromJson(response.data);
        ShowSnackBar.show(object.msg);
        return object;
      }

      throw const SomethingWentWrong(AppMessages.somethingWentWrong);
    } on DioError catch (exception) {
      print(exception.response!.data['msg']);
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
