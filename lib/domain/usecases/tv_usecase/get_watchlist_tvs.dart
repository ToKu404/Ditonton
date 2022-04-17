import 'package:ditonton/common/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/usecase.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/domain/repositories/tv_repository.dart';

class GetWatchlistTvs implements Usecase<List<Tv>, NoParams> {
  TvRepository repository;

  GetWatchlistTvs(this.repository);

  @override
  Future<Either<Failure, List<Tv>>> call(NoParams params) {
    return repository.getWatchlistTvs();
  }
}
