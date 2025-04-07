import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:sengthaite_blog/extensions/http_ext.dart';
import 'package:sengthaite_blog/features/tool/api/api_request_builder.dart';
import 'package:sengthaite_blog/features/tool/api/api_utils/api_util.dart';

class HttpResponseView extends StatelessWidget {
  const HttpResponseView({
    super.key,
    required this.response,
  });

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
    var isHtml = contentType?.contains("html") ?? false;
    var responseContentType = response!.headers.responseContentType;
    var data = response?.data;
    if (data == null) {
      return const Text("Empty data");
    }
    if (isImage) {
      return Padding(
        padding: EdgeInsets.all(8),
        child: Image.network(
            HttpRequestBuilder.getInstance().urlInputController?.text ?? ""),
      );
    }
    if (isJson) {
      try {
        var formattedJson = JsonEncoder.withIndent('  ').convert(data);

        return SingleChildScrollView(
            child: Text(
                formattedJson is List ? (formattedJson[0]) : formattedJson));
      } catch (error) {
        debugPrint(error.toString());
        return Text("Invalid json");
      }
    }
    if (isHtml) {
      return SingleChildScrollView(child: Html(data: data.toString()));
    }

    switch (responseContentType) {
      case ResponseType.plain:
      case ResponseType.json:
        return Text(response!.data.toString());
      case ResponseType.bytes:
        return TextButton(
          onPressed: () {
            APIUtil.download(response!.data);
          },
          child: const Text("Download"),
        );
      case ResponseType.stream:
        Stream<int> fileStream = response!.data;
        return TextButton(
          onPressed: () {
            APIUtil.downloadStream(fileStream);
          },
          child: const Text("Download"),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return contentViewer;
  }
}
