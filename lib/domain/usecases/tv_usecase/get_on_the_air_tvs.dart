import '../../../common/failure.dart';
import 'package:dartz/dartz.dart';
import '../../repositories/tv_repository.dart';

import '../../entities/tv.dart';

class GetOnTheAirTvs {
  TvRepository repository;

  GetOnTheAirTvs(this.repository);

  Future<Either<Failure, List<Tv>>> execute() {
    return repository.getOnTheAirTvs();
  }
}
