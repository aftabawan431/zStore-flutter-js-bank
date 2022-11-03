import 'package:dartz/dartz.dart';
import 'package:zstore_flutter/features/my_favrouits/data/models/add_to_favourite_response_model.dart';
import 'package:zstore_flutter/features/my_favrouits/data/models/add_to_favourites_request_model.dart';
import 'package:zstore_flutter/features/home/data/models/get_sub_categories_by_category_response_model.dart';
import '../../../../../core/error/failures.dart';
import '../../../../core/models/no_params.dart';
import '../../data/models/checkout_request_model.dart';
import '../../data/models/checkout_response_model.dart';
import '../../data/models/get_categories_products_response_model.dart';
import '../../data/models/get_product_by_id_response_model.dart';
import '../../data/models/get_products_by_sub_category_response_model.dart';

abstract class HomeRepository {
  /// This method gets the order
  /// [Input]: [CheckoutRequestModel] contains product details,userId etc
  /// [Output] : if operation successful returns [CheckoutResponseModel] returns the successful checkout of order
  /// if unsuccessful the response will be [Failure]
  Future<Either<Failure, CheckoutResponseModel>> checkout(CheckoutRequestModel params);

  /// This method gets the dashboard details
  /// [Input]: [NoParams] contains no parameters
  /// [Output] : if operation successful returns [GetCategoriesAndProductsResponseModel] returns the successful dashboard detials like products,sub-categories and categories
  /// if unsuccessful the response will be [Failure]
  Future<Either<Failure, GetCategoriesAndProductsResponseModel>> getCategoriesAndProducts(NoParams params);  /// This method gets the countries list

  /// This method gets the products
  /// [Input]: [NoParams] contains no parameters
  /// [Output] : if operation successful returns [GetProductByIdResponseModel] returns the array of products
  /// if unsuccessful the response will be [Failure]
  Future<Either<Failure, GetProductByIdResponseModel>> getProductById(String params);

  /// This method gets the products according to specific sub-categories
  /// [Input]: [NoParams] contains no parameters
  /// [Output] : if operation successful returns [GetProductByIdResponseModel] returns the array of products
  /// if unsuccessful the response will be [Failure]
  Future<Either<Failure, GetProductsBySubCategoriesResponseModel>> getProductBySubCategory(String params)  ;

  /// This method gets the sub-categories by categories id
  /// [Input]: [NoParams] contains no parameters
  /// [Output] : if operation successful returns [GetSubCategoriesByCategoryIdResponseModel] returns the sub-categories according to specific Categories id
  /// if unsuccessful the response will be [Failure]
  Future<Either<Failure, GetSubCategoriesByCategoryIdResponseModel>> getSubCategoriesByCategoryId(String params)  ;

}
