import '../../../common/failure.dart';
import 'package:dartz/dartz.dart';
import '../../../common/usecase.dart';
import '../../entities/tv.dart';
import '../../repositories/tv_repository.dart';

class GetTopRatedTvs implements Usecase<List<Tv>, NoParams> {
  TvRepository repository;

  GetTopRatedTvs(this.repository);

  @override
  Future<Either<Failure, List<Tv>>> call(NoParams params) {
    return repository.getTopRatedTvs();
  }
}
