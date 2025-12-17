import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_zoom_meeting_sdk_example/main.dart';

void main() {
  testWidgets('App builds successfully', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());
    expect(find.text('Zoom Meeting SDK Example'), findsOneWidget);
  });
}

