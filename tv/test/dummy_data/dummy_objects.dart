// Tv Dummy Object
import 'package:tv/data/models/episode_model.dart';
import 'package:tv/data/models/tv_genre_model.dart';
import 'package:tv/data/models/season_model.dart';
import 'package:tv/data/models/tv_detail_model.dart';
import 'package:tv/data/models/tv_model.dart';
import 'package:tv/data/models/tv_response.dart';
import 'package:tv/data/models/tv_season_model.dart';
import 'package:tv/data/models/tv_table.dart';
import 'package:tv/domain/entities/episode.dart';
import 'package:tv/domain/entities/tv_genre.dart';
import 'package:tv/domain/entities/season.dart';
import 'package:tv/domain/entities/tv.dart';
import 'package:tv/domain/entities/tv_detail.dart';
import 'package:tv/domain/entities/tv_season.dart';

final testTv = Tv(
    id: 31917,
    posterPath: "/vC324sdfcS313vh9QXwijLIHPJp.jpg",
    name: "Pretty Little Liars",
    overview: "Overview");

const testTvModel = TvModel(
    id: 31917,
    posterPath: "/vC324sdfcS313vh9QXwijLIHPJp.jpg",
    name: "Pretty Little Liars",
    overview: "Overview");

const testTvDetailModel = TvDetailResponse(
    backdropPath: "/54CU1a2Wod9RCSVQ9BT0nUw5Enr.jpg",
    firstAirDate: "2004-01-12",
    genres: [TvGenreModel(id: 18, name: "Drama")],
    id: 1,
    name: "Pride",
    numberOfSeasons: 1,
    overview: "Overview",
    posterPath: "/9Ub2BwnLYKoiSaQF93ItyXriCon.jpg",
    seasons: [
      SeasonModel(
          id: 2328126,
          seasonNumber: 1,
          name: "Season 1",
          airDate: "2012-10-12",
          episodeCount: 12)
    ],
    voteAverage: 8.5,
    voteCount: 10);

final testTvDetail = TvDetail(
    backdropPath: "/54CU1a2Wod9RCSVQ9BT0nUw5Enr.jpg",
    firstAirDate: "2004-01-12",
    genres: const [TvGenre(id: 18, name: "Drama")],
    id: 1,
    name: "Pride",
    numberOfSeasons: 1,
    overview: "Overview",
    posterPath: "/9Ub2BwnLYKoiSaQF93ItyXriCon.jpg",
    seasons: [
      Season(
          id: 2328126,
          seasonNumber: 1,
          name: "Season 1",
          airDate: "2012-10-12",
          episodeCount: 12)
    ],
    voteAverage: 8.5,
    voteCount: 10);

final testTvList = [testTv];
final testTvModelList = <TvModel>[testTvModel];
const testTvResponseModel = TvResponse(tvList: <TvModel>[testTvModel]);

const testTvTable = TvTable(
  id: 1,
  name: 'Pride',
  posterPath: '/9Ub2BwnLYKoiSaQF93ItyXriCon.jpg',
  overview: 'Overview',
);

final testTvMap = {
  'id': 1,
  'overview': 'Overview',
  'posterPath': '/9Ub2BwnLYKoiSaQF93ItyXriCon.jpg',
  'name': 'Pride',
};

final testWatchlistTv = Tv.watchlist(
  id: 1,
  name: 'Pride',
  posterPath: '/9Ub2BwnLYKoiSaQF93ItyXriCon.jpg',
  overview: 'Overview',
);

const testTvSeasonModel = TvSeasonModel(
  episodes: [
    EpisodeModel(
        episodeNumber: 1,
        id: 1,
        name: "Name",
        overview: "Overview",
        stillPath: "/test.jpg")
  ],
  id: 1,
  name: "Name",
  seasonNumber: 1,
);
final testTvSeason = TvSeason(
  id: 1,
  seasonNumber: 1,
  name: "Name",
  episodes: [
    Episode(
        episodeNumber: 1,
        id: 1,
        name: "Name",
        overview: "Overview",
        stillPath: "/test.jpg")
  ],
);
