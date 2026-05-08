import 'package:flutter/material.dart';
import 'package:sengthaite_blog/constants/theme.dart';
import 'package:sengthaite_blog/features/tool/api/api_request_builder.dart';

class APIUtilBodyView extends StatefulWidget {
  const APIUtilBodyView({super.key});

  @override
  State<APIUtilBodyView> createState() => _APIUtilBodyViewState();
}

class _APIUtilBodyViewState extends State<APIUtilBodyView> {
  var currentRequest = HttpRequestBuilder.getInstance().selectedDatum;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        enableSuggestions: false,
        maxLines: null,
        autofocus: true,
        keyboardType: TextInputType.multiline,
        style: MaterialTheme.textTheme().bodyMedium!.copyWith(fontSize: 12),
        decoration: const InputDecoration(
          hintText: "",
          border: InputBorder.none,
        ),
        controller: currentRequest?.bodyInputController,
      ),
    );
  }
}
