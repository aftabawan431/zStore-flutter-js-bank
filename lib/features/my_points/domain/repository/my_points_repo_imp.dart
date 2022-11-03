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
import '../../data/data_sources/my_points_data_source.dart';
import '../../data/models/get_total_points_response_model.dart';
import 'my_points_repo.dart';

class MyPointsRepoImp implements MyPointsRepository {
  final NetworkInfo networkInfo;

  final MyPointsDataSource dataSource;

  MyPointsRepoImp({
    required this.networkInfo,
    required this.dataSource,
  });

  Future<Either<Failure, GetTotalPointsResponseModel>> getTotalPoints(String params)async {
    if (!await networkInfo.isConnected) {
      return const Left(NetworkFailure(AppMessages.noInternet));
    }
    try {
      return Right(await dataSource.getTotalPoints(params));
    } on Failure catch (e) {
    return Left(e);
    } catch (e) {
    return Left(ServerFailure(e));
    }
  }


  }

