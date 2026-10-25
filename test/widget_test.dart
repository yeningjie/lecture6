import 'package:flutter_test/flutter_test.dart';
import 'package:profile_card/main.dart';

void main() {
  testWidgets('演示目录正常渲染', (tester) async {
    await tester.pumpWidget(const ProfileCardApp());

    expect(find.text('第 8 周 · 基础组件与布局'), findsOneWidget);
    expect(find.text('个人名片（课堂案例）'), findsOneWidget);
    expect(find.text('对齐任务卡（六种场景）'), findsOneWidget);
  });

  testWidgets('可以从演示目录进入个人名片页', (tester) async {
    await tester.pumpWidget(const ProfileCardApp());

    await tester.tap(find.text('个人名片（课堂案例）'));
    await tester.pumpAndSettle();

    expect(find.text('林小满'), findsOneWidget);
    expect(find.text('128'), findsOneWidget);
    expect(find.text('Flutter'), findsOneWidget);
  });
}
