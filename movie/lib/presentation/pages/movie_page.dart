import 'package:core/core.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/presentation/pages/popular_movies_page.dart';
import 'package:movie/presentation/pages/top_rated_movies_page.dart';
import '../../domain/entities/movie.dart';
import '../bloc/now_playing_movies_bloc/now_playing_movies_bloc.dart';
import '../bloc/popular_movies_bloc/popular_movies_bloc.dart';
import '../bloc/top_rated_movies_bloc/top_rated_movies_bloc.dart';
import '../widgets/movie_card_horizontal.dart';
import 'package:flutter/material.dart';

class MoviePage extends StatefulWidget {
  const MoviePage({Key? key}) : super(key: key);

  @override
  _MoviePageState createState() => _MoviePageState();
}

class _MoviePageState extends State<MoviePage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      BlocProvider.of<NowPlayingMoviesBloc>(context, listen: false)
          .add(FetchNowPlayingMovies());
      BlocProvider.of<TopRatedMoviesBloc>(context, listen: false)
          .add(FetchTopRatedMovies());
      BlocProvider.of<PopularMoviesBloc>(context, listen: false)
          .add(FetchPopularMovies());
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
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
                return const SizedBox(
                  height: 170,
                  width: double.infinity,
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              } else if (state is NowPlayingMovieHasData) {
                return MovieList(state.listMovie);
              } else {
                return const SizedBox(
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
                return const SizedBox(
                  height: 170,
                  width: double.infinity,
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              } else if (state is PopularMoviesHasData) {
                return MovieList(state.listMovie);
              } else {
                return const SizedBox(
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
                return const SizedBox(
                  height: 170,
                  width: double.infinity,
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              } else if (state is TopRatedMoviesHasData) {
                return MovieList(state.listMovie);
              } else {
                return const SizedBox(
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
          child: const Padding(
            padding: EdgeInsets.all(8.0),
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

  const MovieList(this.movies, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 170,
      child: ListView.builder(
        padding: const EdgeInsets.only(left: 8),
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final movie = movies[index];
          return MovieCardHorizontal(movie: movie);
        },
        itemCount: movies.length,
      ),
    );
  }
}
