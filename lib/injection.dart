import 'package:ditonton/domain/usecases/tv_usecase/remove_watchlist_tv.dart';
import 'package:ditonton/domain/usecases/tv_usecase/save_watchlist_tv.dart';
import 'package:ditonton/presentation/provider/tv_provider/on_the_air_tvs_notifier.dart';
import 'package:ditonton/presentation/provider/tv_provider/popular_tvs_notifier.dart';
import 'package:ditonton/presentation/provider/tv_provider/top_rated_tvs_notifier.dart';
import 'package:ditonton/presentation/provider/tv_provider/tv_detail_notifier.dart';
import 'package:ditonton/presentation/provider/tv_provider/tv_list_notifier.dart';
import 'package:ditonton/presentation/provider/tv_provider/tv_search_notifier.dart';
import 'package:ditonton/presentation/provider/tv_provider/watchlist_tv_notifier.dart';

import 'data/datasources/db/database_helper.dart';
import 'data/datasources/movie_local_data_source.dart';
import 'data/datasources/movie_remote_data_source.dart';
import 'data/datasources/tv_local_data_source.dart';
import 'data/datasources/tv_remote_date_source.dart';
import 'data/repositories/movie_repository_impl.dart';
import 'data/repositories/tv_repository_impl.dart';
import 'domain/repositories/movie_repository.dart';
import 'domain/repositories/tv_repository.dart';
import 'domain/usecases/movie_usecase/get_movie_detail.dart';
import 'domain/usecases/movie_usecase/get_movie_recommendations.dart';
import 'domain/usecases/movie_usecase/get_now_playing_movies.dart';
import 'domain/usecases/movie_usecase/get_popular_movies.dart';
import 'domain/usecases/movie_usecase/get_top_rated_movies.dart';
import 'domain/usecases/movie_usecase/get_watchlist_movies.dart';
import 'domain/usecases/movie_usecase/get_watchlist_status.dart';
import 'domain/usecases/movie_usecase/remove_watchlist.dart';
import 'domain/usecases/movie_usecase/save_watchlist.dart';
import 'domain/usecases/movie_usecase/search_movies.dart';
import 'domain/usecases/tv_usecase/get_on_the_air_tvs.dart';
import 'domain/usecases/tv_usecase/get_popular_tvs.dart';
import 'domain/usecases/tv_usecase/get_top_rated_tvs.dart';
import 'domain/usecases/tv_usecase/get_tv_detail.dart';
import 'domain/usecases/tv_usecase/get_tv_recommendations.dart';
import 'domain/usecases/tv_usecase/get_watchlist_tv_status.dart';
import 'domain/usecases/tv_usecase/get_watchlist_tvs.dart';
import 'domain/usecases/tv_usecase/search_tvs.dart';
import 'presentation/provider/movie_provider/movie_detail_notifier.dart';
import 'presentation/provider/movie_provider/movie_list_notifier.dart';
import 'presentation/provider/movie_provider/movie_search_notifier.dart';
import 'presentation/provider/movie_provider/popular_movies_notifier.dart';
import 'presentation/provider/movie_provider/top_rated_movies_notifier.dart';
import 'presentation/provider/movie_provider/watchlist_movie_notifier.dart';
import 'package:http/http.dart' as http;
import 'package:get_it/get_it.dart';

final locator = GetIt.instance;

void init() {
  // provider
  locator.registerFactory(
    () => MovieListNotifier(
      getNowPlayingMovies: locator(),
      getPopularMovies: locator(),
      getTopRatedMovies: locator(),
    ),
  );
  locator.registerFactory(
    () => MovieDetailNotifier(
      getMovieDetail: locator(),
      getMovieRecommendations: locator(),
      getWatchListStatus: locator(),
      saveWatchlist: locator(),
      removeWatchlist: locator(),
    ),
  );
  locator.registerFactory(
    () => MovieSearchNotifier(
      searchMovies: locator(),
    ),
  );
  locator.registerFactory(
    () => PopularMoviesNotifier(
      locator(),
    ),
  );
  locator.registerFactory(
    () => TopRatedMoviesNotifier(
      getTopRatedMovies: locator(),
    ),
  );
  locator.registerFactory(
    () => WatchlistMovieNotifier(
      getWatchlistMovies: locator(),
    ),
  );

  locator.registerFactory(
    () => TvListNotifier(
        getOnTheAirTvs: locator(),
        getPopularTvs: locator(),
        getTopRatedTvs: locator()),
  );
  locator.registerFactory(
    () => TvDetailNotifier(
      getWatchListStatus: locator(),
      saveWatchlist: locator(),
      removeWatchlist: locator(),
      getTvRecommendations: locator(),
      getTvDetail: locator(),
    ),
  );
  locator.registerFactory(
    () => TvSearchNotifier(searchTvs: locator()),
  );
  locator.registerFactory(
    () => OnTheAirTvsNotifier(
      getOnTheAirTvs: locator(),
    ),
  );
  locator.registerFactory(
    () => PopularTvsNotifier(
      locator(),
    ),
  );
  locator.registerFactory(
    () => TopRatedTvsNotifier(
      locator(),
    ),
  );
  locator.registerFactory(
    () => WatchlistTvNotifier(
      getWatchlistTvs: locator(),
    ),
  );

  // use case
  locator.registerLazySingleton(() => GetNowPlayingMovies(locator()));
  locator.registerLazySingleton(() => GetPopularMovies(locator()));
  locator.registerLazySingleton(() => GetTopRatedMovies(locator()));
  locator.registerLazySingleton(() => GetMovieDetail(locator()));
  locator.registerLazySingleton(() => GetMovieRecommendations(locator()));
  locator.registerLazySingleton(() => SearchMovies(locator()));
  locator.registerLazySingleton(() => GetWatchListStatus(locator()));
  locator.registerLazySingleton(() => SaveWatchlist(locator()));
  locator.registerLazySingleton(() => RemoveWatchlist(locator()));
  locator.registerLazySingleton(() => GetWatchlistMovies(locator()));

   // use case tv show
  locator.registerLazySingleton(() => GetOnTheAirTvs(locator()));
  locator.registerLazySingleton(() => GetPopularTvs(locator()));
  locator.registerLazySingleton(() => GetTopRatedTvs(locator()));
  locator.registerLazySingleton(() => GetTvDetail(locator()));
  locator.registerLazySingleton(() => GetTvRecommendations(locator()));
  locator.registerLazySingleton(() => SearchTvs(locator()));
  locator.registerLazySingleton(() => GetWatchlistTvStatus(locator()));
  locator.registerLazySingleton(() => SaveWatchlistTv(locator()));
  locator.registerLazySingleton(() => RemoveWatchlistTv(locator()));
  locator.registerLazySingleton(() => GetWatchlistTvs(locator()));

  // repository
  locator.registerLazySingleton<MovieRepository>(
    () => MovieRepositoryImpl(
      remoteDataSource: locator(),
      localDataSource: locator(),
    ),
  );
   locator.registerLazySingleton<TvRepository>(
    () => TvRepositoryImpl(
      remoteDataSource: locator(),
      localDataSource: locator(),
    ),
  );

  // data sources
  locator.registerLazySingleton<MovieRemoteDataSource>(
      () => MovieRemoteDataSourceImpl(client: locator()));
  locator.registerLazySingleton<MovieLocalDataSource>(
      () => MovieLocalDataSourceImpl(databaseHelper: locator()));
   locator.registerLazySingleton<TvRemoteDataSource>(
      () => TvRemoteDataSourceImpl(client: locator()));
  locator.registerLazySingleton<TvLocalDataSource>(
      () => TvLocalDataSourceImpl(databaseHelper: locator()));

  // helper
  locator.registerLazySingleton<DatabaseHelper>(() => DatabaseHelper());

  // external
  locator.registerLazySingleton(() => http.Client());
}
