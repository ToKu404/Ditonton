import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/tv.dart';
import '../../../domain/usecases/get_popular_tvs.dart';

part 'popular_tvs_event.dart';
part 'popular_tvs_state.dart';

class PopularTvsBloc extends Bloc<PopularTvsEvent, PopularTvsState> {
  final GetPopularTvs popularTvs;

  PopularTvsBloc({required this.popularTvs}) : super(PopularTvsEmpty()) {
    on<FetchPopularTvs>(((event, emit) async {
      emit(PopularTvsLoading());
      final result = await popularTvs.execute();
      result.fold(
        (failure) => emit(PopularTvsError(failure.message)),
        (tvs) => emit(PopularTvsHasData(tvs)),
      );
    }));
  }
}
