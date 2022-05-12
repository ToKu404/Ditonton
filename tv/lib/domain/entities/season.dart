import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class Season extends Equatable {
  int id;
  int seasonNumber;
  String name;
  int episodeCount;
  String? airDate;

  Season({
    required this.id,
    required this.seasonNumber,
    required this.name,
    required this.episodeCount,
    required this.airDate
  });

  @override
  List<Object?> get props => [
        id,
        seasonNumber,
        name,
        episodeCount,
        airDate
      ];
}
