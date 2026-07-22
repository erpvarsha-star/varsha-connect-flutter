import 'package:flutter_test/flutter_test.dart';
import 'package:varsha_connect/src/app.dart';

void main() {
  testWidgets('shows Varsha Connect login screen', (tester) async {
    await tester.pumpWidget(const VarshaConnectApp());

    expect(find.text('Varsha Connect'), findsOneWidget);
    expect(find.text('VARSHA FORGINGS PVT LTD · AURANGABAD'), findsOneWidget);
  });
}
