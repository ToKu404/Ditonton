import 'package:ditonton/domain/repositories/tv_repository.dart';

class GetWatchlistTvStatus {
  TvRepository repository;

  GetWatchlistTvStatus(this.repository);

  Future<bool> call(int id) async {
    return repository.isTvAddedToWatchlist(id);
  }
}
