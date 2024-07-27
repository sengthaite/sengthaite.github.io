import 'package:flutter/material.dart';
import 'package:sengthaite_blog/extensions/http_ext.dart';
import 'package:sengthaite_blog/features/tool/http/http_request_builder.dart';

class HttpViewDesktop extends StatefulWidget {
  const HttpViewDesktop({
    super.key,
    required this.requestBuilder,
  });

  final HttpRequestBuilder requestBuilder;

  @override
  State<HttpViewDesktop> createState() => _HttpViewDesktopState();
}

class _HttpViewDesktopState extends State<HttpViewDesktop> {
  bool allowSubmitRequest = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  DropdownMenu(
                    initialSelection: widget.requestBuilder.requestMethod ??
                        HttpRequestMethodTypeExtension.defaultHttpMethod,
                    requestFocusOnTap: false,
                    dropdownMenuEntries: HttpRequestMethodTypeExtension
                        .listRequestMethods
                        .map((e) => DropdownMenuEntry(value: e, label: e))
                        .toList(),
                    onSelected: (value) =>
                        widget.requestBuilder.requestMethod = value,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  SizedBox(
                    width: 400,
                    child: TextFormField(
                      controller: widget.requestBuilder.urlInputController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "URL",
                      ),
                      onChanged: (value) =>
                          setState(() => allowSubmitRequest = value.isNotEmpty),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  TextButton(
                    onPressed: allowSubmitRequest
                        ? () => widget.requestBuilder.request()
                        : null,
                    child: const Text(
                      "Submit",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
              Expanded(child: Text(widget.requestBuilder.responseBody ?? ''))
            ],
          ),
        ),
        const SizedBox(
          width: 8,
        ),
        SizedBox(
          width: 200,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("List of Requests"),
                const SizedBox(
                  height: 24,
                ),
                Column(children: [
                  Container(
                    child: const Text("first request"),
                  ),
                ])
              ],
            ),
          ),
        )
      ],
    );
  }
}
