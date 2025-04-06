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
    final requestBuilder = context.watch<HttpRequestBuilder>();
    allowSubmitRequest =
        requestBuilder.urlInputController?.text.isNotEmpty ?? false;
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
                  color: requestBuilder.methodColor,
                  fontWeight: FontWeight.bold,
                ),
                initialSelection: requestBuilder.getRequestMethod ??
                    HttpRequestMethodTypeExtension.defaultHttpMethod,
                requestFocusOnTap: false,
                dropdownMenuEntries: HttpRequestMethodTypeExtension
                    .listRequestMethods
                    .map((e) => DropdownMenuEntry(value: e, label: e))
                    .toList(),
                onSelected: (value) {
                  if (value == null) return;
                  requestBuilder.setRequestMethod = value;
                },
              ),
              const SizedBox(width: 10),
              SizedBox(
                width: 400,
                child: TextFormField(
                  textInputAction: TextInputAction.done,
                  controller: requestBuilder.urlInputController,
                  decoration: InputDecoration(
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    border: OutlineInputBorder(),
                    hintText: "URL",
                    labelText: labelText,
                  ),
                  onChanged: (value) => setState(() {
                    allowSubmitRequest = value.isUrl;
                    if (value.isEmpty) requestBuilder.reset();
                  }),
                  onFieldSubmitted: (value) =>
                      allowSubmitRequest ? requestBuilder.request() : null,
                ),
              ),
              const SizedBox(width: 10),
              TextButton(
                onPressed:
                    allowSubmitRequest ? () => requestBuilder.request() : null,
                child: const Text(
                  "Request",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              TextButton(
                onPressed: null,
                child: const Text(
                  "Save",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          Expanded(
            child:
                requestBuilder.response != null && !requestBuilder.isRequesting
                    ? HttpResponseView(
                        response: requestBuilder.response,
                        requestBuilder: requestBuilder,
                      )
                    : Center(
                        child: requestBuilder.isRequesting
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
