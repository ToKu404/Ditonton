import 'package:cached_network_image/cached_network_image.dart';
import 'package:ditonton/presentation/bloc/now_playing_movies_bloc/now_playing_movies_bloc.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../common/constants.dart';
import '../../domain/entities/movie.dart';
import '../bloc/popular_movies_bloc/popular_movies_bloc.dart';
import '../bloc/top_rated_movies_bloc/top_rated_movies_bloc.dart';
import '../widgets/movie_card_horizontal.dart';
import 'movie_detail_page.dart';
import 'popular_movies_page.dart';
import 'top_rated_movies_page.dart';
import 'package:flutter/material.dart';

class MoviePage extends StatefulWidget {
  @override
  _MoviePageState createState() => _MoviePageState();
}

class _MoviePageState extends State<MoviePage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      BlocProvider.of<NowPlayingMoviesBloc>(context, listen: false)
        ..add(FetchNowPlayingMovies());
      BlocProvider.of<TopRatedMoviesBloc>(context, listen: false)
        ..add(FetchTopRatedMovies());
      BlocProvider.of<PopularMoviesBloc>(context, listen: false)
        ..add(FetchPopularMovies());
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 8,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              'Now Playing',
              style: kHeading6,
            ),
          ),
          BlocBuilder<NowPlayingMoviesBloc, NowPlayingMoviesState>(
            builder: ((context, state) {
              if (state is NowPlayingMovieLoading) {
                return Container(
                  height: 170,
                  width: double.infinity,
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              } else if (state is NowPlayingMovieHasData) {
                return MovieList(state.listMovie);
              } else {
                return Container(
                    height: 170,
                    width: double.infinity,
                    child: Center(child: Text('Failed')));
              }
            }),
          ),
          _buildSubHeading(
            title: 'Popular',
            onTap: () =>
                Navigator.pushNamed(context, PopularMoviesPage.ROUTE_NAME),
          ),
          BlocBuilder<PopularMoviesBloc, PopularMoviesState>(
            builder: ((context, state) {
              if (state is PopularMoviesLoading) {
                return Container(
                  height: 170,
                  width: double.infinity,
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              } else if (state is PopularMoviesHasData) {
                return MovieList(state.listMovie);
              } else {
                return Container(
                    height: 170,
                    width: double.infinity,
                    child: Center(child: Text('Failed')));
              }
            }),
          ),
          _buildSubHeading(
            title: 'Top Rated',
            onTap: () =>
                Navigator.pushNamed(context, TopRatedMoviesPage.ROUTE_NAME),
          ),
          BlocBuilder<TopRatedMoviesBloc, TopRatedMoviesState>(
            builder: ((context, state) {
              if (state is TopRatedMoviesLoading) {
                return Container(
                  height: 170,
                  width: double.infinity,
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              } else if (state is TopRatedMoviesHasData) {
                return MovieList(state.listMovie);
              } else {
                return Container(
                    height: 170,
                    width: double.infinity,
                    child: Center(child: Text('Failed')));
              }
            }),
          ),
        ],
      ),
    );
  }

  Row _buildSubHeading({required String title, required Function() onTap}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Text(
            title,
            style: kHeading6,
          ),
        ),
        InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(
              EvaIcons.arrowIosForward,
              size: 20,
              color: kDavysGrey,
            ),
          ),
        ),
      ],
    );
  }
}

class MovieList extends StatelessWidget {
  final List<Movie> movies;

  MovieList(this.movies);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 170,
      child: ListView.builder(
        padding: EdgeInsets.only(left: 8),
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final movie = movies[index];
          return MovieCardList(movie: movie);
        },
        itemCount: movies.length,
      ),
    );
  }
}
