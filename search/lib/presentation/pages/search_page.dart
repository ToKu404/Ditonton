import 'package:core/common/constants.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/presentation/widgets/movie_card_vertical.dart';
import 'package:tv/presentation/widgets/tv_card_vertical.dart';

import '../bloc/movie_search_bloc/movie_search_bloc.dart';
import '../bloc/tv_search_bloc/tv_search_bloc.dart';

class SearchPage extends StatelessWidget {
  static const ROUTE_NAME = '/search';
  final List<String> _tabTitle = ['Movies', 'Tv Shows'];
  final List<Widget> _bodyPage = [
    const SearchMovieResult(),
    const SearchTvResult()
  ];

  SearchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Search'),
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
              context
                  .read<MovieSearchBloc>()
                  .add(const OnQueryMovieChanged(""));
              context.read<TvSearchBloc>().add(const OnQueryTvChanged(""));
            },
            icon: const Icon(EvaIcons.arrowBack),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              TextField(
                autofocus: true,
                onChanged: (query) {
                  context
                      .read<MovieSearchBloc>()
                      .add(OnQueryMovieChanged(query));
                  context.read<TvSearchBloc>().add(OnQueryTvChanged(query));
                },
                decoration: InputDecoration(
                    hintText: 'Search Title',
                    prefixIcon: const Icon(EvaIcons.search),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(24)),
                    contentPadding: const EdgeInsets.all(12)),
                textInputAction: TextInputAction.search,
              ),
              const SizedBox(height: 16),
              TabBar(
                indicator: BoxDecoration(
                    borderRadius: BorderRadius.circular(8), // Creates border
                    color: kMikadoYellow),
                tabs: [
                  Tab(
                    child: Text(_tabTitle[0], style: kSubtitle),
                  ),
                  Tab(
                    child: Text(_tabTitle[1], style: kSubtitle),
                  ),
                ],
              ),
              const SizedBox(
                height: 8,
              ),
              Flexible(child: TabBarView(children: _bodyPage))
            ],
          ),
        ),
      ),
    );
  }
}

class SearchMovieResult extends StatelessWidget {
  const SearchMovieResult({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MovieSearchBloc, MovieSearchState>(
      builder: ((context, state) {
        if (state is MovieSearchLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is MovieSearchHasData) {
          final result = state.result;
          return ListView.builder(
              itemCount: result.length,
              itemBuilder: ((context, index) {
                final movie = result[index];
                return MovieCardVertical(movie);
              }));
        } else if (state is MovieSearchEmpty) {
          return Center(
            child: Text(
              "Empty",
              style: kSubtitle,
            ),
          );
        } else if (state is MovieSearchError) {
          return Center(
            child: Text(state.message, style: kSubtitle),
          );
        } else {
          return Container();
        }
      }),
    );
  }
}

class SearchTvResult extends StatelessWidget {
  const SearchTvResult({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TvSearchBloc, TvSearchState>(
      builder: ((context, state) {
        if (state is TvSearchLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is TvSearchHasData) {
          final result = state.result;
          return ListView.builder(
            itemCount: result.length,
            itemBuilder: ((context, index) {
              final movie = result[index];
              return TvCardVertical(movie);
            }),
          );
        } else if (state is TvSearchEmpty) {
          return Center(
            child: Text(
              "Empty",
              style: kSubtitle,
            ),
          );
        } else if (state is TvSearchError) {
          return Center(
            child: Text(state.message, style: kSubtitle),
          );
        } else {
          return Container();
        }
      }),
    );
  }
}
