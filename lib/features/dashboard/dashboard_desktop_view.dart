import 'package:flutter/material.dart';

class DashboardDesktopView extends StatefulWidget {
  const DashboardDesktopView({super.key});

  @override
  State<DashboardDesktopView> createState() => _DashboardDesktopViewState();
}

class _DashboardDesktopViewState extends State<DashboardDesktopView> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(width: 200, color: Colors.red),
            Container(color: Colors.blue),
          ],
        ),
      ),
    );
  }
}
