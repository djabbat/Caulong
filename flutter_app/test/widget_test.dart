import 'package:flutter_test/flutter_test.dart';
import 'package:caulong_flutter/main.dart';

void main() {
  testWidgets('Smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const AuthWrapper());

    expect(find.text('Привет, MyApp!'), findsOneWidget);
  });
}