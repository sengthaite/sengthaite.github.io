import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sengthaite_blog/components/http_response_view.dart';
import 'package:sengthaite_blog/extensions/http_ext.dart';
import 'package:sengthaite_blog/features/tool/api/api_request_builder.dart';

class APIViewMobile extends StatefulWidget {
  const APIViewMobile({
    super.key,
  });

  @override
  State<APIViewMobile> createState() => _APIViewDesktopState();
}

class _APIViewDesktopState extends State<APIViewMobile> {
  bool allowSubmitRequest = false;
  Color? methodColor = HttpRequestMethodTypeExtension.methodByDisplay(
          HttpRequestMethodTypeExtension.defaultHttpMethod)
      ?.color;

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
                    textStyle: TextStyle(
                        fontSize: 14,
                        color: methodColor,
                        fontWeight: FontWeight.bold),
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
                  Expanded(
                    child: TextFormField(
                      textInputAction: TextInputAction.done,
                      style: const TextStyle(fontSize: 14),
                      controller: requestBuilder.urlInputController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "URL",
                      ),
                      onChanged: (value) =>
                          setState(() => allowSubmitRequest = value.isNotEmpty),
                      onFieldSubmitted: (value) {
                        value.isNotEmpty ? requestBuilder.request() : null;
                      },
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
