import 'package:ditonton/common/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/usecase.dart';
import 'package:ditonton/domain/entities/tv_detail.dart';
import 'package:ditonton/domain/repositories/tv_repository.dart';
import 'package:equatable/equatable.dart';

class RemoveWatchlistTv implements Usecase<String, Params> {
  TvRepository repository;

  RemoveWatchlistTv(this.repository);

  @override
  Future<Either<Failure, String>> call(Params params) {
    return repository.removeWatchlistTv(params.tvDetail);
  }
}

class Params extends Equatable {
  final TvDetail tvDetail;

  Params({required this.tvDetail});

  @override
  List<Object?> get props => [tvDetail];
}
