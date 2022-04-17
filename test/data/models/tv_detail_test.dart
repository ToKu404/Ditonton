import 'dart:convert';

import 'package:ditonton/data/models/genre_model.dart';
import 'package:ditonton/data/models/season_model.dart';
import 'package:ditonton/data/models/tv_detail_model.dart';
import 'package:ditonton/domain/entities/genre.dart';
import 'package:ditonton/domain/entities/season.dart';
import 'package:ditonton/domain/entities/tv_detail.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../json_reader.dart';

void main() {
  final tTvDetailModel = TvDetailResponse(
      backdropPath: "/54CU1a2Wod9RCSVQ9BT0nUw5Enr.jpg",
      firstAirDate: "2004-01-12",
      genres: [GenreModel(id: 18, name: "Drama")],
      id: 1,
      name: "Pride",
      numberOfSeasons: 1,
      overview: "Overview",
      posterPath: "/9Ub2BwnLYKoiSaQF93ItyXriCon.jpg",
      seasons: [
        SeasonModel(
            id: 2328126, seasonNumber: 1, name: "Season 1", posterPath: null)
      ],
      voteAverage: 8.5,
      voteCount: 10);

  final tTvDetail = TvDetail(
      backdropPath: "/54CU1a2Wod9RCSVQ9BT0nUw5Enr.jpg",
      firstAirDate: "2004-01-12",
      genres: [Genre(id: 18, name: "Drama")],
      id: 1,
      name: "Pride",
      numberOfSeasons: 1,
      overview: "Overview",
      posterPath: "/9Ub2BwnLYKoiSaQF93ItyXriCon.jpg",
      seasons: [
        Season(id: 2328126, seasonNumber: 1, name: "Season 1", posterPath: null)
      ],
      voteAverage: 8.5,
      voteCount: 10);

  group("toEntity", () {
    test('should be TvDetail Model subclass of TvDetail Entity', () async {
      final result = tTvDetailModel.toEntity();
      expect(result, tTvDetail);
    });
  });

  group('fromJson', () {
    test('should return a valid model from JSON', () async {
      // arrange
      final Map<String, dynamic> jsonMap =
          json.decode(readJson('dummy_data/tv_detail.json'));
      // act
      final result = TvDetailResponse.fromJson(jsonMap);
      // assert
      expect(result, tTvDetailModel);
    });
  });

  group('toJson', () {
    test('should return a JSON map containing proper data', () async {
      final result = tTvDetailModel.toJson();

      final expectedJsonMap = {
        "backdrop_path": "/54CU1a2Wod9RCSVQ9BT0nUw5Enr.jpg",
        "first_air_date": "2004-01-12",
        "genres": [
          {"id": 18, "name": "Drama"}
        ],
        "id": 1,
        "name": "Pride",
        "number_of_seasons": 1,
        "overview": "Overview",
        "poster_path": "/9Ub2BwnLYKoiSaQF93ItyXriCon.jpg",
        "seasons": [
          {
            "id": 2328126,
            "name": "Season 1",
            "poster_path": null,
            "season_number": 1
          }
        ],
        "vote_average": 8.5,
        "vote_count": 10
      };
      expect(result, expectedJsonMap);
    });
  });
}
