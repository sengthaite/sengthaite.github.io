import 'package:flutter/material.dart';
import 'package:sengthaite_blog/features/tool/api/api_request_builder.dart';

class APIUtilBodyView extends StatelessWidget {
  const APIUtilBodyView({super.key, required this.requestBuilder});

  final HttpRequestBuilder requestBuilder;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        enableSuggestions: false,
        maxLines: null,
        autofocus: true,
        keyboardType: TextInputType.multiline,
        style: const TextStyle(fontSize: 12),
        decoration: const InputDecoration(
          hintText: "",
          border: InputBorder.none,
        ),
        controller: requestBuilder.bodyInputController,
      ),
    );
  }
}
