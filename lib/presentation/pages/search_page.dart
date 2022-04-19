import '../../common/constants.dart';
import '../../common/state_enum.dart';
import '../provider/movie_provider/movie_search_notifier.dart';
import '../widgets/movie_card_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/tv_provider/tv_search_notifier.dart';
import '../widgets/tv_card_list.dart';

class SearchPage extends StatelessWidget {
  static const ROUTE_NAME = '/search';
  final bool isMovie;

  SearchPage({required this.isMovie});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            isMovie
                ? TextField(
                    onSubmitted: (query) {
                      Provider.of<MovieSearchNotifier>(context, listen: false)
                          .fetchMovieSearch(query);
                    },
                    decoration: InputDecoration(
                      hintText: 'Search title',
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(),
                    ),
                    textInputAction: TextInputAction.search,
                  )
                : TextField(
                    onSubmitted: (query) {
                      Provider.of<TvSearchNotifier>(context, listen: false)
                          .fetchTvSearch(query);
                    },
                    decoration: InputDecoration(
                      hintText: 'Search Tv Show',
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(),
                    ),
                    textInputAction: TextInputAction.search,
                  ),
            SizedBox(height: 16),
            Text(
              'Search Result',
              style: kHeading6,
            ),
            isMovie ? _buildMoviesResult() : _buildTvShowsResult()
          ],
        ),
      ),
    );
  }

  Widget _buildMoviesResult() {
    return Consumer<MovieSearchNotifier>(
      builder: (context, data, child) {
        if (data.state == RequestState.Loading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (data.state == RequestState.Loaded) {
          final result = data.searchResult;
          return Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(8),
              itemBuilder: (context, index) {
                final movie = data.searchResult[index];
                return MovieCard(movie);
              },
              itemCount: result.length,
            ),
          );
        } else {
          return Expanded(
            child: Container(),
          );
        }
      },
    );
  }

  Widget _buildTvShowsResult() {
    return Consumer<TvSearchNotifier>(
      builder: (context, data, child) {
        if (data.state == RequestState.Loading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (data.state == RequestState.Loaded) {
          final result = data.searchResult;
          return Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(8),
              itemBuilder: (context, index) {
                final tvShow = data.searchResult[index];
                return TvCard(tvShow);
              },
              itemCount: result.length,
            ),
          );
        } else {
          return Expanded(
            child: Container(),
          );
        }
      },
    );
  }
}
