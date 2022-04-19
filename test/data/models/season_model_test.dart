import 'package:ditonton/data/models/season_model.dart';
import 'package:ditonton/domain/entities/season.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final tSeasonModel = SeasonModel(
      id: 2328126,
      seasonNumber: 1,
      name: "Season 1",
      airDate: "2012-10-12",
      episodeCount: 12);

  final tSeason = Season(
      id: 2328126,
      seasonNumber: 1,
      name: "Season 1",
      airDate: "2012-10-12",
      episodeCount: 12);

  test('should be SeasonModel Model subclass of Season Entity', () async {
    final result = tSeasonModel.toEntity();
    expect(result, tSeason);
  });
}
