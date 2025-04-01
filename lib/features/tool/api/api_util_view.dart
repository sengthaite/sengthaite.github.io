import 'package:flutter/material.dart';
import 'package:sengthaite_blog/features/tool/api/api_utils/api_util_auth_view.dart';
import 'package:sengthaite_blog/features/tool/api/api_utils/api_util_body_view.dart';
import 'package:sengthaite_blog/features/tool/api/api_utils/api_util_header_view.dart';
import 'package:sengthaite_blog/features/tool/api/api_utils/api_util_param_view.dart';
import 'package:sengthaite_blog/features/tool/api/api_variables/api_static_variables_view.dart';

class APISettingItem {
  APISettingItem({
    required this.title,
    required this.item,
    required this.code,
    this.isActive = false,
  });
  SettingCode code;
  String title;
  bool isActive = false;
  Widget item;
}

enum SettingCode {
  requestBuilder,
  encryption,
  staticVariable,
  dynamicVariable,
  buildInFunc,
  customFunc,
  log,
  test
}

class APIUtilView extends StatefulWidget {
  const APIUtilView({
    super.key,
  });

  @override
  State<APIUtilView> createState() => _APIUtilViewState();
}

class _APIUtilViewState extends State<APIUtilView> {
  Map<SettingCode, APISettingItem> get getDrawerItems {
    Map<SettingCode, APISettingItem> result = {};
    for (var item in _drawerItemList) {
      result[item.code] = item;
    }
    return result;
  }

  final List<APISettingItem> _drawerItemList = [
    APISettingItem(
      title: "Request Builder",
      isActive: true,
      item: Text("Request builder"),
      code: SettingCode.requestBuilder,
    ),
    APISettingItem(
      title: "Encryption",
      item: Text("Encryption"),
      code: SettingCode.encryption,
    ),
    APISettingItem(
      title: "Static Variables",
      item: Text("Static Variables"),
      code: SettingCode.staticVariable,
    ),
    APISettingItem(
      title: "Dynamic Variables",
      item: Text("Dynamic Variables"),
      code: SettingCode.dynamicVariable,
    ),
    APISettingItem(
      title: "Built-in Functions",
      item: Text("Built-in functions"),
      code: SettingCode.buildInFunc,
    ),
    APISettingItem(
      title: "Custom Functions (Dart)",
      item: Text("Custom functions"),
      code: SettingCode.customFunc,
    ),
    APISettingItem(
      title: "Logs",
      item: Text("Log"),
      code: SettingCode.log,
    ),
    APISettingItem(
      title: "Test",
      item: Text("Test"),
      code: SettingCode.test,
    ),
  ];

  Map<String, Widget> get tabData {
    switch (activeItemCode) {
      case SettingCode.requestBuilder:
        return {
          "Params": APIUtilParamView(),
          "Authorization": APIUtilAuthView(),
          "Headers": APIUtilHeaderView(),
          "Body": APIUtilBodyView(),
        };
      case SettingCode.encryption:
      case SettingCode.staticVariable:
        return {
          "Static Variables": APIStaticVariablesView(),
        };
      case SettingCode.dynamicVariable:
      case SettingCode.buildInFunc:
      case SettingCode.customFunc:
      case SettingCode.log:
      case SettingCode.test:
      default:
        return {
          "Params": APIUtilParamView(),
          "Authorization": APIUtilAuthView(),
          "Headers": APIUtilHeaderView(),
          "Body": APIUtilBodyView(),
        };
    }
  }

  SettingCode? activeItemCode;

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
                  activeItemCode = item.value.code;
                }
                return ListTile(
                  title: Text(
                    item.value.title,
                    style: TextStyle(
                        color: item.value.isActive ? Colors.blue : null),
                  ),
                  onTap: () {
                    if (activeItemCode != null &&
                        activeItemCode != item.value.code) {
                      setState(() {
                        drawerItems[activeItemCode]!.isActive = false;
                        activeItemCode = item.value.code;
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
