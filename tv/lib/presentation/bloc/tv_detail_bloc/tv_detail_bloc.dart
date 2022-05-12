

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/tv.dart';
import '../../../domain/entities/tv_detail.dart';
import '../../../domain/usecases/get_tv_detail.dart';
import '../../../domain/usecases/get_tv_recommendations.dart';

part 'tv_detail_event.dart';
part 'tv_detail_state.dart';

class TvDetailBloc extends Bloc<TvDetailEvent, TvDetailState> {
  final GetTvDetail getTvDetail;
  final GetTvRecommendations getTvRecommendations;

  static const watchlistAddSuccessMessage = 'Added to Watchlist';
  static const watchlistRemoveSuccessMessage = 'Removed from Watchlist';

  TvDetailBloc({
    required this.getTvDetail,
    required this.getTvRecommendations,
  }) : super(TvDetailEmpty()) {
    on<FetchTvDetail>(
      (((event, emit) async {
        final id = event.id;
        emit(TvDetailLoading());
        final detailResult = await getTvDetail.execute(id);
        final recommendationResult = await getTvRecommendations.execute(id);

        detailResult.fold((failure) {
          emit(TvDetailError(failure.message));
        }, (tvDetail) {
          emit(TvDetailLoading());
          recommendationResult.fold(
            (failure) {
              emit(TvDetailError(failure.message));
            },
            (tvRecommendation) {
              emit(TvDetailHasData(tvDetail, tvRecommendation));
            },
          );
        });
      })),
    );
  }
}
