import 'package:flutter/material.dart';

class ZoomableContent extends StatelessWidget {
  /// Widget ZoomableContent : allow zoom to view bigger content
  ///
  /// Todo: implement in mobile view
  const ZoomableContent({super.key, required this.widget});

  final Widget widget;

  @override
  Widget build(BuildContext context) {
    return InteractiveViewer(
      // Allow or disallow panning across the zoomed image
      panEnabled: true,
      // Set boundary constraints for the content
      boundaryMargin: const EdgeInsets.all(20.0),
      // Set the minimum zoom scale limit
      minScale: 0.5,
      // Set the maximum zoom scale limit
      maxScale: 4.0,
      child: widget,
    );
  }
}
