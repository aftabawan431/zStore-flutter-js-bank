import 'package:dartz/dartz.dart';
import 'package:zstore_flutter/core/constants/app_messages.dart';
import 'package:zstore_flutter/core/error/failures.dart';
import 'package:zstore_flutter/core/utils/network/network_info.dart';
import 'package:zstore_flutter/features/my_favrouits/data/data_source/favourite_data_source.dart';
import 'package:zstore_flutter/features/my_favrouits/data/models/add_to_favourite_response_model.dart';
import 'package:zstore_flutter/features/my_favrouits/data/models/add_to_favourites_request_model.dart';
import 'package:zstore_flutter/features/my_favrouits/data/models/delete_favourite_reponse_model.dart';
import 'package:zstore_flutter/features/my_favrouits/data/models/delete_favourite_request_model.dart';
import 'package:zstore_flutter/features/my_favrouits/data/models/get_favourites_response_model.dart';
import 'package:zstore_flutter/features/my_favrouits/domain/repository/favourit_repo.dart';

class FavouriteRepoImp implements FavouriteRepo {
  final NetworkInfo networkInfo;

  final FavouriteDataSource dataSource;

  FavouriteRepoImp({
    required this.networkInfo,
    required this.dataSource,
  });

  @override
  Future<Either<Failure, AddToFavouriteResponseModel>> addToFavourite(AddToFavouriteRequestModel params) async {
    if (!await networkInfo.isConnected) {
      return Left( NetworkFailure(AppMessages.noInternet));
    }
    try {
      return Right(await dataSource.addToFavourite(params));
    } on Failure catch (e) {
    return Left(e);
    } catch (e) {
    return Left(ServerFailure(e));
    }
  }

  @override
  Future<Either<Failure, GetFavoritesResponseModel>> getFavourites(String params) async {

    if (!await networkInfo.isConnected) {
      return Left( NetworkFailure(AppMessages.noInternet));
    }
    try {
      return Right(await dataSource.getCustomerFavourites(params));
    } on Failure catch (e) {
    return Left(e);
    } catch (e) {
    return Left(ServerFailure(e));
    }
  }

  @override
  Future<Either<Failure, DeleteFavouriteResponseModel>> delFavourites(DeleteFavouriteRequestModel params) async {
    if (!await networkInfo.isConnected) {
      return Left( NetworkFailure(AppMessages.noInternet));
    }
    try {
      return Right(await dataSource.delFavourites(params));
    } on Failure catch (e) {
    return Left(e);
    } catch (e) {
    return Left(ServerFailure(e));
    }
  }
}
