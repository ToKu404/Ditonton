import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/core.dart';
import '../../domain/entities/movie.dart';
import '../../domain/entities/movie_detail.dart';
import '../bloc/movie_detail_bloc/movie_detail_bloc.dart';
import '../bloc/movie_watchlist_bloc/movie_watchlist_bloc.dart';
import '../widgets/movie_card_horizontal.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:readmore/readmore.dart';

class MovieDetailPage extends StatefulWidget {
  static const ROUTE_NAME = '/movie-detail';

  final int id;
  const MovieDetailPage({Key? key, required this.id}) : super(key: key);

  @override
  _MovieDetailPageState createState() => _MovieDetailPageState();
}

class _MovieDetailPageState extends State<MovieDetailPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      BlocProvider.of<MovieDetailBloc>(context, listen: false)
          .add(FetchMovieDetail(widget.id));
      BlocProvider.of<MovieWatchlistBloc>(context, listen: false)
          .add(LoadWatchlistStatus(widget.id));
    });
  }

  @override
  Widget build(BuildContext context) {
    bool isAddedToWatchList = context.select<MovieWatchlistBloc, bool>(
        (watchlistBloc) => (watchlistBloc.state is SuccessLoadWatchlist)
            ? (watchlistBloc.state as SuccessLoadWatchlist).isAddedToWatchlist
            : false);
    return Scaffold(
      body: BlocListener<MovieWatchlistBloc, MovieWatchlistState>(
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
        child: BlocBuilder<MovieDetailBloc, MovieDetailState>(
          builder: ((context, state) {
            if (state is MovieDetailLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is MovieDetailHasData) {
              return SafeArea(
                child: DetailContent(
                  state.movieDetail,
                  state.movieRecommendations,
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
  final MovieDetail movie;
  final List<Movie> recommendations;
  final bool isAddedToWatchlist;

  const DetailContent(this.movie, this.recommendations, this.isAddedToWatchlist,
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
                  movie.title,
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
                        'https://image.tmdb.org/t/p/w400${(movie.backdropPath != null) ? movie.backdropPath : movie.posterPath}',
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
                                'https://image.tmdb.org/t/p/w500${movie.posterPath}',
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
                                  _showDuration(movie.runtime),
                                  style: const TextStyle(
                                      fontSize: 12, color: Colors.grey),
                                ),
                                Text(
                                  movie.title,
                                  style: kHeading6,
                                ),
                                const SizedBox(
                                  height: 4,
                                ),
                                Row(
                                  children: [
                                    RatingBarIndicator(
                                      rating: movie.voteAverage / 2,
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
                                      '${movie.voteAverage}',
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
                key : const Key('watchlistBtnKey'),
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: InkWell(
                  onTap: () async {
                    if (!isAddedToWatchlist) {
                      BlocProvider.of<MovieWatchlistBloc>(context,
                              listen: false)
                          .add(AddToWatchlist(movie));
                    } else {
                      BlocProvider.of<MovieWatchlistBloc>(context,
                              listen: false)
                          .add(RemoveFromWatchList(movie));
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
                        isAddedToWatchlist
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
                  children: movie.genres
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
                  movie.overview,
                  trimLines: 3,
                  trimMode: TrimMode.Line,
                  colorClickableText: kWhite,
                  style: const TextStyle(color: Colors.grey, fontSize: 12),
                ),
              ),
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
                          final movie = recommendations[index];
                          return MovieCardHorizontal(movie: movie);
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

  String _showDuration(int runtime) {
    final int hours = runtime ~/ 60;
    final int minutes = runtime % 60;

    if (hours > 0) {
      return '${hours}h ${minutes}m';
    } else {
      return '${minutes}m';
    }
  }
}
