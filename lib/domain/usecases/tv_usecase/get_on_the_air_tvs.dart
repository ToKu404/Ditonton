import '../../../common/failure.dart';
import 'package:dartz/dartz.dart';
import '../../../common/usecase.dart';
import '../../repositories/tv_repository.dart';

import '../../entities/tv.dart';

class GetOnTheAirTvs implements Usecase<List<Tv>, NoParams> {
  TvRepository repository;

  GetOnTheAirTvs(this.repository);

  @override
  Future<Either<Failure, List<Tv>>> call(NoParams params) {
    return repository.getOnTheAirTvs();
  }
}
