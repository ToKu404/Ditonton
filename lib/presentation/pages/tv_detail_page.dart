import 'package:cached_network_image/cached_network_image.dart';
import 'package:ditonton/presentation/widgets/tv_card_list.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../common/constants.dart';
import '../../domain/entities/genre.dart';
import '../bloc/tv_detail_bloc/tv_detail_bloc.dart';
import '../bloc/tv_season_bloc/tv_season_bloc.dart';
import '../bloc/tv_watchlist_bloc/tv_watchlist_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../../domain/entities/tv.dart';
import '../../domain/entities/tv_detail.dart';
import '../widgets/episode_card.dart';

class TvDetailPage extends StatefulWidget {
  static const ROUTE_NAME = '/detail-tv';

  final int id;
  TvDetailPage({required this.id});

  @override
  _TvDetailPageState createState() => _TvDetailPageState();
}

class _TvDetailPageState extends State<TvDetailPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      BlocProvider.of<TvDetailBloc>(context, listen: false)
        ..add(FetchTvDetail(widget.id));
      BlocProvider.of<TvWatchlistBloc>(context, listen: false)
        ..add(LoadWatchlistStatus(widget.id));
    });
  }

  @override
  Widget build(BuildContext context) {
    bool isAddedToWatchList = context.select<TvWatchlistBloc, bool>(
        (watchlistBloc) => (watchlistBloc.state is SuccessLoadWatchlist)
            ? (watchlistBloc.state as SuccessLoadWatchlist).isAddedToWatchlist
            : false);
    return Scaffold(
      body: BlocListener<TvWatchlistBloc, TvWatchlistState>(
        listener: (context, state) {
          if (state is SuccessAddOrRemoveWatchlist) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(state.message),
              duration: Duration(seconds: 5),
            ));
          } else if (state is FailedAddOrRemoveWatchlist) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(state.message),
              duration: Duration(seconds: 2),
            ));
          }
        },
        child: BlocBuilder<TvDetailBloc, TvDetailState>(
          builder: ((context, state) {
            if (state is TvDetailLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is TvDetailHasData) {
              return SafeArea(
                child: DetailContent(
                  state.tvDetail,
                  state.tvRecommendations,
                  isAddedToWatchList,
                ),
              );
            } else {
              return Center();
            }
          }),
        ),
      ),
    );
  }
}

class DetailContent extends StatefulWidget {
  final TvDetail tv;
  final List<Tv> recommendations;
  final bool isAddedWatchlist;

  DetailContent(this.tv, this.recommendations, this.isAddedWatchlist);

  @override
  State<DetailContent> createState() => _DetailContentState();
}

class _DetailContentState extends State<DetailContent> {
  int _selectIndex = 0;

  @override
  void initState() {
    super.initState();
    BlocProvider.of<TvSeasonBloc>(context, listen: false)
      ..add(FetchTvSeason(widget.tv.id, widget.tv.seasons[0].seasonNumber));
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Stack(
      children: [
        CachedNetworkImage(
          imageUrl: 'https://image.tmdb.org/t/p/w500${widget.tv.posterPath}',
          width: screenWidth,
          placeholder: (context, url) => Center(
            child: CircularProgressIndicator(),
          ),
          errorWidget: (context, url, error) => Icon(Icons.error),
        ),
        Container(
          margin: const EdgeInsets.only(top: 48 + 8),
          child: DraggableScrollableSheet(
            builder: (context, scrollController) {
              return Container(
                decoration: BoxDecoration(
                  color: kRichBlack,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                ),
                padding: const EdgeInsets.only(
                  left: 16,
                  top: 16,
                  right: 16,
                ),
                child: Stack(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 16),
                      child: SingleChildScrollView(
                        controller: scrollController,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.tv.name,
                              style: kHeading5,
                            ),
                            ElevatedButton(
                              onPressed: () async {
                                if (!widget.isAddedWatchlist) {
                                  BlocProvider.of<TvWatchlistBloc>(context,
                                      listen: false)
                                    ..add(AddToWatchlist(widget.tv));
                                } else {
                                  BlocProvider.of<TvWatchlistBloc>(context,
                                      listen: false)
                                    ..add(RemoveFromWatchList(widget.tv));
                                }
                              },
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  widget.isAddedWatchlist
                                      ? Icon(Icons.check)
                                      : Icon(Icons.add),
                                  Text('Watchlist'),
                                ],
                              ),
                            ),
                            Text(
                              _showGenres(widget.tv.genres),
                            ),
                            Text(
                              _showYear(widget.tv.firstAirDate) +
                                  "• ${widget.tv.numberOfSeasons} season",
                            ),
                            Row(
                              children: [
                                RatingBarIndicator(
                                  rating: widget.tv.voteAverage / 2,
                                  itemCount: 5,
                                  itemBuilder: (context, index) => Icon(
                                    Icons.star,
                                    color: kMikadoYellow,
                                  ),
                                  itemSize: 24,
                                ),
                                Text('${widget.tv.voteAverage}')
                              ],
                            ),
                            SizedBox(height: 16),
                            Text(
                              'Overview',
                              style: kHeading6,
                            ),
                            Text(
                              widget.tv.overview,
                            ),
                            SizedBox(height: 16),
                            Text(
                              'Seasons',
                              style: kHeading6,
                            ),
                            SizedBox(
                              height: 40.0,
                              child: ListView.builder(
                                physics: ClampingScrollPhysics(),
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                itemCount: widget.tv.seasons.length,
                                itemBuilder:
                                    (BuildContext context, int index) =>
                                        InkWell(
                                  onTap: () {
                                    setState(() {
                                      _selectIndex = index;
                                      BlocProvider.of<TvSeasonBloc>(context,
                                          listen: false)
                                        ..add(FetchTvSeason(
                                            widget.tv.id,
                                            widget.tv.seasons[index]
                                                .seasonNumber));
                                    });
                                  },
                                  child: Container(
                                    padding: EdgeInsets.all(6),
                                    height: 40,
                                    margin: EdgeInsets.only(right: 8),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Season ${widget.tv.seasons[index].seasonNumber}',
                                          style: TextStyle(
                                              color: (_selectIndex == index)
                                                  ? kWhite
                                                  : kDavysGrey),
                                        ),
                                        (_selectIndex == index)
                                            ? Container(
                                                height: 4,
                                                width: 12,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            6),
                                                    color: kMikadoYellow),
                                              )
                                            : Container(),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Container(
                              height: 146.0,
                              child: BlocBuilder<TvSeasonBloc, TvSeasonState>(
                                builder: ((context, state) {
                                  if (state is TvSeasonLoading) {
                                    return Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  } else if (state is TvSeasonHasData) {
                                    List eps = state.tvSeason.episodes
                                        .where((e) =>
                                            e.overview != "" ||
                                            e.stillPath != null)
                                        .toList();
                                    // final eps = state.tvSeason.episodes;
                                    return ListView.builder(
                                        physics: ClampingScrollPhysics(),
                                        shrinkWrap: true,
                                        scrollDirection: Axis.horizontal,
                                        itemCount: eps.length,
                                        itemBuilder:
                                            (BuildContext context, int index) =>
                                                EpisodeCard(eps: eps[index]));
                                  } else if (state is TvSeasonError) {
                                    return Text(state.messsage);
                                  } else {
                                    return Container();
                                  }
                                }),
                              ),
                            ),
                            // SizedBox(
                            //   height: 16,
                            // ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  widget.recommendations.isEmpty
                                      ? ""
                                      : 'Recommendations',
                                  style: kHeading6,
                                ),
                                Container(
                                  height: 150,
                                  child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder: (context, index) {
                                      final tv = widget.recommendations[index];
                                      return TvCardList(tv: tv);
                                    },
                                    itemCount: widget.recommendations.length,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        color: Colors.white,
                        height: 4,
                        width: 48,
                      ),
                    ),
                  ],
                ),
              );
            },
            // initialChildSize: 0.5,
            minChildSize: 0.25,
            // maxChildSize: 1.0,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundColor: kRichBlack,
            foregroundColor: Colors.white,
            child: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        )
      ],
    );
  }

  String _showGenres(List<Genre> genres) {
    String result = '';
    for (var genre in genres) {
      result += genre.name + ', ';
    }

    if (result.isEmpty) {
      return result;
    }

    return result.substring(0, result.length - 2);
  }

  String _showYear(String? date) {
    final String? year = date == null ? "" : date.substring(0, 4);
    return "$year";
  }
}
