import 'package:flutter/material.dart';
import 'package:sengthaite_blog/constants/theme.dart';
import 'package:sengthaite_blog/features/tool/api/api_encryption/api_encryption_view.dart';
import 'package:sengthaite_blog/features/tool/api/api_functions/api_func_view.dart';
import 'package:sengthaite_blog/features/tool/api/api_log/api_log_view.dart';
import 'package:sengthaite_blog/features/tool/api/api_utils/api_util_auth_view.dart';
import 'package:sengthaite_blog/features/tool/api/api_utils/api_util_body_view.dart';
import 'package:sengthaite_blog/features/tool/api/api_utils/api_util_header_view.dart';
import 'package:sengthaite_blog/features/tool/api/api_utils/api_util_param_view.dart';
import 'package:sengthaite_blog/features/tool/api/api_variables/api_live_variables_view.dart';
import 'package:sengthaite_blog/features/tool/api/api_variables/api_variables_view.dart';

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

enum SettingCode { requestBuilder, encryption, variable, func, log, test }

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
      title: "Variables",
      item: Text("Variables"),
      code: SettingCode.variable,
    ),
    APISettingItem(
      title: "Functions",
      item: Text("Functions"),
      code: SettingCode.func,
    ),
    APISettingItem(
      title: "Encryption",
      item: Text("Encryption"),
      code: SettingCode.encryption,
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
      case SettingCode.variable:
        return {
          "Live Variables": APILiveVariablesView(),
          "Variables": APIVariablesView(),
        };
      case SettingCode.func:
        return {
          "Functions": APIFuncView(),
        };
      case SettingCode.encryption:
        return {
          "Encryption Function": APIEncryptionView(),
        };

      case SettingCode.log:
        return {
          "API Logs": APILogView(),
        };
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

  var textTheme = MaterialTheme.textTheme();

  @override
  Widget build(BuildContext context) {
    var drawerItems = getDrawerItems;
    var drawerItemsList = drawerItems.entries.toList();
    return DefaultTabController(
      length: tabData.length,
      initialIndex: 0,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "HTTP Request",
            style: textTheme.bodyMedium!.copyWith(
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
                      style: textTheme.bodyMedium!.copyWith(fontSize: 11),
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
               DrawerHeader(
                child: Text(
                  "Settings",
                  style: textTheme.bodyMedium!.copyWith(
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
                    style: textTheme.bodyMedium!.copyWith(
                        color: item.value.isActive ? Colors.blue : null),
                  ),
                  onTap: () {
                    if (activeItemCode != null &&
                        activeItemCode != item.value.code) {
                      setState(() {
                        drawerItems[activeItemCode]!.isActive = false;
                        activeItemCode = item.value.code;
                        item.value.isActive = true;
                        Navigator.pop(context);
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
