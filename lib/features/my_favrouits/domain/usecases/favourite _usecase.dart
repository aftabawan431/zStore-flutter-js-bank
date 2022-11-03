
//Add to Favourite UseCase
import 'package:dartz/dartz.dart';
import 'package:zstore_flutter/core/error/failures.dart';
import 'package:zstore_flutter/features/my_favrouits/data/models/add_to_favourite_response_model.dart';
import 'package:zstore_flutter/features/my_favrouits/data/models/add_to_favourites_request_model.dart';
import 'package:zstore_flutter/features/my_favrouits/data/models/delete_favourite_request_model.dart';
import 'package:zstore_flutter/features/my_favrouits/data/models/get_favourites_response_model.dart';
import 'package:zstore_flutter/features/my_favrouits/domain/repository/favourit_repo.dart';

import '../../../../core/usecases/usecase.dart';
import '../../data/models/delete_favourite_reponse_model.dart';

class AddToFavouriteUsecase
    extends UseCase< AddToFavouriteResponseModel,AddToFavouriteRequestModel> {
  FavouriteRepo repository;
  AddToFavouriteUsecase(this.repository);

  @override
  Future<Either<Failure, AddToFavouriteResponseModel>> call(AddToFavouriteRequestModel params) async {
    return await repository.addToFavourite(params);
  }

}
class GetFavouritesUSeCase
    extends UseCase<GetFavoritesResponseModel,String> {
  FavouriteRepo repository;
  GetFavouritesUSeCase(this.repository);

  @override
  Future<Either<Failure,  GetFavoritesResponseModel>> call(String params) async {
    return await repository.getFavourites(params);
  }

}



class DeleteFavouriteUSseCaase
    extends UseCase<DeleteFavouriteResponseModel,DeleteFavouriteRequestModel> {
  FavouriteRepo repository;
  DeleteFavouriteUSseCaase(this.repository);

  @override
  Future<Either<Failure,  DeleteFavouriteResponseModel>> call(DeleteFavouriteRequestModel params) async {
    return await repository.delFavourites(params);
  }

}













