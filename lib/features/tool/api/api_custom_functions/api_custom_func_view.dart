import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:sengthaite_blog/features/tool/api/api_encryption/api_encryption_view.dart';
import 'package:sengthaite_blog/features/tool/api/api_request_builder.dart';

class APICustomFuncView extends StatefulWidget {
  const APICustomFuncView({super.key});

  @override
  State<APICustomFuncView> createState() => _APICustomFuncViewState();
}

class _APICustomFuncViewState extends State<APICustomFuncView> {
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
                Checkbox(
                  value: currentRequest?.selectedAllCrypto ?? true,
                  onChanged: (value) {
                    currentRequest?.toggleCryptoAllRow();
                    setState(() => currentRequest?.selectedAllCrypto = value);
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
                  onPressed: () =>
                      setState(() => currentRequest?.addCrypto(APIRowData())),
                  icon: Icon(
                    MdiIcons.plus,
                    color: Colors.green,
                  ),
                ),
              ]),
              ...List.generate(currentRequest?.cryptoControllers.length ?? 0,
                  (index) {
                var dataRow = currentRequest?.cryptoControllers[index];
                return TableRow(
                  children: [
                    Checkbox(
                      value: dataRow?.isSelected,
                      onChanged: (value) => setState(
                        () => currentRequest?.toggleCryptoRowSelectionAt(index),
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
                          "Add Crypto",
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
                                currentRequest?.removeCryptoAt(index);
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
