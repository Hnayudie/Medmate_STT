import 'package:flutter_test/flutter_test.dart';

import 'package:medmate_stt/src/app.dart';

void main() {
  testWidgets('MedMateApp smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const MedMateApp());
  });
}
