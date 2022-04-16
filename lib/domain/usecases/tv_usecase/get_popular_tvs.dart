import '../../../common/failure.dart';
import 'package:dartz/dartz.dart';
import '../../../common/usecase.dart';
import '../../entities/tv.dart';
import '../../repositories/tv_repository.dart';

class GetPopularTvs implements Usecase<List<Tv>, NoParams> {
  TvRepository repository;

  GetPopularTvs(this.repository);

  @override
  Future<Either<Failure, List<Tv>>> call(NoParams params) {
    return repository.getPopularTvs();
  }
}
