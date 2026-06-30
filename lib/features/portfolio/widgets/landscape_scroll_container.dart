import 'package:flutter/material.dart';

class LandscapeScrollContainer extends StatelessWidget {
  /// Widget: LandscapeScrollContainer to auto resize on web which can have dynamic size
  ///
  /// Scaledown width: 1920, 1080
  /// Boxfit.scaleDown
  const LandscapeScrollContainer({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: FittedBox(
        fit: BoxFit.scaleDown,
        child: Container(
          width: 1920,
          height: 1080,
          padding: const EdgeInsets.only(top: 16.0),
          child: child,
        ),
      ),
    );
  }
}
