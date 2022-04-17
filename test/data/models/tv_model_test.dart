import 'package:ditonton/data/models/tv_model.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final tTvModel = TvModel(
      id: 1, posterPath: "posterPath", name: "name", overview: "overview");

  final tTv =
      Tv(id: 1, posterPath: "posterPath", name: "name", overview: "overview");

  test('should be tv model a subclass of tv entity', () async {
    final result = tTvModel.toEntity();
    expect(result, tTv);
  });
}
