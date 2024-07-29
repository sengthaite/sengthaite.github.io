import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:sengthaite_blog/features/tool/http/http_request_builder.dart';

class HttpUtilHeaderView extends StatefulWidget {
  const HttpUtilHeaderView({super.key, required this.requestBuilder});

  final HttpRequestBuilder requestBuilder;

  @override
  State<HttpUtilHeaderView> createState() => _HttpUtilHeaderViewState();
}

class _HttpUtilHeaderViewState extends State<HttpUtilHeaderView> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        child: Table(
            defaultVerticalAlignment: TableCellVerticalAlignment.middle,
            columnWidths: const {
              0: FixedColumnWidth(40),
            },
            border: TableBorder.all(
              borderRadius: const BorderRadius.all(Radius.circular(4)),
            ),
            children: [
              TableRow(children: [
                Checkbox(
                  value: widget.requestBuilder.selectedAllHeader,
                  onChanged: (value) {
                    widget.requestBuilder.toggleHeaderAllRow();
                    setState(() {
                      widget.requestBuilder.selectedAllHeader = value;
                    });
                  },
                ),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text("Key",
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                ),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text("Value",
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                ),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text("Description",
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                ),
                IconButton(
                  splashColor: Colors.transparent,
                  color: Colors.transparent,
                  highlightColor: Colors.transparent,
                  focusColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  onPressed: () {
                    setState(() {
                      widget.requestBuilder.addHeader(HttpRowData());
                    });
                  },
                  icon: Icon(
                    MdiIcons.plus,
                    color: Colors.green,
                  ),
                ),
              ]),
              ...List.generate(widget.requestBuilder.headerControllers.length,
                  (index) {
                var dataRow = widget.requestBuilder.headerControllers[index];
                return TableRow(
                  children: [
                    Checkbox(
                      value: dataRow.isSelected,
                      onChanged: (value) => setState(() => widget.requestBuilder
                          .toggleHeaderRowSelectionAt(index)),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        enableSuggestions: false,
                        maxLines: null,
                        style: const TextStyle(fontSize: 12),
                        keyboardType: TextInputType.multiline,
                        decoration: const InputDecoration(
                          hintText: "Key",
                          border: InputBorder.none,
                        ),
                        initialValue: dataRow.key,
                        controller: dataRow.keyController,
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
                        initialValue: dataRow.value,
                        controller: dataRow.valueController,
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
                        initialValue: dataRow.description,
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
                                widget.requestBuilder.removeHeaderAt(index);
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
