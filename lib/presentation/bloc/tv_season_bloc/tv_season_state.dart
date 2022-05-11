part of 'tv_season_bloc.dart';

abstract class TvSeasonState extends Equatable {
  @override
  List<Object> get props => [];
}

class TvSeasonEmpty extends TvSeasonState {}

class TvSeasonLoading extends TvSeasonState {}

class TvSeasonError extends TvSeasonState {
  final String messsage;

  TvSeasonError(this.messsage);

  @override
  List<Object> get props => [messsage];
}

class TvSeasonHasData extends TvSeasonState {
  final TvSeason tvSeason;

  TvSeasonHasData(this.tvSeason);

  @override
  List<Object> get props => [tvSeason];
}
