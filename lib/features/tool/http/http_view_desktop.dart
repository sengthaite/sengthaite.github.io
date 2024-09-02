import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sengthaite_blog/components/http_response_view.dart';
import 'package:sengthaite_blog/extensions/http_ext.dart';
import 'package:sengthaite_blog/features/tool/http/http_request_builder.dart';

class HttpViewDesktop extends StatefulWidget {
  const HttpViewDesktop({
    super.key,
    // required this.requestBuilder,
  });

  // final HttpRequestBuilder requestBuilder;

  @override
  State<HttpViewDesktop> createState() => _HttpViewDesktopState();
}

class _HttpViewDesktopState extends State<HttpViewDesktop> {
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
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  DropdownMenu(
                    initialSelection: requestBuilder.requestMethod ??
                        HttpRequestMethodTypeExtension.defaultHttpMethod,
                    requestFocusOnTap: false,
                    dropdownMenuEntries: HttpRequestMethodTypeExtension
                        .listRequestMethods
                        .map((e) => DropdownMenuEntry(value: e, label: e))
                        .toList(),
                    onSelected: (value) => requestBuilder.requestMethod = value,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  SizedBox(
                    width: 400,
                    child: TextFormField(
                      controller: requestBuilder.urlInputController,
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
        const SizedBox(
          width: 8,
        ),
        SizedBox(
          width: 200,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("List of Requests",
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.w400)),
                const SizedBox(
                  height: 24,
                ),
                Row(
                  children: [
                    const Text(
                      "POST",
                      style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(width: 10),
                    const Text("first request"),
                    PopupMenuButton(
                      itemBuilder: (context) {
                        return const [
                          PopupMenuItem(
                            value: "edit",
                            child: Text("Edit"),
                          ),
                          PopupMenuItem(
                            value: "delete",
                            child: Text("Delete"),
                          )
                        ];
                      },
                      onSelected: (value) {},
                    )
                  ],
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}
