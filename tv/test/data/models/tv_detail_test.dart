import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:tv/data/models/tv_detail_model.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../json_reader.dart';

void main() {
  group("toEntity", () {
    test('should be TvDetail Model subclass of TvDetail Entity', () async {
      final result = testTvDetailModel.toEntity();
      expect(result, testTvDetail);
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
      expect(result, testTvDetailModel);
    });
  });

  group('toJson', () {
    test('should return a JSON map containing proper data', () async {
      final result = testTvDetailModel.toJson();

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
            "season_number": 1,
            'air_date': '2012-10-12',
            'episode_count': 12
          }
        ],
        "vote_average": 8.5,
        "vote_count": 10
      };
      expect(result, expectedJsonMap);
    });
  });
}
