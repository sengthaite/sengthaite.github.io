import 'package:flutter/material.dart';
import 'package:sengthaite_blog/features/tool/api/api_utils/api_util_auth_view.dart';
import 'package:sengthaite_blog/features/tool/api/api_utils/api_util_body_view.dart';
import 'package:sengthaite_blog/features/tool/api/api_utils/api_util_header_view.dart';
import 'package:sengthaite_blog/features/tool/api/api_utils/api_util_param_view.dart';
import 'package:uuid/uuid.dart';

class APISettingItem {
  APISettingItem({
    required this.title,
    required this.item,
    this.isActive = false,
  });
  String id = Uuid().v4();
  String title;
  bool isActive = false;
  Widget item;
}

class APIUtilView extends StatefulWidget {
  const APIUtilView({
    super.key,
  });

  @override
  State<APIUtilView> createState() => _APIUtilViewState();
}

class _APIUtilViewState extends State<APIUtilView> {
  Map<String, APISettingItem> get getDrawerItems {
    Map<String, APISettingItem> result = {};
    for (var item in _drawerItemList) {
      result[item.id] = item;
    }
    return result;
  }

  final List<APISettingItem> _drawerItemList = [
    APISettingItem(
      title: "Request Builder",
      isActive: true,
      item: Text("Request builder"),
    ),
    APISettingItem(
      title: "Encryption",
      item: Text("Encryption"),
    ),
    APISettingItem(
      title: "Static Variables",
      item: Text("Static Variables"),
    ),
    APISettingItem(
      title: "Dynamic Variables",
      item: Text("Dynamic Variables"),
    ),
    APISettingItem(
      title: "Built-in Functions",
      item: Text("Built-in functions"),
    ),
    APISettingItem(
      title: "Custom Functions (Dart)",
      item: Text("Custom functions"),
    ),
    APISettingItem(
      title: "Logs",
      item: Text("Log"),
    ),
    APISettingItem(
      title: "Test",
      item: Text("Test"),
    ),
  ];

  Map<String, Widget> get tabData => {
        "Params": APIUtilParamView(),
        "Authorization": APIUtilAuthView(),
        "Headers": APIUtilHeaderView(),
        "Body": APIUtilBodyView(),
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
