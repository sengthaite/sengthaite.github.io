import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sengthaite_blog/components/http_response_view.dart';
import 'package:sengthaite_blog/extensions/http_ext.dart';
import 'package:sengthaite_blog/features/tool/http/http_request_builder.dart';

class HttpViewDesktop extends StatefulWidget {
  const HttpViewDesktop({
    super.key,
  });

  @override
  State<HttpViewDesktop> createState() => _HttpViewDesktopState();
}

class _HttpViewDesktopState extends State<HttpViewDesktop> {
  bool allowSubmitRequest = false;
  Color? methodColor = HttpRequestMethodTypeExtension.methodByDisplay(
          HttpRequestMethodTypeExtension.defaultHttpMethod)
      ?.color;

  @override
  Widget build(BuildContext context) {
    final requestBuilder = context.watch<HttpRequestBuilder>();
    allowSubmitRequest = requestBuilder.urlInputController.text.isNotEmpty;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
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
                      color: methodColor,
                      fontWeight: FontWeight.bold,
                    ),
                    initialSelection: requestBuilder.requestMethod ??
                        HttpRequestMethodTypeExtension.defaultHttpMethod,
                    requestFocusOnTap: false,
                    dropdownMenuEntries: HttpRequestMethodTypeExtension
                        .listRequestMethods
                        .map((e) => DropdownMenuEntry(value: e, label: e))
                        .toList(),
                    onSelected: (value) {
                      if (value == null) return;
                      requestBuilder.requestMethod = value;
                      setState(() {
                        methodColor =
                            HttpRequestMethodTypeExtension.methodByDisplay(
                                    value)
                                ?.color;
                      });
                    },
                  ),
                  const SizedBox(width: 10),
                  SizedBox(
                    width: 400,
                    child: TextFormField(
                      textInputAction: TextInputAction.done,
                      controller: requestBuilder.urlInputController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "URL",
                      ),
                      onChanged: (value) =>
                          setState(() => allowSubmitRequest = value.isNotEmpty),
                      onFieldSubmitted: (value) =>
                          value.isNotEmpty ? requestBuilder.request() : null,
                    ),
                  ),
                  const SizedBox(width: 10),
                  TextButton(
                    onPressed: allowSubmitRequest
                        ? () => requestBuilder.request()
                        : null,
                    child: const Text(
                      "Submit",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
              Expanded(
                child: requestBuilder.response != null &&
                        !requestBuilder.isRequesting
                    ? HttpResponseView(response: requestBuilder.response)
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
        ),
      ],
    );
  }
}
