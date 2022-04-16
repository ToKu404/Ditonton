import 'package:ditonton/common/usecase.dart';
import 'package:ditonton/domain/repositories/tv_repository.dart';

class GetWatchlistTvStatus {
  TvRepository repository;

  GetWatchlistTvStatus(this.repository);

  Future<bool> call(int id) {
    return repository.isTvAddedToWatchlist(id);
  }
}
