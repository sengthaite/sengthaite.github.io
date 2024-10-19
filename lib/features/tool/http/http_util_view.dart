import 'package:flutter/material.dart';
import 'package:sengthaite_blog/features/tool/http/http_request_builder.dart';
import 'package:sengthaite_blog/features/tool/http/http_utils/http_util_auth_view.dart';
import 'package:sengthaite_blog/features/tool/http/http_utils/http_util_body_view.dart';
import 'package:sengthaite_blog/features/tool/http/http_utils/http_util_header_view.dart';
import 'package:sengthaite_blog/features/tool/http/http_utils/http_util_param_view.dart';
import 'package:uuid/uuid.dart';

class HttpSettingItem {
  HttpSettingItem({
    required this.title,
    required this.item,
    this.isActive = false,
  });
  String id = Uuid().v4();
  String title;
  bool isActive = false;
  Widget item;
}

class HttpUtilView extends StatefulWidget {
  const HttpUtilView({
    super.key,
    required this.requestBuilder,
  });

  final HttpRequestBuilder requestBuilder;

  @override
  State<HttpUtilView> createState() => _HttpUtilViewState();
}

class _HttpUtilViewState extends State<HttpUtilView> {
  Map<String, HttpSettingItem> get getDrawerItems {
    Map<String, HttpSettingItem> result = {};
    for (var item in _drawerItemList) {
      result[item.id] = item;
    }
    return result;
  }

  final List<HttpSettingItem> _drawerItemList = [
    HttpSettingItem(
      title: "Request Builder",
      isActive: true,
      item: Text("Request builder"),
    ),
    HttpSettingItem(
      title: "Encryption",
      item: Text("Encryption"),
    ),
    HttpSettingItem(
      title: "Static Variables",
      item: Text("Static Variables"),
    ),
    HttpSettingItem(
      title: "Dynamic Variables",
      item: Text("Dynamic Variables"),
    ),
    HttpSettingItem(
      title: "Built-in Functions",
      item: Text("Built-in functions"),
    ),
    HttpSettingItem(
      title: "Custom Functions (Dart)",
      item: Text("Custom functions"),
    ),
    HttpSettingItem(
      title: "Logs",
      item: Text("Log"),
    ),
    HttpSettingItem(
      title: "Test",
      item: Text("Test"),
    ),
  ];

  Map<String, Widget> get tabData => {
        "Params": HttpUtilParamView(requestBuilder: widget.requestBuilder),
        "Authorization":
            HttpUtilAuthView(requestBuilder: widget.requestBuilder),
        "Headers": HttpUtilHeaderView(requestBuilder: widget.requestBuilder),
        "Body": HttpUtilBodyView(requestBuilder: widget.requestBuilder),
      };

  String? activeItemId;

  @override
  Widget build(BuildContext context) {
    var drawerItems = getDrawerItems;
    var drawerItemsList = drawerItems.entries.toList();
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
          automaticallyImplyLeading: true,
          bottom: TabBar(
            tabs: tabData.keys
                .map((e) => Tab(
                        child: Text(
                      e,
                      style: const TextStyle(fontSize: 11),
                    )))
                .toList(),
          ),
        ),
        body: TabBarView(
          children: tabData.values.toList(),
        ),
        drawer: Drawer(
          child: Column(
            children: [
              const DrawerHeader(
                child: Text(
                  "Settings",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              ...List.generate(drawerItems.length, (index) {
                var item = drawerItemsList[index];

                if (item.value.isActive) {
                  activeItemId = item.value.id;
                }
                return ListTile(
                  title: Text(
                    item.value.title,
                    style: TextStyle(
                        color: item.value.isActive ? Colors.blue : null),
                  ),
                  onTap: () {
                    if (activeItemId != null && activeItemId != item.value.id) {
                      setState(() {
                        drawerItems[activeItemId]!.isActive = false;
                        activeItemId = item.value.id;
                        item.value.isActive = true;
                      });
                    }
                  },
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
