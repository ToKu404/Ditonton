import '../../../domain/entities/movie.dart';
import '../../../domain/usecases/get_popular_movies.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'popular_movies_event.dart';
part 'popular_movies_state.dart';

class PopularMoviesBloc extends Bloc<PopularMoviesEvent, PopularMoviesState> {
  final GetPopularMovies popularMovies;

  PopularMoviesBloc({required this.popularMovies})
      : super(PopularMoviesEmpty()) {
    on<FetchPopularMovies>(((event, emit) async {
      emit(PopularMoviesLoading());
      final result = await popularMovies.execute();
      result.fold(
        (failure) => emit(PopularMoviesError(failure.message)),
        (movies) => emit(PopularMoviesHasData(movies)),
      );
    }));
  }
}
