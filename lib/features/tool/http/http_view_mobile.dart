import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sengthaite_blog/components/http_response_view.dart';
import 'package:sengthaite_blog/extensions/http_ext.dart';
import 'package:sengthaite_blog/features/tool/http/http_request_builder.dart';

class HttpViewMobile extends StatefulWidget {
  const HttpViewMobile({
    super.key,
  });

  @override
  State<HttpViewMobile> createState() => _HttpViewDesktopState();
}

class _HttpViewDesktopState extends State<HttpViewMobile> {
  bool allowSubmitRequest = false;

  @override
  Widget build(BuildContext context) {
    final requestBuilder = context.watch<HttpRequestBuilder>();
    return Row(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  DropdownMenu(
                    width: 100,
                    textStyle: const TextStyle(fontSize: 14),
                    initialSelection: requestBuilder.requestMethod ??
                        HttpRequestMethodTypeExtension.defaultHttpMethod,
                    requestFocusOnTap: false,
                    dropdownMenuEntries: HttpRequestMethodTypeExtension
                        .listRequestMethods
                        .map((e) => DropdownMenuEntry(value: e, label: e))
                        .toList(),
                    onSelected: (value) => requestBuilder.requestMethod = value,
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: TextFormField(
                      style: const TextStyle(fontSize: 14),
                      controller: requestBuilder.urlInputController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "URL",
                      ),
                      onChanged: (value) =>
                          setState(() => allowSubmitRequest = value.isNotEmpty),
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
        const SizedBox(width: 8),
      ],
    );
  }
}
