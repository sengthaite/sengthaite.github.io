import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:sengthaite_blog/constants/theme.dart';
import 'package:sengthaite_blog/features/tool/api/api_request_builder.dart';
import 'package:sengthaite_blog/features/tool/api/api_util_table_data.dart';

class APIUtilParamView extends StatefulWidget {
  const APIUtilParamView({
    super.key,
  });

  @override
  State<APIUtilParamView> createState() => _APIUtilParamViewState();
}

class _APIUtilParamViewState extends State<APIUtilParamView> {
  var selectedDatum = HttpRequestBuilder.getInstance().selectedDatum;
  var currentRequest =
      HttpRequestBuilder.getInstance().selectedDatum?.paramData;
  var textTheme = MaterialTheme.textTheme();

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
                  value: currentRequest?.selectedAll ?? false,
                  onChanged: (value) {
                    currentRequest?.toggleAllRow();
                    setState(() => currentRequest?.selectedAll = value);
                  },
                ),
                 Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text("Key",
                      textAlign: TextAlign.center,
                      style: textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.bold)),
                ),
                 Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text("Value",
                      textAlign: TextAlign.center,
                      style: textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.bold)),
                ),
                 Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text("Description",
                      textAlign: TextAlign.center,
                      style: textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.bold)),
                ),
                IconButton(
                  splashColor: Colors.transparent,
                  color: Colors.transparent,
                  highlightColor: Colors.transparent,
                  focusColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  onPressed: () =>
                      setState(() => currentRequest?.add(APIRowData())),
                  icon: Icon(
                    MdiIcons.plus,
                    color: Colors.green,
                  ),
                ),
              ]),
              ...List.generate(currentRequest?.controllers.length ?? 0,
                  (index) {
                var dataRow = currentRequest?.controllers[index];
                return TableRow(
                  children: [
                    Checkbox(
                      value: dataRow?.isSelected,
                      onChanged: (value) => setState(
                          () => currentRequest?.toggleRowSelectionAt(index)),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        style: textTheme.labelSmall,
                        enableSuggestions: false,
                        maxLines: null,
                        keyboardType: TextInputType.multiline,
                        decoration: const InputDecoration(
                          hintText: "Key",
                          border: InputBorder.none,
                        ),
                        controller: dataRow?.keyController,
                        onChanged: (text) => selectedDatum
                            ?.buildUrlWithQueryParams(index, key: text),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        style: textTheme.labelSmall,
                        enableSuggestions: false,
                        maxLines: null,
                        keyboardType: TextInputType.multiline,
                        decoration: const InputDecoration(
                          hintText: "Value",
                          border: InputBorder.none,
                        ),
                        controller: dataRow?.valueController,
                        onChanged: (value) => selectedDatum
                            ?.buildUrlWithQueryParams(index, value: value),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        style: textTheme.labelSmall,
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
                            onPressed: () =>
                                setState(() => currentRequest?.removeAt(index)),
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
