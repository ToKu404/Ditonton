import 'package:ditonton/main.dart' as app;
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  group('end to end test', () {
    testWidgets(
      'add movie to watchlist and verify it',
      ((widgetTester) async {
        app.main();
        await widgetTester.pumpAndSettle();

        final Finder movieCard = find.byKey(Key('movieCardKey')).first;
        await widgetTester.tap(movieCard);
        await widgetTester.pumpAndSettle();

        final Finder movieWatchlistBtn = find.byKey(Key('watchlistBtnKey'));
        await widgetTester.tap(movieWatchlistBtn);
        await widgetTester.pumpAndSettle();
        expect(find.byIcon(EvaIcons.checkmark), findsOneWidget);

        final Finder iconBack = find.byIcon(EvaIcons.arrowBack).first;
        await widgetTester.tap(iconBack);
        await widgetTester.pumpAndSettle();

        final Finder btnNavbar = find.text('Watchlist');
        await widgetTester.tap(btnNavbar);
        await widgetTester.pumpAndSettle();

        await widgetTester.tap(iconBack);
        await widgetTester.pumpAndSettle();
      }),
    );
  });
}
