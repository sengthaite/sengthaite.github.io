import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.sizeOf(context).width;
    var height = MediaQuery.sizeOf(context).height;
    return Container(
      color: Colors.black12,
      width: width,
      height: height,
      child: SpinKitFadingCircle(
        color: Theme.of(context).colorScheme.onSurface,
        size: 30.0,
      ),
    );
  }
}
