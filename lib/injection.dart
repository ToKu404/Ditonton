import 'package:ditonton/presentation/bloc/movie_detail_bloc/movie_detail_bloc.dart';
import 'package:ditonton/presentation/bloc/movie_search_bloc/movie_search_bloc.dart';
import 'package:ditonton/presentation/bloc/movie_watchlist_bloc/movie_watchlist_bloc.dart';
import 'package:ditonton/presentation/bloc/now_playing_movies_bloc/now_playing_movies_bloc.dart';
import 'package:ditonton/presentation/bloc/popular_movies_bloc/popular_movies_bloc.dart';
import 'package:ditonton/presentation/bloc/tv_detail_bloc/tv_detail_bloc.dart';
import 'package:ditonton/presentation/bloc/tv_season_bloc/tv_season_bloc.dart';
import 'package:ditonton/presentation/bloc/watchlist_movie_bloc/watchlist_movie_bloc.dart';

import 'domain/usecases/tv_usecase/get_tv_season.dart';
import 'domain/usecases/tv_usecase/remove_watchlist_tv.dart';
import 'domain/usecases/tv_usecase/save_watchlist_tv.dart';
import 'presentation/bloc/on_the_air_tvs_bloc/on_the_air_tvs_bloc.dart';
import 'presentation/bloc/popular_tvs_bloc/popular_tvs_bloc.dart';
import 'presentation/bloc/top_rated_movies_bloc/top_rated_movies_bloc.dart';
import 'presentation/bloc/top_rated_tvs_bloc/top_rated_tvs_bloc.dart';
import 'presentation/bloc/tv_search_bloc/tv_search_bloc.dart';
import 'presentation/bloc/tv_watchlist_bloc/tv_watchlist_bloc.dart';
import 'presentation/bloc/watchlist_tv_bloc/watchlist_tv_bloc.dart';

import 'data/datasources/db/database_helper.dart';
import 'data/datasources/movie_local_data_source.dart';
import 'data/datasources/movie_remote_data_source.dart';
import 'data/datasources/tv_local_data_source.dart';
import 'data/datasources/tv_remote_data_source.dart';
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
import 'package:http/http.dart' as http;
import 'package:get_it/get_it.dart';


final locator = GetIt.instance;

void init() {
  // bloc

  locator.registerFactory(
    () => MovieSearchBloc(
      locator(),
    ),
  );
  locator.registerFactory(
    () => TvSearchBloc(
      locator(),
    ),
  );

  locator.registerFactory(
    () => MovieDetailBloc(
      getMovieDetail: locator(),
      getMovieRecommendations: locator(),
    ),
  );

  locator.registerFactory(
    () => TvDetailBloc(
      getTvDetail: locator(),
      getTvRecommendations: locator(),
    ),
  );

  locator.registerFactory(() => MovieWatchlistBloc(
      getWatchlistStatus: locator(),
      removeWatchlist: locator(),
      saveWatchlist: locator()));

  locator.registerFactory(() => TvWatchlistBloc(
      getWatchlistStatus: locator(),
      removeWatchlist: locator(),
      saveWatchlist: locator()));

  locator.registerFactory(() => PopularMoviesBloc(popularMovies: locator()));

  locator.registerFactory(() => TopRatedMoviesBloc(topRatedMovies: locator()));

  locator.registerFactory(
      () => NowPlayingMoviesBloc(getNowPlayingMovies: locator()));

  locator.registerFactory(() => PopularTvsBloc(popularTvs: locator()));

  locator.registerFactory(() => TopRatedTvsBloc(topRatedTvs: locator()));

  locator.registerFactory(() => OnTheAirTvsBloc(getOnTheAirTvs: locator()));

  locator.registerFactory(() => WatchlistMovieBloc(watchlistMovies: locator()));

  locator.registerFactory(() => WatchlistTvBloc(watchlistTvs: locator()));

  locator.registerFactory(() => TvSeasonBloc(getTvSeason: locator()));
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
  locator.registerLazySingleton(() => GetTvSeason(locator()));

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
