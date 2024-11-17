import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:sengthaite_blog/constants/theme.dart';

class ApiFileManagerView extends StatelessWidget {
  const ApiFileManagerView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 350,
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: MaterialTheme.colorScheme(context).surfaceBright,
        borderRadius: BorderRadius.all(Radius.circular(8)),
        border: Border.all(
          color: MaterialTheme.colorScheme(context).onBackground,
          width: 0.4,
        ),
      ),
      child: Column(
        children: [
          Stack(
            children: [
              IconButton(
                onPressed: null,
                icon: Icon(MdiIcons.listBoxOutline),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 12),
                child: Center(
                  child: Text(
                    "Files",
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
          Divider(),
          SingleChildScrollView(
            child: Text("Empty"),
          )
        ],
      ),
    );
  }
}
