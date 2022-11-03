import 'package:dartz/dartz.dart';
import 'package:zstore_flutter/features/my_favrouits/data/models/delete_favourite_reponse_model.dart';
import 'package:zstore_flutter/features/my_favrouits/data/models/delete_favourite_request_model.dart';
import 'package:zstore_flutter/features/my_favrouits/data/models/get_favourites_response_model.dart';

import '../../../../core/error/failures.dart';
import '../../data/models/add_to_favourite_response_model.dart';
import '../../data/models/add_to_favourites_request_model.dart';

abstract class FavouriteRepo{
  Future<Either<Failure, AddToFavouriteResponseModel>> addToFavourite(AddToFavouriteRequestModel params) ;
  Future<Either<Failure, GetFavoritesResponseModel>> getFavourites(String params) ;
  Future<Either<Failure, DeleteFavouriteResponseModel>> delFavourites(DeleteFavouriteRequestModel params) ;

}