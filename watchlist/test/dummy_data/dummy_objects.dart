import 'package:movie/domain/entities/movie.dart';
import 'package:movie/domain/entities/movie_detail.dart';
import 'package:movie/domain/entities/movie_genre.dart';

import 'package:tv/domain/entities/season.dart';
import 'package:tv/domain/entities/tv.dart';
import 'package:tv/domain/entities/tv_detail.dart';
import 'package:tv/domain/entities/tv_genre.dart';

final testMovie = Movie(
  adult: false,
  backdropPath: '/muth4OYamXf41G2evdrLEg8d3om.jpg',
  genreIds: const [14, 28],
  id: 557,
  originalTitle: 'Spider-Man',
  overview:
      'After being bitten by a genetically altered spider, nerdy high school student Peter Parker is endowed with amazing powers to become the Amazing superhero known as Spider-Man.',
  popularity: 60.441,
  posterPath: '/rweIrveL43TaxUN0akQEaAXL6x0.jpg',
  releaseDate: '2002-05-01',
  title: 'Spider-Man',
  video: false,
  voteAverage: 7.2,
  voteCount: 13507,
);

final testMovieList = [testMovie];

const testMovieDetail = MovieDetail(
  adult: false,
  backdropPath: 'backdropPath',
  genres: [MovieGenre(id: 1, name: 'Action')],
  id: 1,
  originalTitle: 'originalTitle',
  overview: 'overview',
  posterPath: 'posterPath',
  releaseDate: 'releaseDate',
  runtime: 120,
  title: 'title',
  voteAverage: 1,
  voteCount: 1,
);

// Tv Dummy Object
final testTv = Tv(
    id: 31917,
    posterPath: "/vC324sdfcS313vh9QXwijLIHPJp.jpg",
    name: "Pretty Little Liars",
    overview: "Overview");

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
