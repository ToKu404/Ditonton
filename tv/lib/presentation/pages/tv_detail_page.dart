import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/core.dart';
import '../bloc/tv_watchlist_bloc/tv_watchlist_bloc.dart';
import '../widgets/tv_card_horizontal.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:readmore/readmore.dart';

import '../bloc/tv_detail_bloc/tv_detail_bloc.dart';
import '../bloc/tv_season_bloc/tv_season_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../../domain/entities/tv.dart';
import '../../domain/entities/tv_detail.dart';
import '../widgets/episode_card.dart';

class TvDetailPage extends StatefulWidget {
  static const ROUTE_NAME = '/tv-detail';

  final int id;
  const TvDetailPage({Key? key, required this.id}) : super(key: key);

  @override
  _TvDetailPageState createState() => _TvDetailPageState();
}

class _TvDetailPageState extends State<TvDetailPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      BlocProvider.of<TvDetailBloc>(context, listen: false)
          .add(FetchTvDetail(widget.id));
      BlocProvider.of<TvWatchlistBloc>(context, listen: false)
          .add(LoadWatchlistStatus(widget.id));
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
              backgroundColor: kMikadoYellow,
              duration: const Duration(seconds: 1),
            ));
          } else if (state is FailedAddOrRemoveWatchlist) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(state.message),
              duration: const Duration(seconds: 1),
            ));
          }
        },
        child: BlocBuilder<TvDetailBloc, TvDetailState>(
          builder: ((context, state) {
            if (state is TvDetailLoading) {
              return const Center(
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
              return const Center();
            }
          }),
        ),
      ),
    );
  }
}

class DetailContent extends StatelessWidget {
  final TvDetail tv;
  final List<Tv> recommendations;
  final bool isAddedWatchlist;

  const DetailContent(this.tv, this.recommendations, this.isAddedWatchlist,
      {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Column(
      children: [
        Row(
          children: [
            IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: const Icon(EvaIcons.arrowBack)),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(
                    right: 16.0, top: 8, bottom: 8, left: 8),
                child: Text(
                  tv.name,
                  maxLines: 2,
                  style: kHeading5,
                ),
              ),
            ),
          ],
        ),
        Expanded(
          child: SingleChildScrollView(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Stack(
                children: [
                  CachedNetworkImage(
                    imageUrl:
                        'https://image.tmdb.org/t/p/w400${(tv.backdropPath != null) ? tv.backdropPath : tv.posterPath}',
                    width: screenWidth,
                    height: 200,
                    fit: BoxFit.cover,
                    placeholder: (context, url) => const Center(
                      child: CircularProgressIndicator(),
                    ),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  ),
                  Container(
                    width: screenWidth,
                    height: 200,
                    decoration: const BoxDecoration(
                        gradient: LinearGradient(
                            colors: [kRichBlack, Colors.transparent],
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter)),
                  ),
                  Container(
                    margin:
                        const EdgeInsets.only(top: 140, left: 16, right: 16),
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: CachedNetworkImage(
                            imageUrl:
                                'https://image.tmdb.org/t/p/w500${tv.posterPath}',
                            width: 80,
                            height: 120,
                            fit: BoxFit.cover,
                            placeholder: (context, url) => const Center(
                              child: CircularProgressIndicator(),
                            ),
                            errorWidget: (context, url, error) =>
                                const Icon(Icons.error),
                          ),
                        ),
                        const SizedBox(
                          width: 16,
                        ),
                        Expanded(
                          child: Container(
                            margin: const EdgeInsets.only(top: 200 - 160),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  _showYear(tv.firstAirDate),
                                  style: const TextStyle(
                                      fontSize: 12, color: Colors.grey),
                                ),
                                Text(
                                  tv.name,
                                  style: kHeading6,
                                ),
                                const SizedBox(
                                  height: 4,
                                ),
                                Row(
                                  children: [
                                    RatingBarIndicator(
                                      rating: tv.voteAverage / 2,
                                      itemCount: 5,
                                      itemBuilder: (context, index) =>
                                          const Icon(
                                        Icons.star,
                                        color: kMikadoYellow,
                                      ),
                                      itemSize: 18,
                                    ),
                                    const SizedBox(
                                      width: 4,
                                    ),
                                    Text(
                                      '${tv.voteAverage}',
                                      style:
                                          const TextStyle(color: kMikadoYellow),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 16,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: InkWell(
                  onTap: () async {
                    if (!isAddedWatchlist) {
                      BlocProvider.of<TvWatchlistBloc>(context, listen: false)
                          .add(AddToWatchlist(tv));
                    } else {
                      BlocProvider.of<TvWatchlistBloc>(context, listen: false)
                          .add(RemoveFromWatchList(tv));
                    }
                  },
                  child: Container(
                    width: double.infinity,
                    alignment: Alignment.center,
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8), color: kGrey),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        isAddedWatchlist
                            ? const Icon(
                                EvaIcons.checkmark,
                                size: 16,
                                color: kMikadoYellow,
                              )
                            : const Icon(
                                EvaIcons.plus,
                                size: 16,
                                color: kWhite,
                              ),
                        const SizedBox(
                          width: 4,
                        ),
                        const Text('Watchlist'),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  'Genre',
                  style: kSubtitle,
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              SizedBox(
                height: 25,
                child: ListView(
                  padding: const EdgeInsets.only(left: 16),
                  scrollDirection: Axis.horizontal,
                  children: tv.genres
                      .map(
                        (genre) => Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(width: 1, color: kGrey),
                              color: kRichBlack),
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          margin: const EdgeInsets.only(right: 6),
                          child: Center(
                            child: Text(
                              genre.name,
                              style: const TextStyle(fontSize: 12, height: 1),
                            ),
                          ),
                        ),
                      )
                      .toList(),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  'Description',
                  style: kSubtitle,
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: ReadMoreText(
                  tv.overview,
                  trimLines: 3,
                  trimMode: TrimMode.Line,
                  colorClickableText: kWhite,
                  style: const TextStyle(color: Colors.grey, fontSize: 12),
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  (tv.seasons.length == 1) ? 'Season 1' : 'Seasons',
                  style: kSubtitle,
                ),
              ),
              SeasonContent(tv),
              const SizedBox(
                height: 16,
              ),
              (recommendations.isEmpty)
                  ? Container()
                  : Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Text(
                        'Similar Movies',
                        style: kSubtitle,
                      ),
                    ),
              const SizedBox(
                height: 8,
              ),
              (recommendations.isEmpty)
                  ? Container()
                  : SizedBox(
                      height: 150,
                      child: ListView.builder(
                        padding: const EdgeInsets.only(left: 16),
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          final tv = recommendations[index];
                          return TvCardHorizontal(tv: tv);
                        },
                        itemCount: recommendations.length,
                      ),
                    ),
              const SizedBox(
                height: 16,
              ),
            ]),
          ),
        ),
      ],
    );
  }

  String _showYear(String? date) {
    final String year = date == null ? "" : date.substring(0, 4);
    return year;
  }
}

class SeasonContent extends StatefulWidget {
  final TvDetail tv;
  const SeasonContent(this.tv, {Key? key}) : super(key: key);

  @override
  State<SeasonContent> createState() => _SeasonContentState();
}

class _SeasonContentState extends State<SeasonContent> {
  int _selectIndex = 0;

  @override
  void initState() {
    super.initState();
    BlocProvider.of<TvSeasonBloc>(context, listen: false)
        .add(FetchTvSeason(widget.tv.id, widget.tv.seasons[0].seasonNumber));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        (widget.tv.seasons.length == 1)
            ? Container()
            : SizedBox(
                height: 40.0,
                child: ListView.builder(
                  padding: const EdgeInsets.only(left: 16),
                  physics: const ClampingScrollPhysics(),
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: widget.tv.seasons.length,
                  itemBuilder: (BuildContext context, int index) => InkWell(
                    onTap: () {
                      setState(() {
                        _selectIndex = index;
                        BlocProvider.of<TvSeasonBloc>(context, listen: false)
                            .add(FetchTvSeason(widget.tv.id,
                                widget.tv.seasons[index].seasonNumber));
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 6),
                      height: 40,
                      margin: const EdgeInsets.only(right: 8),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                      borderRadius: BorderRadius.circular(6),
                                      color: kMikadoYellow),
                                )
                              : Container(),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
        const SizedBox(
          height: 8,
        ),
        SizedBox(
          height: 100.0,
          child: BlocBuilder<TvSeasonBloc, TvSeasonState>(
            builder: ((context, state) {
              if (state is TvSeasonLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is TvSeasonHasData) {
                List eps = state.tvSeason.episodes
                    .where((e) => e.overview != "" || e.stillPath != null)
                    .toList();
                // final eps = state.tvSeason.episodes;
                return ListView.builder(
                    padding: const EdgeInsets.only(left: 16),
                    physics: const ClampingScrollPhysics(),
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: eps.length,
                    itemBuilder: (BuildContext context, int index) =>
                        EpisodeCard(eps: eps[index]));
              } else if (state is TvSeasonError) {
                return Text(state.messsage);
              } else {
                return Container();
              }
            }),
          ),
        ),
      ],
    );
  }
}
