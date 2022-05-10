import 'package:cached_network_image/cached_network_image.dart';
import 'package:ditonton/presentation/bloc/now_playing_movies_bloc/now_playing_movies_bloc.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../common/constants.dart';
import '../../domain/entities/movie.dart';
import '../bloc/popular_movies_bloc/popular_movies_bloc.dart';
import '../bloc/top_rated_movies_bloc/top_rated_movies_bloc.dart';
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
    BlocProvider.of<NowPlayingMoviesBloc>(context, listen: false)
      ..add(FetchNowPlayingMovies());
    BlocProvider.of<TopRatedMoviesBloc>(context, listen: false)
      ..add(FetchTopRatedMovies());
    BlocProvider.of<PopularMoviesBloc>(context, listen: false)
      ..add(FetchPopularMovies());
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
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is NowPlayingMovieHasData) {
                return MovieList(state.listMovie);
              } else {
                return Text('Failed');
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
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is PopularMoviesHasData) {
                return MovieList(state.listMovie);
              } else {
                return Text('Failed');
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
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is TopRatedMoviesHasData) {
                return MovieList(state.listMovie);
              } else {
                return Text('Failed');
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
              size: 18,
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
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final movie = movies[index];
          return Container(
            width: 110,
            padding: const EdgeInsets.only(left: 8, bottom: 8, top: 4),
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  MovieDetailPage.ROUTE_NAME,
                  arguments: movie.id,
                );
              },
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(8)),
                child: CachedNetworkImage(
                  fit: BoxFit.cover,
                  imageUrl: '$BASE_IMAGE_URL${movie.posterPath}',
                  placeholder: (context, url) => Center(
                    child: CircularProgressIndicator(),
                  ),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
              ),
            ),
          );
        },
        itemCount: movies.length,
      ),
    );
  }
}
