import 'package:dart_eval/dart_eval.dart';
import 'package:flutter/material.dart';
import 'package:flutter_code_editor/flutter_code_editor.dart';
import 'package:flutter_highlight/themes/github.dart';
import 'package:highlight/languages/dart.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:sengthaite_blog/features/tool/api/api_functions/config/code_snippets.dart';
import 'package:sengthaite_blog/features/tool/api/api_request_builder.dart';

class APIFuncView extends StatefulWidget {
  const APIFuncView({super.key});

  @override
  State<APIFuncView> createState() => _APIFuncViewState();
}

class _APIFuncViewState extends State<APIFuncView> {
  var currentRequest = HttpRequestBuilder.getInstance().selectedDatum;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        child: Table(
            defaultVerticalAlignment: TableCellVerticalAlignment.middle,
            columnWidths: const {
              0: FixedColumnWidth(40),
              4: FixedColumnWidth(120),
              5: FixedColumnWidth(40),
            },
            border: TableBorder.all(
              borderRadius: const BorderRadius.all(
                Radius.circular(4),
              ),
            ),
            children: [
              TableRow(children: [
                Checkbox(
                  value: currentRequest?.selectedAllFunc,
                  onChanged: (value) {
                    currentRequest?.toggleFuncAllRow();
                    setState(() {
                      currentRequest?.selectedAllFunc = value;
                    });
                  },
                ),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text("Function",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontWeight: FontWeight.bold)),
                ),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text("Arguments",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontWeight: FontWeight.bold)),
                ),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text("Description",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontWeight: FontWeight.bold)),
                ),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text("Execute",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontWeight: FontWeight.bold)),
                ),
                IconButton(
                  splashColor: Colors.transparent,
                  color: Colors.transparent,
                  highlightColor: Colors.transparent,
                  focusColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  onPressed: () {
                    setState(() {
                      currentRequest?.addFunc(APIRowData());
                    });
                  },
                  icon: Icon(
                    MdiIcons.plus,
                    color: Colors.green,
                  ),
                ),
              ]),
              ...List.generate(currentRequest?.functionControllers.length ?? 0,
                  (index) {
                var dataRow = currentRequest?.functionControllers[index];
                return TableRow(
                  children: [
                    Checkbox(
                      value: dataRow?.isSelected,
                      onChanged: (value) => setState(
                        () => currentRequest?.toggleFuncRowSelectionAt(index),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        style: const TextStyle(
                            fontSize: 12, fontWeight: FontWeight.bold),
                        enableSuggestions: false,
                        maxLines: null,
                        keyboardType: TextInputType.multiline,
                        decoration: const InputDecoration(
                          hintText: "Function Name",
                          border: InputBorder.none,
                        ),
                        controller: dataRow?.keyController,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextButton(
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return APIFuncDefinitionView(dataRow: dataRow);
                              });
                        },
                        child: Text("Edit Function"),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        style: const TextStyle(fontSize: 12),
                        enableSuggestions: false,
                        maxLines: null,
                        keyboardType: TextInputType.multiline,
                        decoration: const InputDecoration(
                          hintText: "Description",
                          border: InputBorder.none,
                        ),
                        controller: dataRow?.descriptionController,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: IconButton(
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return APIFuncViewResult(dataRow: dataRow);
                              });
                        },
                        icon: Icon(MdiIcons.play),
                        color: Colors.green,
                      ),
                    ),
                    (dataRow?.allowDeletion ?? false)
                        ? IconButton(
                            splashColor: Colors.transparent,
                            color: Colors.transparent,
                            highlightColor: Colors.transparent,
                            focusColor: Colors.transparent,
                            hoverColor: Colors.transparent,
                            icon: const Icon(
                              Icons.delete,
                              color: Colors.red,
                            ),
                            onPressed: () {
                              setState(() {
                                currentRequest?.removeFuncAt(index);
                              });
                            },
                          )
                        : const SizedBox(),
                  ],
                );
              })
            ]),
      ),
    );
  }
}

class APIFuncDefinitionView extends StatefulWidget {
  final APIRowData? dataRow;

  const APIFuncDefinitionView({super.key, required this.dataRow});

  @override
  State<APIFuncDefinitionView> createState() => _APIFuncDefinitionViewState();
}

class _APIFuncDefinitionViewState extends State<APIFuncDefinitionView> {
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    final CodeController controller = CodeController(
      text: widget.dataRow?.function ?? dartSnippet,
      language: dart,
    );

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: AlertDialog(
        title:
            Text(widget.dataRow?.keyController.text ?? "Function Definition"),
        content: SizedBox(
          width: screenSize.width * 0.8,
          height: screenSize.height * 0.6,
          child: CodeTheme(
            data: CodeThemeData(styles: githubTheme),
            child: CodeField(
              controller: controller,
              expands: true,
              wrap: true,
            ),
          ),
        ),
        actions: [
          TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text("Close")),
          TextButton(
              onPressed: () {
                widget.dataRow?.function = controller.text;
                Navigator.of(context).pop();
              },
              child: Text("Save"))
        ],
      ),
    );
  }
}

class APIFuncViewResult extends StatefulWidget {
  final APIRowData? dataRow;

  const APIFuncViewResult({super.key, required this.dataRow});

  @override
  State<APIFuncViewResult> createState() => _APIFuncViewResultState();
}

class _APIFuncViewResultState extends State<APIFuncViewResult> {
  dynamic evalResult() {
    final data = widget.dataRow;
    if (data == null || data.function == null || data.function!.isEmpty) {
      return;
    }
    try {
      var result = eval(data.function!, function: data.keyController.text);
      return result;
    } catch (e) {
      return "Error in executing function: ${e.toString()}";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: AlertDialog(
        title: const Text("Execution Result"),
        content: SingleChildScrollView(
          child: Text(evalResult() ?? "No result"),
        ),
        actions: [
          TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text("Cancel"))
        ],
      ),
    );
  }
}
