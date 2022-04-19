import '../../../common/failure.dart';
import 'package:dartz/dartz.dart';
import '../../entities/tv.dart';
import '../../repositories/tv_repository.dart';

class GetWatchlistTvs{
  TvRepository repository;

  GetWatchlistTvs(this.repository);


  Future<Either<Failure, List<Tv>>> execute() {
    return repository.getWatchlistTvs();
  }
}
