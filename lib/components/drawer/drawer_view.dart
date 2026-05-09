import 'package:flutter/material.dart';
import 'package:sengthaite_blog/constants/theme.dart';
import 'package:sengthaite_blog/l10n/app_localizations.dart';
import 'package:sengthaite_blog/shared/app.data.dart';
import 'package:sengthaite_blog/shared/data/appsetting.dart';

class DrawerView extends StatefulWidget {
  const DrawerView({super.key});

  @override
  State<DrawerView> createState() => _DrawerViewState();
}

class _DrawerViewState extends State<DrawerView> {
  AppSettings? get appSettings => AppData().appSettings;

  final List<DropdownMenuEntry<Locale>> menuEntries =
      <DropdownMenuEntry<Locale>>[
        DropdownMenuEntry(value: Locale('en', 'US'), label: 'English'),
        DropdownMenuEntry<Locale>(
          value: Locale('km', 'KH'),
          label: 'ភាសាខ្មែរ',
        ),
        DropdownMenuEntry<Locale>(value: Locale('zh', 'CN'), label: '中文'),
      ];

  Locale get locale => appSettings?.locale ?? Locale('en', 'US');

  @override
  Widget build(BuildContext context) {
    var appLocalization = AppLocalizations.of(context)!;
    return Drawer(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: 80,
            child: DrawerHeader(
              child: Text(
                appLocalization.settings,
                style: MaterialTheme.textTheme().titleMedium!.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: DropdownMenu(
              dropdownMenuEntries: menuEntries,
              initialSelection: locale,
              onSelected: (value) => setState(() {
                appSettings?.locale = value;
                AppData().saveAppSettings();
              }),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton.outlined(
              onPressed: () {
                AppData().appSettings?.delete();
              },
              icon: Text("Clear Cache"),
            ),
          ),
        ],
      ),
    );
  }
}
