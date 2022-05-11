import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/tv.dart';
import '../../../domain/usecases/tv_usecase/get_on_the_air_tvs.dart';

part 'on_the_air_tvs_state.dart';
part 'on_the_air_tvs_event.dart';

class OnTheAirTvsBloc
    extends Bloc<OnTheAirTvsEvent, OnTheAirTvsState> {
  final GetOnTheAirTvs getOnTheAirTvs;

  OnTheAirTvsBloc({required this.getOnTheAirTvs})
      : super(OnTheAirTvEmpty()) {
    on<FetchOnTheAirTvs>(((event, emit) async {
      emit(OnTheAirTvLoading());
      final tvs = await getOnTheAirTvs.execute();

      tvs.fold(
        (failure) => emit(OnTheAirTvError(failure.message)),
        (tvs) => emit(OnTheAirTvHasData(tvs)),
      );
    }));
  }
}
