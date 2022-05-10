import 'package:ditonton/presentation/bloc/movie_detail_bloc/movie_detail_bloc.dart';
import 'package:ditonton/presentation/bloc/movie_watchlist_bloc/movie_watchlist_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'presentation/bloc/movie_search_bloc/movie_search_bloc.dart';
import 'presentation/bloc/now_playing_movies_bloc/now_playing_movies_bloc.dart';
import 'presentation/bloc/popular_movies_bloc/popular_movies_bloc.dart';
import 'presentation/bloc/top_rated_movies_bloc/top_rated_movies_bloc.dart';
import 'presentation/bloc/tv_search_bloc/tv_search_bloc.dart';
import 'presentation/bloc/watchlist_movie_bloc/watchlist_movie_bloc.dart';
import 'presentation/pages/home_page.dart';
import 'presentation/pages/tv_season_page.dart';
import 'presentation/provider/tv_provider/popular_tvs_notifier.dart';
import 'presentation/provider/tv_provider/top_rated_tvs_notifier.dart';

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
import 'presentation/provider/tv_provider/on_the_air_tvs_notifier.dart';
import 'presentation/provider/tv_provider/tv_detail_notifier.dart';
import 'presentation/provider/tv_provider/tv_list_notifier.dart';
import 'presentation/provider/tv_provider/tv_search_notifier.dart';
import 'presentation/provider/tv_provider/tv_season_notifier.dart';
import 'presentation/provider/tv_provider/watchlist_tv_notifier.dart';

void main() {
  di.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => di.locator<TvListNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<OnTheAirTvsNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<PopularTvsNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<TopRatedTvsNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<TvDetailNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<WatchlistTvNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<TvSeasonNotifier>(),
        ),
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
          create: (_) => di.locator<MovieWatchlistBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<NowPlayingMoviesBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<TopRatedMoviesBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<PopularMoviesBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<WatchlistMovieBloc>(),
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
            case TvSeasonPage.ROUTE_NAME:
              TvSeasonArguments arguments =
                  settings.arguments as TvSeasonArguments;
              return CupertinoPageRoute(
                  builder: (_) => TvSeasonPage(
                        id: arguments.id,
                        seasonNumber: arguments.seasonNumber,
                      ));
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
