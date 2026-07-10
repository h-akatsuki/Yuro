import 'package:flutter/gestures.dart';
import 'package:flutter/widgets.dart';

/// Converts a mouse's back side button into an application back action.
class MouseBackButtonListener extends StatelessWidget {
  const MouseBackButtonListener({
    super.key,
    required this.onBackPressed,
    required this.child,
  });

  final VoidCallback onBackPressed;
  final Widget child;

  void _handlePointerDown(PointerDownEvent event) {
    if (event.kind == PointerDeviceKind.mouse &&
        event.buttons & kBackMouseButton != 0) {
      onBackPressed();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Listener(
      behavior: HitTestBehavior.translucent,
      onPointerDown: _handlePointerDown,
      child: child,
    );
  }
}
