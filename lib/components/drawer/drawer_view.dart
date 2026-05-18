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

  @override
  Widget build(BuildContext context) {
    var appLocalization = AppLocalizations.of(context)!;
    var colorScheme = MaterialTheme.colorScheme(context);
    return ValueListenableBuilder(
      valueListenable:
          appSettings?.currentLocale ?? ValueNotifier(const Locale('en', 'US')),
      builder: (context, locale, child) => Drawer(
        child: SafeArea(
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
                      color: colorScheme.primary,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: DropdownMenu(
                  dropdownMenuEntries: menuEntries,
                  textStyle: MaterialTheme.textTheme().labelSmall?.copyWith(
                    color: colorScheme.onSurface,
                  ),
                  initialSelection: locale,
                  onSelected: (value) => setState(() {
                    appSettings?.locale = value;
                    AppData().saveAppSettings();
                  }),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: IconButton(
                  onPressed: () {
                    AppData().appSettings?.delete();
                  },
                  icon: Text("Clear Cache"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
