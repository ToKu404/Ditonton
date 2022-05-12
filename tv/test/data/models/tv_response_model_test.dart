import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:tv/data/models/tv_response.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../json_reader.dart';

void main() {

  group("fromJson", () {
    test('should return a valid model from Json', () async {
      //arrange
      final Map<String, dynamic> jsonMap =
          json.decode(readJson("dummy_data/on_the_air.json"));
      //act
      final result = TvResponse.fromJson(jsonMap);
      //assert
      expect(result, testTvResponseModel);
    });
  });

  group("toJson", () {
    test('should return a Json map containing proper data', () async {
      //arrange

      //act
      final result = testTvResponseModel.toJson();
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
