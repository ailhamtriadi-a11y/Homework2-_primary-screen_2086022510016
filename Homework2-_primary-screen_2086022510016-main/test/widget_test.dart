import 'package:flutter_test/flutter_test.dart';

import 'package:homework2_primary_screen/main.dart';

void main() {
  testWidgets('Marketplace app loads the primary screen UI', (tester) async {
    await tester.pumpWidget(const MyApp());

    expect(find.text('Art Marketplace'), findsOneWidget);
    expect(find.textContaining('Featured Art Works'), findsOneWidget);
    expect(find.text('Patung Keramik Custom'), findsOneWidget);
    expect(find.text('Search artwork or artist...'), findsOneWidget);
  });
}
