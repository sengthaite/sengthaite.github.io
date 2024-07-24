import 'package:flutter/material.dart';
import 'package:sengthaite_blog/features/tool/http/http_request_builder.dart';

class HttpUtilParamView extends StatefulWidget {
  const HttpUtilParamView({super.key, required this.requestBuilder});

  final HttpRequestBuilder requestBuilder;

  @override
  State<HttpUtilParamView> createState() => _HttpUtilParamViewState();
}

class _HttpUtilParamViewState extends State<HttpUtilParamView> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        child: DataTable(
            border: TableBorder.all(
              borderRadius: const BorderRadius.all(Radius.circular(4)),
            ),
            columns: [
              DataColumn(
                label: Checkbox(
                  value: widget.requestBuilder.selectedAllParam,
                  onChanged: (value) {
                    widget.requestBuilder.toggleParamAllRow();
                    setState(() {
                      widget.requestBuilder.selectedAllParam = value;
                    });
                  },
                ),
              ),
              const DataColumn(
                  label: Text("Key",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 14))),
              const DataColumn(
                  label: Text("Value",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 14))),
              const DataColumn(
                  label: Text("Description",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 14))),
              const DataColumn(label: SizedBox(width: 50)),
            ],
            rows: List.generate(widget.requestBuilder.paramControllers.length,
                (index) {
              var dataRow = widget.requestBuilder.paramControllers[index];
              return DataRow(
                cells: [
                  DataCell(
                    Checkbox(
                      value: dataRow.isSelected,
                      onChanged: (value) => setState(() => widget.requestBuilder
                          .toggleParamRowSelectionAt(index)),
                    ),
                  ),
                  DataCell(
                    TextFormField(
                      decoration: const InputDecoration(
                        hintText: "Key",
                        border: InputBorder.none,
                      ),
                      initialValue: dataRow.key,
                      controller: dataRow.keyController,
                    ),
                  ),
                  DataCell(
                    TextFormField(
                      decoration: const InputDecoration(
                        hintText: "Value",
                        border: InputBorder.none,
                      ),
                      initialValue: dataRow.value,
                      controller: dataRow.valueController,
                    ),
                  ),
                  DataCell(
                    TextFormField(
                      decoration: const InputDecoration(
                        hintText: "Description",
                        border: InputBorder.none,
                      ),
                      initialValue: dataRow.description,
                      controller: dataRow.descriptionController,
                    ),
                  ),
                  DataCell(
                    dataRow.allowDeletion
                        ? IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () => {},
                          )
                        : const SizedBox(),
                  )
                ],
              );
            })),
      ),
    );
  }
}
