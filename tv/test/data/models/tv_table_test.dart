import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:tv/data/models/tv_table.dart';
import 'package:tv/domain/entities/tv.dart';

import '../../json_reader.dart';

void main() {
  const tTvTableModel = TvTable(
    id: 1,
    name: "Pride",
    overview: "Overview",
    posterPath: "/9Ub2BwnLYKoiSaQF93ItyXriCon.jpg",
  );

  final tTvWatchlist = Tv.watchlist(
    id: 1,
    name: "Pride",
    overview: "Overview",
    posterPath: "/9Ub2BwnLYKoiSaQF93ItyXriCon.jpg",
  );

   group("toEntity", () {
    test('should be TvTable Model subclass of Tv watchlist Entity', () async {
      final result = tTvTableModel.toEntity();
      expect(result, tTvWatchlist);
    });
  });

  group('fromMap', () {
    test('should return a valid model from JSON', () async {
      // arrange
      final Map<String, dynamic> jsonMap =
          json.decode(readJson('dummy_data/tv_table.json'));
      // act
      final result = TvTable.fromMap(jsonMap);
      // assert
      expect(result, tTvTableModel);
    });
  });

  group('toJson', () {
    test('should return a JSON map containing proper data', () async {
      final result = tTvTableModel.toJson();

      final expectedJsonMap = {
        "id": 1,
        "name": "Pride",
        "overview": "Overview",
        "posterPath": "/9Ub2BwnLYKoiSaQF93ItyXriCon.jpg",
      };
      expect(result, expectedJsonMap);
    });
  });
}
