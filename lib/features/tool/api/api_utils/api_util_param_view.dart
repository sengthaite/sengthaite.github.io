import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:sengthaite_blog/features/tool/api/api_request_builder.dart';

class APIUtilParamView extends StatefulWidget {
  const APIUtilParamView({
    super.key,
    required this.requestBuilder,
  });

  final HttpRequestBuilder requestBuilder;

  @override
  State<APIUtilParamView> createState() => _APIUtilParamViewState();
}

class _APIUtilParamViewState extends State<APIUtilParamView> {
  @override
  void initState() {
    var uri = Uri.tryParse(widget.requestBuilder.urlInputController.text);
    if (uri == null) return;
    var params = uri.queryParameters;
    widget.requestBuilder.paramControllers.clear();
    if (params.isEmpty) {
      widget.requestBuilder.paramControllers
          .add(APIRowData(allowDeletion: false));
    } else {
      params.forEach((key, value) {
        var row = APIRowData(allowDeletion: false, key: key, value: value);
        widget.requestBuilder.paramControllers.add(row);
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        child: Table(
            defaultVerticalAlignment: TableCellVerticalAlignment.middle,
            columnWidths: const {
              0: FixedColumnWidth(40),
              4: FixedColumnWidth(40),
            },
            border: TableBorder.all(
              borderRadius: const BorderRadius.all(Radius.circular(4)),
            ),
            children: [
              TableRow(children: [
                Checkbox(
                  value: widget.requestBuilder.selectedAllParam,
                  onChanged: (value) {
                    widget.requestBuilder.toggleParamAllRow();
                    setState(() {
                      widget.requestBuilder.selectedAllParam = value;
                    });
                  },
                ),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text("Key",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontWeight: FontWeight.bold)),
                ),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text("Value",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontWeight: FontWeight.bold)),
                ),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text("Description",
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
                      widget.requestBuilder.addParam(APIRowData());
                    });
                  },
                  icon: Icon(
                    MdiIcons.plus,
                    color: Colors.green,
                  ),
                ),
              ]),
              ...List.generate(widget.requestBuilder.paramControllers.length,
                  (index) {
                var dataRow = widget.requestBuilder.paramControllers[index];
                return TableRow(
                  children: [
                    Checkbox(
                      value: dataRow.isSelected,
                      onChanged: (value) => setState(() => widget.requestBuilder
                          .toggleParamRowSelectionAt(index)),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        style: const TextStyle(fontSize: 12),
                        enableSuggestions: false,
                        maxLines: null,
                        keyboardType: TextInputType.multiline,
                        decoration: const InputDecoration(
                          hintText: "Key",
                          border: InputBorder.none,
                        ),
                        controller: dataRow.keyController,
                        onChanged: (text) => widget.requestBuilder
                            .buildUrlWithQueryParams(index, key: text),
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
                          hintText: "Value",
                          border: InputBorder.none,
                        ),
                        controller: dataRow.valueController,
                        onChanged: (value) => widget.requestBuilder
                            .buildUrlWithQueryParams(index, value: value),
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
                        controller: dataRow.descriptionController,
                      ),
                    ),
                    dataRow.allowDeletion
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
                                widget.requestBuilder.removeParamAt(index);
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
