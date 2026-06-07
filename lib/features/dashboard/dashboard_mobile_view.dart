import 'package:flutter/material.dart';
import 'package:sengthaite_blog/constants/image.constants.dart';

class DashboardMobileView extends StatefulWidget {
  const DashboardMobileView({super.key});

  @override
  State<DashboardMobileView> createState() => _DashboardMobileViewState();
}

class _DashboardMobileViewState extends State<DashboardMobileView> {
  @override
  Widget build(BuildContext context) {
    return WidgetsApp(
      color: Colors.white,
      debugShowCheckedModeBanner: false,
      title: "Portfolio",
      onGenerateRoute: (settings) {
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => HomeScreen(),
        );
      },
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: Color(0xFFF5F5F5),
      child: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset("hand.jpg", fit: BoxFit.fitHeight),
          SafeArea(
            child: Column(
              children: [
                Text("Title"),
                Container(),
                Spacer(),
                DockTabNavView(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class DockTabNavView extends StatefulWidget {
  const DockTabNavView({super.key});

  @override
  State<DockTabNavView> createState() => _DockTabNavViewState();
}

class _DockTabNavViewState extends State<DockTabNavView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(4.0),
      constraints: BoxConstraints(maxWidth: 370),
      decoration: BoxDecoration(
        color: Colors.white,
        gradient: LinearGradient(colors: [Colors.red, Colors.blue]),
        border: Border.all(
          width: 0.5,
          color: Theme.of(context).colorScheme.onSurface,
        ),
        borderRadius: BorderRadius.all(Radius.circular(36)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          SizedBox(
            width: 70,
            height: 70,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [AssetIcons.flutter.imageWithSize(30), Text("Flutter")],
            ),
          ),
          Container(
            width: 70,
            height: 70,
            decoration: BoxDecoration(
              border: Border.all(width: 0.1, color: Colors.black26),
              borderRadius: BorderRadius.all(Radius.circular(8.0)),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [AssetIcons.flutter.imageWithSize(30), Text("Flutter")],
            ),
          ),
        ],
      ),
    );
  }
}
