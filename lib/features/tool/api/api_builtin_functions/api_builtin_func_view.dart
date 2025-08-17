import 'package:flutter/material.dart';
import 'package:sengthaite_blog/features/tool/api/api_encryption/api_encryption_view.dart';
import 'package:sengthaite_blog/features/tool/api/api_request_builder.dart';

class APIBuiltInFuncView extends StatefulWidget {
  const APIBuiltInFuncView({super.key});

  @override
  State<APIBuiltInFuncView> createState() => _APIBuiltInFuncViewState();
}

class _APIBuiltInFuncViewState extends State<APIBuiltInFuncView> {
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
              4: FixedColumnWidth(40),
            },
            border: TableBorder.all(
              borderRadius: const BorderRadius.all(
                Radius.circular(4),
              ),
            ),
            children: [
              TableRow(children: [
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
              ]),
              ...List.generate(
                  currentRequest?.builtInFuncControllers.length ?? 0, (index) {
                var dataRow = currentRequest?.builtInFuncControllers[index];
                return TableRow(
                  children: [
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
                        controller: dataRow?.keyController,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: MaterialButton(
                        color: Colors.orange,
                        textColor: Colors.white,
                        onPressed: () {
                          showDialog(
                              context: context,
                              barrierDismissible: false,
                              builder: (BuildContext context) {
                                return APICryptoSelectionView(
                                  dataRow: dataRow ?? APIRowData(),
                                );
                              });
                        },
                        child: Text(
                          "View Detail",
                          style: TextStyle(
                              fontSize: 12, fontWeight: FontWeight.bold),
                        ),
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
                    )
                  ],
                );
              })
            ]),
      ),
    );
  }
}
