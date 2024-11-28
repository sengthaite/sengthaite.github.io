import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:sengthaite_blog/constants/theme.dart';
import 'package:sengthaite_blog/extensions/http_ext.dart';
import 'package:sengthaite_blog/extensions/string_ext.dart';
import 'package:sengthaite_blog/shared/file/hivedir.dart';
import 'package:sengthaite_blog/shared/file/hivehelper.dart';

import 'api_request_builder.dart';

class ApiFileManagerView extends StatefulWidget {
  const ApiFileManagerView({
    super.key,
    required this.requestBuilder,
  });

  final HttpRequestBuilder requestBuilder;

  @override
  State<ApiFileManagerView> createState() => _ApiFileManagerViewState();
}

class _ApiFileManagerViewState extends State<ApiFileManagerView> {
  final service = HiveAPIDirService();
  bool isEditing = false;
  bool selectedAll = false;
  Map<String, bool> selectedFilename = {};
  TempDir? defaultDir;
  APIFileWidget? selectedRow;

  _init() async {
    await service.init();
    defaultDir = await service.defaultDir;
    defaultDir!.onFileListChange = () {
      setState(() {});
    };
  }

  @override
  void initState() {
    super.initState();
    _init();
  }

  @override
  Widget build(BuildContext context) {
    var fileList = defaultDir?.fileList ?? [];
    bool isEmpty = fileList.isEmpty;
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
                      IconButton(
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (context) => APIFileCreationWidget(
                                defaultDir: defaultDir,
                              ),
                            );
                          },
                          icon: Icon(MdiIcons.plus)),
                      TextButton(
                        onPressed: fileList.isNotEmpty
                            ? () {
                                setState(() {
                                  selectedAll = false;
                                  selectedFilename.clear();
                                  isEditing = !isEditing;
                                });
                              }
                            : null,
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
            Row(
              children: [
                TextButton.icon(
                  onPressed: isEditing && fileList.isNotEmpty
                      ? () {
                          setState(() {
                            selectedAll = !selectedAll;
                            if (!selectedAll) {
                              selectedFilename.clear();
                            } else {
                              for (var file in fileList) {
                                selectedFilename[file.filename] = true;
                              }
                            }
                          });
                        }
                      : null,
                  label: Text("Select all"),
                  icon: Icon(MdiIcons.checkAll),
                ),
                TextButton.icon(
                  onPressed: isEmpty
                      ? null
                      : () {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: Text(
                                    "Are you sure, you want to clear all?",
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () =>
                                          Navigator.of(context).pop(),
                                      child: Text("Cancel",
                                          style: TextStyle(
                                            color: MaterialTheme.colorScheme(
                                                    context)
                                                .secondary,
                                          )),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        setState(() {
                                          selectedAll = false;
                                          selectedFilename.clear();
                                          defaultDir?.clean();
                                        });
                                        widget.requestBuilder.reset();
                                        Navigator.of(context).pop();
                                      },
                                      child: Text(
                                        "Confirm",
                                        style: TextStyle(
                                          color:
                                              MaterialTheme.colorScheme(context)
                                                  .error,
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              });
                        },
                  label: Text("Clear"),
                  icon: Icon(MdiIcons.deleteEmpty),
                )
              ],
            ),
            Divider(),
            Expanded(
              child: SingleChildScrollView(
                child: isEmpty
                    ? EmptyDirWidget()
                    : Column(
                        children: [
                          // ...List.generate(dirList.length, (index) {
                          //   var eachDir = dirList[index];
                          //   return Padding(
                          //     padding: const EdgeInsets.only(top: 8),
                          //     child: Container(
                          //       decoration: BoxDecoration(
                          //         border: Border.all(
                          //           color: MaterialTheme.colorScheme(context)
                          //               .outline,
                          //         ),
                          //         color: MaterialTheme.colorScheme(context)
                          //             .background,
                          //         borderRadius: BorderRadius.circular(4),
                          //       ),
                          //       child: DirectoryWidget(dir: eachDir),
                          //     ),
                          //   );
                          // }),
                          ...List.generate(fileList.length, (index) {
                            var eachFile = fileList[index];
                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 8, horizontal: 12),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  if (isEditing)
                                    Checkbox(
                                      value:
                                          selectedFilename[eachFile.filename] ??
                                              false,
                                      onChanged: (value) {
                                        setState(() {
                                          selectedFilename[eachFile.filename] =
                                              value ?? false;
                                          var selectedFileLength =
                                              selectedFilename.keys
                                                  .where(
                                                      (e) =>
                                                          selectedFilename[e] ??
                                                          false)
                                                  .length;
                                          selectedAll = selectedFileLength ==
                                                  fileList.length &&
                                              selectedFilename.isNotEmpty;
                                        });
                                      },
                                    ),
                                  Expanded(
                                      child: APIFileWidget(
                                          file: eachFile,
                                          onTap: (rowWidget) {
                                            rowWidget.isSelected.value = true;
                                            selectedRow?.isSelected.value =
                                                false;
                                            var isDeselected =
                                                selectedRow == rowWidget;

                                            if (isDeselected) {
                                              selectedRow = null;
                                              widget.requestBuilder.reset();
                                            } else {
                                              selectedRow = rowWidget;
                                              widget.requestBuilder
                                                  .autopopulateData = eachFile;
                                            }
                                          })),
                                ],
                              ),
                            );
                          }),
                          SizedBox(height: 4),
                        ],
                      ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class APIFileCreationWidget extends StatefulWidget {
  const APIFileCreationWidget({
    super.key,
    required this.defaultDir,
  });

  final TempDir? defaultDir;

  @override
  State<APIFileCreationWidget> createState() => _APIFileCreationWidgetState();
}

class _APIFileCreationWidgetState extends State<APIFileCreationWidget> {
  TextEditingController fileNameController = TextEditingController();
  TextEditingController urlInputController = TextEditingController();
  String requestMethod = HttpRequestMethodTypeExtension.defaultHttpMethod;
  Color? methodColor = HttpRequestMethodTypeExtension.methodByDisplay(
          HttpRequestMethodTypeExtension.defaultHttpMethod)
      ?.color;
  bool canSave = false;

  checkCanSave() => setState(() {
        var urlInputText = urlInputController.text;
        canSave = fileNameController.text.isNotEmpty && urlInputText.isUrl;
      });

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
                autofocus: true,
                textInputAction: TextInputAction.done,
                style: const TextStyle(fontSize: 14),
                controller: fileNameController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Name",
                  labelText: "Name",
                ),
                onChanged: (value) => checkCanSave(),
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
                  initialSelection: requestMethod,
                  requestFocusOnTap: false,
                  dropdownMenuEntries:
                      HttpRequestMethodTypeExtension.listRequestMethods
                          .map(
                            (e) => DropdownMenuEntry(value: e, label: e),
                          )
                          .toList(),
                  onSelected: (value) {
                    if (value == null) return;
                    requestMethod = value;
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
                    controller: urlInputController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "URL",
                      labelText: "URL",
                    ),
                    onChanged: (value) => checkCanSave(),
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
                  onPressed: !canSave
                      ? null
                      : () {
                          setState(() {
                            widget.defaultDir?.addNewFile(
                              fileNameController.text,
                              TempFile(
                                url: urlInputController.text,
                                requestMethod: requestMethod,
                                filename: fileNameController.text,
                              ),
                            );
                          });
                          Navigator.of(context).pop();
                        },
                  child: Text(
                    "Save",
                    style: TextStyle(fontWeight: FontWeight.w500),
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
  APIFileWidget({
    super.key,
    required this.file,
    this.onTap,
  });

  final TempFile file;
  final void Function(APIFileWidget)? onTap;

  final ValueNotifier<bool> isSelected = ValueNotifier(false);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap != null ? () => onTap!(this) : null,
      child: ValueListenableBuilder(
        valueListenable: isSelected,
        builder: (context, isSelected, child) => Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              width: isSelected ? 2 : 1,
              color: isSelected
                  ? MaterialTheme.colorScheme(context).primary
                  : MaterialTheme.colorScheme(context).outline,
            ),
            color: MaterialTheme.colorScheme(context).background,
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Icon(MdiIcons.api,
                    color: MaterialTheme.colorScheme(context).surfaceTint),
                SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      file.filename,
                      style: TextStyle(
                        color:
                            MaterialTheme.colorScheme(context).inverseSurface,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      file.url,
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
                TextButton(
                    onPressed: null,
                    child: Text(
                      file.requestMethod.toUpperCase(),
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: HttpRequestMethodTypeExtension.methodByDisplay(
                                  file.requestMethod)
                              ?.color),
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class DirectoryWidget extends StatelessWidget {
  const DirectoryWidget({
    super.key,
    required this.dir,
  });

  final TempDir dir;

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
          Text(dir.dirname),
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
