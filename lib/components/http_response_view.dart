import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:sengthaite_blog/extensions/http_ext.dart';
import 'package:sengthaite_blog/features/tool/api/api_request_builder.dart';
import 'package:sengthaite_blog/features/tool/api/api_utils/api_util.dart';
import 'package:url_launcher/url_launcher.dart';

class HttpResponseView extends StatelessWidget {
  const HttpResponseView({
    super.key,
    required this.response,
    required this.requestBuilder,
  });

  final Response? response;
  final HttpRequestBuilder requestBuilder;

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
    if (isHtml || isJson || isImage) {
      return InAppWebView(
        initialUrlRequest: URLRequest(
          allowsCellularAccess: true,
          allowsConstrainedNetworkAccess: true,
          allowsExpensiveNetworkAccess: true,
          url: WebUri(requestBuilder.urlInputController.text),
        ),
        initialSettings: InAppWebViewSettings(
          isInspectable: kDebugMode,
          mediaPlaybackRequiresUserGesture: false,
          allowsInlineMediaPlayback: true,
          iframeAllow: "camera; microphone",
          iframeAllowFullscreen: true,
        ),
        shouldOverrideUrlLoading: (controller, navigationAction) async {
          var uri = navigationAction.request.url!;
          if (![
            "http",
            "https",
            "file",
            "chrome",
            "data",
            "javascript",
            "about"
          ].contains(uri.scheme)) {
            if (await canLaunchUrl(uri)) {
              // Launch the App
              await launchUrl(
                uri,
              );
              // and cancel the request
              return NavigationActionPolicy.CANCEL;
            }
          }
          return NavigationActionPolicy.ALLOW;
        },
      );
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
