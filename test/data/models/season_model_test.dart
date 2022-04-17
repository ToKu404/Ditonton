import 'package:ditonton/data/models/season_model.dart';
import 'package:ditonton/domain/entities/season.dart';
import 'package:flutter_test/flutter_test.dart';


void main() {
  final tSeasonModel = SeasonModel(
    id: 2328126,
    seasonNumber: 1,
    name: "Season 1",
    posterPath: null,
  );

  final tSeason = Season(
    id: 2328126,
    seasonNumber: 1,
    name: "Season 1",
    posterPath: null,
  );

  test('should be SeasonModel Model subclass of Season Entity', () async {
    final result = tSeasonModel.toEntity();
    expect(result, tSeason);
  });
}
