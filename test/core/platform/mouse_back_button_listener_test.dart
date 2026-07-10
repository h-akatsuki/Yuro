import 'package:asmrapp/core/platform/mouse_back_button_listener.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('invokes the back action for a mouse back button press', (
    tester,
  ) async {
    var backPressCount = 0;

    await tester.pumpWidget(
      MouseBackButtonListener(
        onBackPressed: () => backPressCount++,
        child: const ColoredBox(color: Colors.white),
      ),
    );

    final pointer = TestPointer(
      1,
      PointerDeviceKind.mouse,
      1,
      kBackMouseButton,
    );
    await tester.sendEventToBinding(pointer.down(const Offset(10, 10)));

    expect(backPressCount, 1);
  });

  testWidgets('ignores primary clicks and non-mouse back button presses', (
    tester,
  ) async {
    var backPressCount = 0;

    await tester.pumpWidget(
      MouseBackButtonListener(
        onBackPressed: () => backPressCount++,
        child: const ColoredBox(color: Colors.white),
      ),
    );

    final mousePointer = TestPointer(1, PointerDeviceKind.mouse);
    await tester.sendEventToBinding(mousePointer.down(const Offset(10, 10)));

    final touchPointer = TestPointer(
      2,
      PointerDeviceKind.touch,
      2,
      kBackMouseButton,
    );
    await tester.sendEventToBinding(touchPointer.down(const Offset(10, 10)));

    expect(backPressCount, 0);
  });

  testWidgets('can pop the root navigator', (tester) async {
    final navigatorKey = GlobalKey<NavigatorState>();

    await tester.pumpWidget(
      MaterialApp(
        navigatorKey: navigatorKey,
        builder: (context, child) => MouseBackButtonListener(
          onBackPressed: () => navigatorKey.currentState?.maybePop(),
          child: child!,
        ),
        home: Builder(
          builder: (context) => Scaffold(
            body: TextButton(
              onPressed: () {
                Navigator.push<void>(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const Scaffold(body: Text('second page')),
                  ),
                );
              },
              child: const Text('open second page'),
            ),
          ),
        ),
      ),
    );

    await tester.tap(find.text('open second page'));
    await tester.pumpAndSettle();
    expect(find.text('second page'), findsOneWidget);

    final pointer = TestPointer(
      3,
      PointerDeviceKind.mouse,
      3,
      kBackMouseButton,
    );
    await tester.sendEventToBinding(pointer.down(const Offset(10, 10)));
    await tester.pumpAndSettle();

    expect(find.text('open second page'), findsOneWidget);
    expect(find.text('second page'), findsNothing);
  });
}
