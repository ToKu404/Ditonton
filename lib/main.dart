import 'package:ditonton/presentation/bloc/movie_detail_bloc/movie_detail_bloc.dart';
import 'package:ditonton/presentation/bloc/movie_watchlist_bloc/movie_watchlist_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'common/http_ssl_pinning.dart';
import 'presentation/bloc/movie_search_bloc/movie_search_bloc.dart';
import 'presentation/bloc/now_playing_movies_bloc/now_playing_movies_bloc.dart';
import 'presentation/bloc/on_the_air_tvs_bloc/on_the_air_tvs_bloc.dart';
import 'presentation/bloc/popular_movies_bloc/popular_movies_bloc.dart';
import 'presentation/bloc/popular_tvs_bloc/popular_tvs_bloc.dart';
import 'presentation/bloc/top_rated_movies_bloc/top_rated_movies_bloc.dart';
import 'presentation/bloc/top_rated_tvs_bloc/top_rated_tvs_bloc.dart';
import 'presentation/bloc/tv_detail_bloc/tv_detail_bloc.dart';
import 'presentation/bloc/tv_search_bloc/tv_search_bloc.dart';
import 'presentation/bloc/tv_season_bloc/tv_season_bloc.dart';
import 'presentation/bloc/tv_watchlist_bloc/tv_watchlist_bloc.dart';
import 'presentation/bloc/watchlist_movie_bloc/watchlist_movie_bloc.dart';
import 'presentation/bloc/watchlist_tv_bloc/watchlist_tv_bloc.dart';
import 'presentation/pages/home_page.dart';

import 'common/constants.dart';
import 'common/utils.dart';
import 'presentation/pages/movie_detail_page.dart';
import 'presentation/pages/on_the_air_tvs_page.dart';
import 'presentation/pages/popular_movies_page.dart';
import 'presentation/pages/popular_tvs_page.dart';
import 'presentation/pages/search_page.dart';
import 'presentation/pages/top_rated_movies_page.dart';
import 'presentation/pages/top_rated_tvs_page.dart';
import 'presentation/pages/tv_detail_page.dart';
import 'presentation/pages/watchlist_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'injection.dart' as di;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await HttpSSLPinning.init();
  di.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        BlocProvider(
          create: (_) => di.locator<MovieSearchBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<TvSearchBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<MovieDetailBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<TvDetailBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<MovieWatchlistBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<TvWatchlistBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<NowPlayingMoviesBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<OnTheAirTvsBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<TopRatedMoviesBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<TopRatedTvsBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<PopularMoviesBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<PopularTvsBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<WatchlistMovieBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<WatchlistTvBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<TvSeasonBloc>(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData.dark().copyWith(
          colorScheme: kColorScheme,
          primaryColor: kRichBlack,
          scaffoldBackgroundColor: kRichBlack,
          textTheme: kTextTheme,
        ),
        home: HomePage(),
        navigatorObservers: [routeObserver],
        onGenerateRoute: (RouteSettings settings) {
          switch (settings.name) {
            case HomePage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => HomePage());
            case PopularMoviesPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => PopularMoviesPage());
            case TopRatedMoviesPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => TopRatedMoviesPage());
            case MovieDetailPage.ROUTE_NAME:
              final id = settings.arguments as int;
              return MaterialPageRoute(
                builder: (_) => MovieDetailPage(id: id),
                settings: settings,
              );
            case WatchlistPage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => WatchlistPage());
            case SearchPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => SearchPage());
            case TvDetailPage.ROUTE_NAME:
              final id = settings.arguments as int;
              return MaterialPageRoute(
                builder: (_) => TvDetailPage(id: id),
                settings: settings,
              );
            case OnTheAirTvsPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => OnTheAirTvsPage());
            case PopularTvsPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => PopularTvsPage());
            case TopRatedTvsPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => TopRatedTvsPage());

            default:
              return MaterialPageRoute(builder: (_) {
                return Scaffold(
                  body: Center(
                    child: Text('Page not found :('),
                  ),
                );
              });
          }
        },
      ),
    );
  }
}
