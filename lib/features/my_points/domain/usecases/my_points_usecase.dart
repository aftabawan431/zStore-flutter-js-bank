
import 'package:dartz/dartz.dart';
import 'package:zstore_flutter/core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../../data/models/get_total_points_response_model.dart';
import '../repository/my_points_repo.dart';

class GetTotalPointsUsecase
    extends UseCase< GetTotalPointsResponseModel,String> {
  MyPointsRepository repository;
  GetTotalPointsUsecase(this.repository);

  @override
  Future<Either<Failure,GetTotalPointsResponseModel>> call(String params) async {
    return await repository.getTotalPoints(params);
  }


}

