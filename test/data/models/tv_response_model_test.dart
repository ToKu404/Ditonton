import 'dart:convert';

import 'package:ditonton/data/models/tv_model.dart';
import 'package:ditonton/data/models/tv_response.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../json_reader.dart';

void main() {
  final tTvModel = TvModel(
      id: 31917,
      posterPath: "/vC324sdfcS313vh9QXwijLIHPJp.jpg",
      name: "Pretty Little Liars",
      overview: "Overview");

  final tTvResponseModel = TvResponse(tvList: <TvModel>[tTvModel]);

  group("fromJson", () {
    test('should return a valid model from Json', () async {
      //arrange
      final Map<String, dynamic> jsonMap =
          json.decode(readJson("dummy_data/on_the_air.json"));
      //act
      final result = TvResponse.fromJson(jsonMap);
      //assert
      expect(result, tTvResponseModel);
    });
  });

  group("toJson", () {
    test('should return a Json map containing proper data', () async {
      //arrange

      //act
      final result = tTvResponseModel.toJson();
      //assert
      final expectedJsonMap = {
        "results": [
          {
            "poster_path": "/vC324sdfcS313vh9QXwijLIHPJp.jpg",
            "id": 31917,
            "overview": "Overview",
            "name": "Pretty Little Liars",
          }
        ]
      };
      expect(result, expectedJsonMap);
    });
  });
}
