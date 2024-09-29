import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:sengthaite_blog/extensions/http_ext.dart';
import 'package:sengthaite_blog/features/tool/http/http_utils/http_util.dart';

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
    var isImage = contentType?.contains("image") ?? false;
    var responseContentType = response!.headers.responseContentType;
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
    if (isImage) {
      try {
        return Image.memory(response!.data);
      } catch (e) {
        return const Icon(Icons.image_not_supported);
      }
    }
    switch (responseContentType) {
      case ResponseType.plain:
      case ResponseType.json:
        return Text(response!.data.toString());
      case ResponseType.bytes:
        return TextButton(
          onPressed: () {
            HttpUtil.download(response!.data);
          },
          child: const Text("Download"),
        );
      case ResponseType.stream:
        Stream<int> fileStream = response!.data;
        return TextButton(
          onPressed: () {
            HttpUtil.downloadStream(fileStream);
          },
          child: const Text("Download"),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(child: contentViewer);
  }
}
