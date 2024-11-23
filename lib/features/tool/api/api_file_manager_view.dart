import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:sengthaite_blog/constants/theme.dart';
import 'package:sengthaite_blog/extensions/http_ext.dart';
import 'package:sengthaite_blog/shared/file/hivedir.dart';
import 'package:sengthaite_blog/shared/file/hivehelper.dart';

import 'api_request_builder.dart';

class ApiFileManagerView extends StatefulWidget {
  const ApiFileManagerView({super.key, required this.requestBuilder});

  final HttpRequestBuilder requestBuilder;

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

  get isEmpty => defaultDir?.dirList.isEmpty ?? true;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
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
                  padding: const EdgeInsets.only(top: 4),
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
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder: (context) => APIFileCreationWidget(
                                      requestBuilder: widget.requestBuilder),
                                );
                              }),
                          PopupMenuItem(
                            value: "add_dir",
                            child: Text("New Dir"),
                          ),
                        ],
                      ),
                      TextButton(
                        onPressed: () {
                          setState(() => isEditing = !isEditing);
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
              child: false
                  ? EmptyDirWidget()
                  : Column(
                      children: List.generate(1, (index) {
                        return Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: MaterialTheme.colorScheme(context).outline,
                            ),
                            color:
                                MaterialTheme.colorScheme(context).background,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: APIFileWidget(),
                        );
                      }),
                    ),
            )
          ],
        ),
      ),
    );
  }
}

class APIFileCreationWidget extends StatefulWidget {
  const APIFileCreationWidget({super.key, required this.requestBuilder});

  final HttpRequestBuilder requestBuilder;

  @override
  State<APIFileCreationWidget> createState() => _APIFileCreationWidgetState();
}

class _APIFileCreationWidgetState extends State<APIFileCreationWidget> {
  TextEditingController fileNameController = TextEditingController();
  Color? methodColor = HttpRequestMethodTypeExtension.methodByDisplay(
          HttpRequestMethodTypeExtension.defaultHttpMethod)
      ?.color;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        "Create",
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
      ),
      content: Container(
        width: 500,
        padding: EdgeInsets.symmetric(vertical: 12, horizontal: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: 485,
              child: TextFormField(
                textInputAction: TextInputAction.done,
                style: const TextStyle(fontSize: 14),
                controller: fileNameController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Input name",
                  labelText: "Input name",
                ),
              ),
            ),
            SizedBox(height: 8),
            Row(
              children: [
                DropdownMenu(
                  textStyle: TextStyle(
                      fontSize: 14,
                      color: methodColor,
                      fontWeight: FontWeight.bold),
                  initialSelection: widget.requestBuilder.requestMethod ??
                      HttpRequestMethodTypeExtension.defaultHttpMethod,
                  requestFocusOnTap: false,
                  dropdownMenuEntries:
                      HttpRequestMethodTypeExtension.listRequestMethods
                          .map(
                            (e) => DropdownMenuEntry(value: e, label: e),
                          )
                          .toList(),
                  onSelected: (value) {
                    if (value == null) return;
                    widget.requestBuilder.requestMethod = value;
                    setState(() {
                      methodColor =
                          HttpRequestMethodTypeExtension.methodByDisplay(value)
                              ?.color;
                    });
                  },
                ),
                Spacer(),
                SizedBox(
                  width: 330,
                  child: TextFormField(
                    textInputAction: TextInputAction.done,
                    style: const TextStyle(fontSize: 14),
                    controller: widget.requestBuilder.urlInputController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "URL",
                      labelText: "URL",
                    ),
                    onFieldSubmitted: (value) {
                      value.isNotEmpty ? widget.requestBuilder.request() : null;
                    },
                  ),
                ),
              ],
            ),
            Divider(),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Spacer(),
                TextButton(
                  onPressed: Navigator.of(context).pop,
                  child: Text(
                    "Cancel",
                    style: TextStyle(
                        color: MaterialTheme.colorScheme(context).error,
                        fontWeight: FontWeight.w500),
                  ),
                ),
                TextButton(
                  onPressed: null,
                  child: Text(
                    "Save",
                    style: TextStyle(
                        color: MaterialTheme.colorScheme(context).primary,
                        fontWeight: FontWeight.w500),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class APIFileWidget extends StatelessWidget {
  const APIFileWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(children: [
            Icon(MdiIcons.api,
                color: MaterialTheme.colorScheme(context).surfaceTint),
            SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "API",
                  style: TextStyle(
                    color: MaterialTheme.colorScheme(context).inverseSurface,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  "https://www.google.com",
                  style: TextStyle(
                    color: MaterialTheme.colorScheme(context).secondary,
                    fontSize: 14,
                    fontWeight: FontWeight.normal,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
            Spacer(),
            TextButton(onPressed: null, child: Text("GET"))
          ]),
        ),
      ),
    );
  }
}

class DirectoryWidget extends StatelessWidget {
  const DirectoryWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(children: [
          Icon(
            MdiIcons.folder,
            color: MaterialTheme.colorScheme(context).tertiary,
          ),
          SizedBox(width: 12),
          Text("Dir"),
        ]),
      ),
    );
  }
}

class EmptyDirWidget extends StatelessWidget {
  const EmptyDirWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 64),
      child: Text(
        "Empty",
        textAlign: TextAlign.center,
      ),
    );
  }
}
