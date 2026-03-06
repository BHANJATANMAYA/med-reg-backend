import 'package:flutter_test/flutter_test.dart';
import 'package:med_rag/main.dart';

void main() {
  testWidgets('App renders MedRAG splash screen', (WidgetTester tester) async {
    await tester.pumpWidget(const MedRagApp());
    // The splash screen should show the app name
    expect(find.text('MedRAG'), findsOneWidget);
  });
}
