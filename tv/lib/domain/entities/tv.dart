import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class Tv extends Equatable {
  String? posterPath;
  int id;
  String? name;
  String? overview;

  Tv({
    required this.id,
    required this.posterPath,
    required this.name,
    required this.overview,
  });

  Tv.watchlist({
    required this.id,
    required this.overview,
    required this.posterPath,
    required this.name,
  });

  @override
  List<Object?> get props => [posterPath, id, name, overview];
}
