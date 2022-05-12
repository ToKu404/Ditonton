import 'package:core/common/failure.dart';
import 'package:dartz/dartz.dart';

import '../entities/tv_season.dart';
import '../repositories/tv_repository.dart';

class GetTvSeason {
  TvRepository tvRepository;

  GetTvSeason(this.tvRepository);

  Future<Either<Failure, TvSeason>> execute(int tvId, int seasonNumber) {
    return tvRepository.getTvSeason(tvId, seasonNumber);
  }
}
