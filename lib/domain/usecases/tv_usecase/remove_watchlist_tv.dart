import '../../../common/failure.dart';
import 'package:dartz/dartz.dart';
import '../../entities/tv_detail.dart';
import '../../repositories/tv_repository.dart';


class RemoveWatchlistTv {
  TvRepository repository;

  RemoveWatchlistTv(this.repository);


  Future<Either<Failure, String>> execute(TvDetail tvDetail) {
    return repository.removeWatchlistTv(tvDetail);
  }
}
