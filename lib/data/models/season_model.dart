import 'package:ditonton/domain/entities/season.dart';
import 'package:equatable/equatable.dart';

class SeasonModel extends Equatable {
  final int id;
  final int seasonNumber;
  final String name;
  final String? posterPath;

  SeasonModel(
      {required this.id,
      required this.seasonNumber,
      required this.name,
      required this.posterPath});

  factory SeasonModel.fromJson(Map<String, dynamic> json) => SeasonModel(
      id: json["id"],
      seasonNumber: json["season_number"],
      name: json["name"],
      posterPath: json["poster_path"]);

  Map<String, dynamic> toJson() => {
        "id": id,
        "season_number": seasonNumber,
        "name": name,
        "poster_path": posterPath,
      };

  Season toEntity() {
    return Season(
        id: this.id,
        seasonNumber: this.seasonNumber,
        name: this.name,
        posterPath: this.posterPath);
  }

  @override
  List<Object?> get props => [id, seasonNumber, name, posterPath];
}
