import 'package:flutter_test/flutter_test.dart';
import 'package:profile_card/main.dart';

void main() {
  testWidgets('个人名片页正常渲染', (tester) async {
    await tester.pumpWidget(const ProfileCardApp());

    expect(find.text('林小满'), findsOneWidget);
    expect(find.text('128'), findsOneWidget);
    expect(find.text('Flutter'), findsOneWidget);
  });
}
