import 'package:flutter/material.dart';
import 'package:sengthaite_blog/constants/app.constants.dart';
import 'package:sengthaite_blog/constants/image.constants.dart';
import 'package:sengthaite_blog/features/personal/personal_git_view.dart';
import 'package:sengthaite_blog/l10n/app_localizations.dart';
import 'package:sengthaite_blog/shared/app.data.dart';
import 'package:sengthaite_blog/shared/data/appsetting.dart';
import 'package:sengthaite_blog/shared/dialog/github_login_dialog.dart';

import '../../extensions/build_context_ext.dart';

class AppBarViewTab extends StatefulWidget implements PreferredSizeWidget {
  const AppBarViewTab({super.key});

  @override
  State<AppBarViewTab> createState() => _AppBarViewTabState();

  @override
  Size get preferredSize => const Size.fromHeight(120);
}

class _AppBarViewTabState extends State<AppBarViewTab> {
  AppSettings? get appSettings => AppData().appSettings;

  void showGitContentDetail(BuildContext context) {
    bool isRememberedMe = appSettings?.isRememberedMe ?? false;
    String githubToken = appSettings?.githubToken ?? '';
    String githubUrl = appSettings?.githubUrl ?? '';
    if (isRememberedMe && githubToken.isNotEmpty && githubUrl.isNotEmpty) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              PersonalGitView(url: githubUrl, path: "", token: githubToken),
          fullscreenDialog: true,
        ),
      );
      return;
    }
    showGithubLoginDialog(
      onSuccess: (response) {
        Navigator.pop(context);
        if (response == null) {
          return;
        }
        Map<String, dynamic> result = response as Map<String, dynamic>;
        String? url = response['url'];
        String? token = response['token'];
        if (result.isEmpty || url == null || token == null) {
          debugPrint("Empty repos");
          return;
        }
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PersonalGitView(
              url: response['url'],
              path: "",
              token: response['token'],
            ),
            fullscreenDialog: true,
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    var appLocalization = AppLocalizations.of(context)!;

    return AppBar(
      centerTitle: true,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          GestureDetector(
            onDoubleTap: () => showGitContentDetail(context),
            onLongPress: () => showGitContentDetail(context),
            child: AssetIcons.logo.image,
          ),
          const SizedBox(width: 20),
          Text(
            appTitle,
            style: context.textTheme.titleLarge!.copyWith(
              color: context.colorScheme.primary,
            ),
          ),
        ],
      ),
      bottom: TabBar(
        isScrollable: false,
        physics: const NeverScrollableScrollPhysics(),
        overlayColor: WidgetStateProperty.all(Colors.transparent),
        padding: EdgeInsets.symmetric(
          horizontal: screenSize.width > 1100 ? screenSize.width * 0.35 : 20,
        ),
        indicatorSize: TabBarIndicatorSize.tab,
        dividerColor: Colors.transparent,
        tabs: [
          Tab(text: appLocalization.article),
          Tab(text: appLocalization.tool),
          Tab(text: appLocalization.project),
        ],
      ),
    );
  }
}
