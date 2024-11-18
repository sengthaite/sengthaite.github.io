import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:sengthaite_blog/constants/theme.dart';
import 'package:sengthaite_blog/shared/file/hivedir.dart';
import 'package:sengthaite_blog/shared/file/hivehelper.dart';

class ApiFileManagerView extends StatefulWidget {
  const ApiFileManagerView({super.key});

  @override
  State<ApiFileManagerView> createState() => _ApiFileManagerViewState();
}

class _ApiFileManagerViewState extends State<ApiFileManagerView> {
  final service = HiveAPIDirService();
  bool isEditing = false;
  TempDir? defaultDir;

  _init() async {
    await service.init();
    defaultDir = await service.defaultDir;
  }

  @override
  void initState() {
    super.initState();
    _init();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(maxWidth: 350),
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
                padding: const EdgeInsets.only(top: 10),
                child: Center(
                  child: Text(
                    "Files",
                    style: TextStyle(fontSize: 18),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    PopupMenuButton(
                      // child: Text("Add"),
                      icon: Icon(MdiIcons.plus),
                      tooltip: "Add",
                      itemBuilder: (BuildContext context) => [
                        PopupMenuItem(
                          value: "add_file",
                          child: Text("New API"),
                        ),
                        PopupMenuItem(
                          value: "add_dir",
                          child: Text("New Dir"),
                        ),
                      ],
                    ),
                    TextButton(
                      onPressed: () {
                        setState(() {
                          isEditing = !isEditing;
                        });
                      },
                      child: Text(
                        isEditing ? "Cancel" : "Edit",
                        style: TextStyle(
                          color: isEditing
                              ? MaterialTheme.colorScheme(context).error
                              : MaterialTheme.colorScheme(context).secondary,
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
          Divider(),
          SingleChildScrollView(
            child: Padding(
                padding: EdgeInsets.only(top: 64),
                child: Text(
                  "Empty",
                  textAlign: TextAlign.center,
                )),
          )
        ],
      ),
    );
  }
}
