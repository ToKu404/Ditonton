import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/movie.dart';
import '../../../domain/usecases/get_now_playing_movies.dart';

part 'now_playing_movies_state.dart';
part 'now_playing_movies_event.dart';

class NowPlayingMoviesBloc
    extends Bloc<NowPlayingMoviesEvent, NowPlayingMoviesState> {
  final GetNowPlayingMovies getNowPlayingMovies;

  NowPlayingMoviesBloc({required this.getNowPlayingMovies})
      : super(NowPlayingMovieEmpty()) {
    on<FetchNowPlayingMovies>(((event, emit) async {
      emit(NowPlayingMovieLoading());
      final movies = await getNowPlayingMovies.execute();

      movies.fold(
        (failure) => emit(NowPlayingMovieError(failure.message)),
        (movies) => emit(NowPlayingMovieHasData(movies)),
      );
    }));
  }
}
