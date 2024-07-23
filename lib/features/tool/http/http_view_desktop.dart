import 'package:flutter/material.dart';
import 'package:sengthaite_blog/extensions/http_ext.dart';
import 'package:sengthaite_blog/features/tool/http/http_request_builder.dart';

class HttpViewDesktop extends StatelessWidget {
  HttpViewDesktop({super.key});

  final requestBuilder = HttpRequestBuilder();

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
                    initialSelection:
                        HttpRequestMethodTypeExtension.defaultHttpMethod,
                    requestFocusOnTap: false,
                    dropdownMenuEntries: HttpRequestMethodTypeExtension
                        .listRequestMethods
                        .map((e) => DropdownMenuEntry(value: e, label: e))
                        .toList(),
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
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  TextButton(
                    onPressed: requestBuilder.urlInputController.text.isNotEmpty
                        ? () {
                            debugPrint("submit");
                          }
                        : null,
                    child: const Text(
                      "Submit",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
              Expanded(
                child: Container(
                  color: Colors.blue,
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
