import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sengthaite_blog/components/http_response_view.dart';
import 'package:sengthaite_blog/extensions/http_ext.dart';
import 'package:sengthaite_blog/extensions/string_ext.dart';
import 'package:sengthaite_blog/features/tool/api/api_request_builder.dart';

class APIViewDesktop extends StatefulWidget {
  const APIViewDesktop({
    super.key,
  });

  @override
  State<APIViewDesktop> createState() => _APIViewDesktopState();
}

class _APIViewDesktopState extends State<APIViewDesktop> {
  bool allowSubmitRequest = false;

  String? labelText;

  @override
  void dispose() {
    super.dispose();
    HttpRequestBuilder.getInstance().removeInstance();
  }

  @override
  Widget build(BuildContext context) {
    final selectedData = context.watch<HttpRestRequestDatum>();
    allowSubmitRequest = selectedData.urlInputController.text.isNotEmpty;
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              DropdownMenu(
                textStyle: TextStyle(
                  fontSize: 14,
                  color: selectedData.methodColor,
                  fontWeight: FontWeight.bold,
                ),
                initialSelection: selectedData.getRequestMethod ??
                    HttpRequestMethodTypeExtension.defaultHttpMethod,
                requestFocusOnTap: false,
                dropdownMenuEntries: HttpRequestMethodTypeExtension
                    .listRequestMethods
                    .map((e) => DropdownMenuEntry(value: e, label: e))
                    .toList(),
                onSelected: (value) {
                  if (value == null) return;
                  selectedData.setRequestMethod = value as String;
                },
              ),
              const SizedBox(width: 10),
              SizedBox(
                width: 400,
                child: TextFormField(
                  textInputAction: TextInputAction.done,
                  controller: selectedData.urlInputController,
                  decoration: InputDecoration(
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    border: OutlineInputBorder(),
                    hintText: "URL",
                    labelText: labelText,
                  ),
                  onChanged: (value) => setState(() {
                    allowSubmitRequest = value.isUrl;
                    if (value.isEmpty) selectedData.reset();
                  }),
                  onFieldSubmitted: (value) =>
                      allowSubmitRequest ? selectedData.request() : null,
                ),
              ),
              const SizedBox(width: 10),
              TextButton(
                onPressed:
                    allowSubmitRequest ? () => selectedData.request() : null,
                child: const Text(
                  "Request",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          Expanded(
            child: selectedData.response != null && !(selectedData.isRequesting)
                ? HttpResponseView(response: selectedData.response)
                : Center(
                    child: selectedData.isRequesting
                        ? const CircularProgressIndicator()
                        : const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text("Empty response"),
                          ),
                  ),
          )
        ],
      ),
    );
  }
}
