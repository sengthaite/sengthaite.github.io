import 'package:flutter/material.dart';
import 'package:sengthaite_blog/features/tool/http/http_request_builder.dart';
import 'package:sengthaite_blog/features/tool/http/http_utils/http_util_auth_view.dart';
import 'package:sengthaite_blog/features/tool/http/http_utils/http_util_body_view.dart';
import 'package:sengthaite_blog/features/tool/http/http_utils/http_util_header_view.dart';
import 'package:sengthaite_blog/features/tool/http/http_utils/http_util_param_view.dart';

class HttpUtilView extends StatelessWidget {
  const HttpUtilView({
    super.key,
    required this.requestBuilder,
  });

  final HttpRequestBuilder requestBuilder;

  Map<String, Widget> get tabData => {
        "Params": HttpUtilParamView(requestBuilder: requestBuilder),
        "Authorization": HttpUtilAuthView(requestBuilder: requestBuilder),
        "Headers": HttpUtilHeaderView(requestBuilder: requestBuilder),
        "Body": HttpUtilBodyView(requestBuilder: requestBuilder),
      };

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: tabData.length,
      initialIndex: 0,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            "HTTP Request",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          elevation: 0,
          automaticallyImplyLeading: false,
          bottom: TabBar(
            tabs: tabData.keys.map((e) => Tab(text: e)).toList(),
          ),
        ),
        body: TabBarView(
            physics: const NeverScrollableScrollPhysics(),
            children: tabData.values.toList()),
      ),
    );
  }
}
