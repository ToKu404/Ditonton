import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/popular_movies_bloc/popular_movies_bloc.dart';
import '../widgets/movie_card_vertical.dart';
import 'package:flutter/material.dart';

class PopularMoviesPage extends StatefulWidget {
  static const ROUTE_NAME = '/popular-movie';

  const PopularMoviesPage({Key? key}) : super(key: key);

  @override
  _PopularMoviesPageState createState() => _PopularMoviesPageState();
}

class _PopularMoviesPageState extends State<PopularMoviesPage> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<PopularMoviesBloc>(context, listen: false)
        .add(FetchPopularMovies());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Popular Movies'),
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(EvaIcons.arrowBack),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<PopularMoviesBloc, PopularMoviesState>(
          builder: (context, state) {
            if (state is PopularMoviesLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is PopularMoviesHasData) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final movie = state.listMovie[index];
                  return MovieCardVertical(movie);
                },
                itemCount: state.listMovie.length,
              );
            } else if (state is PopularMoviesError) {
              return Center(
                key: const Key('error_message'),
                child: Text(state.message),
              );
            } else {
              return const Center();
            }
          },
        ),
      ),
    );
  }
}
