import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/tv.dart';
import '../../../domain/usecases/tv_usecase/get_top_rated_tvs.dart';

part 'top_rated_tvs_event.dart';
part 'top_rated_tvs_state.dart';

class TopRatedTvsBloc extends Bloc<TopRatedTvsEvent, TopRatedTvsState> {
  final GetTopRatedTvs topRatedTvs;

  TopRatedTvsBloc({required this.topRatedTvs}) : super(TopRatedTvsEmpty()) {
    on<FetchTopRatedTvs>(((event, emit) async {
      emit(TopRatedTvsLoading());
      final result = await topRatedTvs.execute();
      result.fold(
        (failure) => emit(TopRatedTvsError(failure.message)),
        (tvs) => emit(TopRatedTvsHasData(tvs)),
      );
    }));
  }
}
