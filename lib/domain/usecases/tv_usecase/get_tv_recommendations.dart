import '../../../common/failure.dart';
import 'package:dartz/dartz.dart';
import '../../repositories/tv_repository.dart';

import '../../entities/tv.dart';

class GetTvRecommendations  {
  TvRepository tvRepository;

  GetTvRecommendations(this.tvRepository);


  Future<Either<Failure, List<Tv>>> execute(int id) {
    return tvRepository.getTvRecommendations(id);
  }
}
