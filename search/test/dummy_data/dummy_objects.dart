import 'package:movie/domain/entities/movie.dart';
import 'package:tv/domain/entities/tv.dart';

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

// Tv Dummy Object
final testTv = Tv(
    id: 31917,
    posterPath: "/vC324sdfcS313vh9QXwijLIHPJp.jpg",
    name: "Pretty Little Liars",
    overview: "Overview");

final testTvList = [testTv];