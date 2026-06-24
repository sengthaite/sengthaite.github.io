import 'package:flutter/material.dart';

class AlignScrollContainer extends StatelessWidget {
  const AlignScrollContainer({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Container(
            width: 1920,
            height: 1080,
            padding: const EdgeInsets.only(top: 16.0),
            child: child,
          ),
        ),
      ),
    );
  }
}
