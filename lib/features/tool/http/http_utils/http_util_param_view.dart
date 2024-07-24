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
      child: DataTable(
          columns: [
            DataColumn(
              label: Checkbox(
                  value: widget.requestBuilder.selectedAllParam,
                  onChanged: (value) {
                    widget.requestBuilder.toggleParamAllRow();
                    setState(() {
                      widget.requestBuilder.selectedAllParam = value;
                    });
                  }),
            ),
            const DataColumn(
                label: Text("Key",
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 14))),
            const DataColumn(
                label: Text("Value",
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 14))),
            const DataColumn(
                label: Text("Description",
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 14))),
            const DataColumn(label: SizedBox(width: 50)),
          ],
          rows: List.generate(widget.requestBuilder.paramControllers.length,
              (index) {
            return DataRow(cells: []);
          })),
    );
  }
}
