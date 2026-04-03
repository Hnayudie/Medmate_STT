import 'package:flutter_test/flutter_test.dart';

import 'package:medmate_stt/app/app.dart';

void main() {
  testWidgets('MedMateApp smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const MedMateApp());
  });
}
