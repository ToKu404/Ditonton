import 'package:dartz/dartz.dart';
import '../../../common/failure.dart';
import '../../../common/usecase.dart';
import '../../entities/tv_detail.dart';
import '../../repositories/tv_repository.dart';
import 'package:equatable/equatable.dart';

class GetTvDetail implements Usecase<TvDetail, Params> {
  final TvRepository repository;

  GetTvDetail(this.repository);

  @override
  Future<Either<Failure, TvDetail>> call(Params params) {
    return repository.getTvDetail(params.id);
  }
}

class Params extends Equatable {
  final int id;

  Params({required this.id});
  @override
  List<Object?> get props => [id];
}
