import 'package:dartz/dartz.dart';
import 'package:zstore_flutter/features/my_favrouits/data/models/add_to_favourite_response_model.dart';
import 'package:zstore_flutter/features/my_favrouits/data/models/add_to_favourites_request_model.dart';
import 'package:zstore_flutter/features/home/data/models/get_sub_categories_by_category_response_model.dart';
import '../../../../../core/error/failures.dart';
import '../../../../core/models/no_params.dart';
import '../../../home/data/models/get_product_by_id_response_model.dart';
import '../../data/models/get_total_points_response_model.dart';

abstract class MyPointsRepository {
 /// [Input]: [NoParams] contains no params
  /// [Output] : if operation successful returns [GetTotalPointsResponseModel] returns the total points which user has got
  /// if unsuccessful the response will be [Failure]
  Future<Either<Failure, GetTotalPointsResponseModel>> getTotalPoints(String params);


}
