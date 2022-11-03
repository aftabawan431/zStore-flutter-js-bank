import 'package:dartz/dartz.dart';
import 'package:zstore_flutter/core/models/no_params.dart';
import 'package:zstore_flutter/features/home/data/models/get_categories_products_response_model.dart';
import 'package:zstore_flutter/features/home/data/models/get_product_by_id_response_model.dart';
import 'package:zstore_flutter/features/home/data/models/get_products_by_sub_category_response_model.dart';
import 'package:zstore_flutter/features/home/data/models/get_sub_categories_by_category_response_model.dart';
import 'package:zstore_flutter/features/reviews/data/models/get_all_reviews_response_model.dart';

import '../../../../../core/error/failures.dart';
import '../../../../../core/utils/network/network_info.dart';
import '../../../../core/constants/app_messages.dart';
import '../../data/data_sources/home_data_source.dart';
import '../../data/models/checkout_request_model.dart';
import '../../data/models/checkout_response_model.dart';
import 'home_repo.dart';

class HomeRepoImp implements HomeRepository {
  final NetworkInfo networkInfo;

  final HomeDataSource dataSource;

  HomeRepoImp({
    required this.networkInfo,
    required this.dataSource,
  });



  @override
  Future<Either<Failure, CheckoutResponseModel>> checkout(CheckoutRequestModel params) async {
    if (!await networkInfo.isConnected) {
      return Left(const NetworkFailure(AppMessages.noInternet));
    }
    try {
      return Right(await dataSource.checkout(params));
    } on Failure catch (e) {
    return Left(e);
    } catch (e) {
    return Left(ServerFailure(e));
    }
  }

  @override
  Future<Either<Failure, GetCategoriesAndProductsResponseModel>> getCategoriesAndProducts(NoParams params) async{
    if (!await networkInfo.isConnected) {
      return Left(const NetworkFailure(AppMessages.noInternet));
    }
    try {
      return Right(await dataSource.getCategoriesAndProducts(params));
    } on Failure catch (e) {
    return Left(e);
    } catch (e) {
    return Left(ServerFailure(e));
    }
  }

  @override
  Future<Either<Failure, GetProductByIdResponseModel>> getProductById(String params)async {
    if (!await networkInfo.isConnected) {
      return Left(const NetworkFailure(AppMessages.noInternet));
    }
    try {
      return Right(await dataSource.getProductById(params));
    } on Failure catch (e) {
    return Left(e);
    } catch (e) {
    return Left(ServerFailure(e));
    }
  }



  @override
  Future<Either<Failure, GetProductsBySubCategoriesResponseModel>> getProductBySubCategory(String params) async{
    if (!await networkInfo.isConnected) {
      return Left(const NetworkFailure(AppMessages.noInternet));
    }
    try {
      return Right(await dataSource.getProductBySubCategory(params));
    } on Failure catch (e) {
    return Left(e);
    } catch (e) {
    return Left(ServerFailure(e));
    }
  }

  @override
  Future<Either<Failure, GetSubCategoriesByCategoryIdResponseModel>> getSubCategoriesByCategoryId(String params) async {
    if (!await networkInfo.isConnected) {
      return Left(const NetworkFailure(AppMessages.noInternet));
    }
    try {
      return Right(await dataSource.getSubCategoriesByCategoryId(params));
    } on Failure catch (e) {
    return Left(e);
    } catch (e) {
    return Left(ServerFailure(e));
    }

  }






}
