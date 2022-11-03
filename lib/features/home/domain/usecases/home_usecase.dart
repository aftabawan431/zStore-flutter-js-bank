
import 'package:dartz/dartz.dart';

import 'package:zstore_flutter/core/error/failures.dart';
import 'package:zstore_flutter/features/my_favrouits/data/models/add_to_favourite_response_model.dart';
import 'package:zstore_flutter/features/my_favrouits/data/models/add_to_favourites_request_model.dart';
import 'package:zstore_flutter/features/home/data/models/get_sub_categories_by_category_response_model.dart';

import '../../../../core/models/no_params.dart';
import '../../../../core/usecases/usecase.dart';
import '../../data/models/checkout_request_model.dart';
import '../../data/models/checkout_response_model.dart';
import '../../data/models/get_categories_products_response_model.dart';
import '../../data/models/get_product_by_id_response_model.dart';
import '../../data/models/get_products_by_sub_category_response_model.dart';
import '../repository/home_repo.dart';

class CheckoutUsecase
    extends UseCase< CheckoutResponseModel,CheckoutRequestModel> {
  HomeRepository repository;
  CheckoutUsecase(this.repository);

  @override
  Future<Either<Failure, CheckoutResponseModel>> call(CheckoutRequestModel params) async{
    return await repository.checkout(params);
  }


}

class GetCategoriesAndProductUsecase
    extends UseCase< GetCategoriesAndProductsResponseModel,NoParams> {
  HomeRepository repository;
  GetCategoriesAndProductUsecase(this.repository);

  @override
  Future<Either<Failure, GetCategoriesAndProductsResponseModel>> call(NoParams params) async {
    return await repository.getCategoriesAndProducts(params);
  }

}

class GetProductByIdUsecase
    extends UseCase< GetProductByIdResponseModel,String> {
  HomeRepository repository;
  GetProductByIdUsecase(this.repository);

  @override
  Future<Either<Failure,  GetProductByIdResponseModel>> call(String params) async {
    return await repository.getProductById(params);
  }

}
class GetProductsBySubCategoryUsecase
    extends UseCase< GetProductsBySubCategoriesResponseModel,String> {
  HomeRepository repository;
  GetProductsBySubCategoryUsecase(this.repository);

  @override
  Future<Either<Failure, GetProductsBySubCategoriesResponseModel>> call(String params) async {
    return await repository.getProductBySubCategory(params);
  }

}

//Sub-Categories by  Category
class GetSubCategoriesByCategoryUsecase
    extends UseCase< GetSubCategoriesByCategoryIdResponseModel,String> {
  HomeRepository repository;
  GetSubCategoriesByCategoryUsecase(this.repository);

  @override
  Future<Either<Failure, GetSubCategoriesByCategoryIdResponseModel>> call(String params) async {
    return await repository.getSubCategoriesByCategoryId(params);
  }

}

