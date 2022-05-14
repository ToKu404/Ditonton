import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';
import 'package:tv/domain/entities/tv.dart';

import '../../../domain/usecases/search_tvs.dart';

part 'tv_search_event.dart';
part 'tv_search_state.dart';

EventTransformer<T> debounce<T>(Duration duration) {
  return (events, mapper) => events.debounceTime(duration).flatMap(mapper);
}

class TvSearchBloc extends Bloc<TvSearchEvent, TvSearchState> {
  final SearchTvs _searchTvs;

  TvSearchBloc(this._searchTvs) : super(TvSearchEmpty()) {
    on<OnQueryTvChanged>(
      ((event, emit) async {
        final query = event.query;

        emit(TvSearchLoading());
        final result = await _searchTvs.execute(query);

        result.fold(
          (failure) => emit(TvSearchError(failure.message)),
          (data) {
            emit(TvSearchHasData(data));
            if (data.isEmpty) {
              emit(TvSearchEmpty());
            }
          },
        );
      }),
      transformer: debounce(const Duration(milliseconds: 500)),
    );
  }
}
