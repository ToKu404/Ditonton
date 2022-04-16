import 'package:ditonton/common/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/usecase.dart';
import 'package:ditonton/domain/repositories/tv_repository.dart';
import 'package:equatable/equatable.dart';

import '../../entities/tv.dart';

class GetTvRecommendations implements Usecase<List<Tv>, Params> {
  TvRepository tvRepository;

  GetTvRecommendations(this.tvRepository);

  @override
  Future<Either<Failure, List<Tv>>> call(Params params) {
    return tvRepository.getTvRecomendations(params.id);
  }
}

class Params extends Equatable {
  final int id;
  Params({required this.id});

  @override
  List<Object?> get props => [];
}
