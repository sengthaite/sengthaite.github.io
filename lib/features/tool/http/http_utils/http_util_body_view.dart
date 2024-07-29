import 'package:flutter/material.dart';
import 'package:sengthaite_blog/features/tool/http/http_request_builder.dart';

class HttpUtilBodyView extends StatelessWidget {
  const HttpUtilBodyView({super.key, required this.requestBuilder});

  final HttpRequestBuilder requestBuilder;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      enableSuggestions: false,
      maxLines: null,
      autofocus: true,
      keyboardType: TextInputType.multiline,
      decoration: const InputDecoration(
        hintText: "",
        border: InputBorder.none,
      ),
      controller: requestBuilder.bodyInputController,
    );
  }
}
