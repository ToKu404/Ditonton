import '../../../common/failure.dart';
import 'package:dartz/dartz.dart';
import '../../entities/tv_detail.dart';
import '../../repositories/tv_repository.dart';

class SaveWatchlistTv {
  TvRepository repository;

  SaveWatchlistTv(this.repository);

  Future<Either<Failure, String>> execute(TvDetail tvDetail) {
    return repository.saveWatchlistTv(tvDetail);
  }
}
