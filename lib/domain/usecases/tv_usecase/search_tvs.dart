import 'package:ditonton/common/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/usecase.dart';
import 'package:ditonton/domain/repositories/tv_repository.dart';
import 'package:equatable/equatable.dart';

import '../../entities/tv.dart';

class SearchTvs implements Usecase<List<Tv>, Params> {
  TvRepository repository;

  SearchTvs(this.repository);

  @override
  Future<Either<Failure, List<Tv>>> call(Params params) {
    return repository.searchTv(params.query);
  }
}

class Params extends Equatable {
  final String query;

  Params({required this.query});

  @override
  List<Object?> get props => [query];
}
