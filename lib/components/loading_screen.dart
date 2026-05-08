import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:sengthaite_blog/constants/theme.dart';

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
        color: MaterialTheme.colorScheme(context).onSurface,
        size: 30.0,
      ),
    );
  }
}