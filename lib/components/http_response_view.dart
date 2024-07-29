import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class HttpResponseView extends StatelessWidget {
  const HttpResponseView({super.key, required this.response});

  final Response? response;

  String beautifyJson(Map<String, dynamic> json, {bool withSeparator = false}) {
    try {
      final encodedJson = const JsonEncoder.withIndent('  ').convert(json);
      return encodedJson + (withSeparator ? ',\n' : '');
    } catch (e) {
      debugPrint("Error: ${e.toString()}");
      return json.toString();
    }
  }

  Widget get contentViewer {
    if (response == null) {
      return const Text("Empty response");
    }
    var contentType = response!.headers.value(Headers.contentTypeHeader);
    var isJson = contentType?.contains("application/json") ?? false;
    var data = response?.data;
    if (data == null) {
      return const Text("Empty data");
    }
    if (isJson) {
      if (data is List) {
        var dataLength = data.length;
        var listText = List.generate(
          dataLength,
          (index) => TextSpan(
            text: beautifyJson(
              data[index],
              withSeparator: dataLength - 1 > index,
            ),
          ),
        );
        return RichText(
            text: TextSpan(children: [
          const TextSpan(text: '[\n'),
          ...listText,
          const TextSpan(text: '\n]'),
        ]));
      } else {
        return Text(beautifyJson(response?.data ?? ''));
      }
    }
    return Text(response!.data.toString());
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(child: contentViewer);
  }
}
