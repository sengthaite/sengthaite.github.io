import 'package:flutter/material.dart';
import 'package:sengthaite_blog/constants/image.constants.dart';
import 'package:sengthaite_blog/extensions/file_picker.dart';
import 'package:sengthaite_blog/features/navigation/navigation.dart';
import 'package:sengthaite_blog/features/tool/api/github/github_api.dart';
import 'package:sengthaite_blog/shared/app.data.dart';

void showGithubLoginDialog({Function(dynamic value)? onSuccess}) {
  final formKey = GlobalKey<FormState>();
  showDialog(
    context: Navigation().context,
    builder: (context) {
      return GithubLoginWidget(formKey: formKey, onSuccess: onSuccess);
    },
  );
}

class GithubLoginWidget extends StatefulWidget {
  const GithubLoginWidget({super.key, required this.formKey, this.onSuccess});

  final Function(dynamic value)? onSuccess;
  final GlobalKey<FormState> formKey;

  @override
  State<GithubLoginWidget> createState() => _GithubLoginWidgetState();
}

class _GithubLoginWidgetState extends State<GithubLoginWidget> {
  bool rememberedMe = false;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      icon: AssetIcons.github.image,
      title: Text("Github Login"),
      content: Form(
        key: widget.formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton.outlined(
              onPressed: () async {
                String? fileContent = await openFilePicker();
                if (fileContent == null) {
                  debugPrint("Invalid file");
                  return;
                }
                if (widget.onSuccess != null) {
                  var githubApi = GithubAPI(personalAccessToken: fileContent);
                  var repos = await githubApi.listRepos();
                  if (repos.isEmpty) {
                    debugPrint("Empty repos");
                    return;
                  }
                  if (rememberedMe) {
                    AppData().appSettings?.githubToken = fileContent;
                    AppData().saveAppSettings();
                  }
                  widget.onSuccess!(repos);
                }
              },
              icon: Text("Auth File"),
            ),
            SizedBox(height: 8),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Checkbox(
                  value: rememberedMe,
                  onChanged: (value) {
                    setState(() {
                      rememberedMe = value ?? false;
                    });
                  },
                ),
                SizedBox(width: 8),
                Text("Remember Me")
              ],
            ),
          ],
        ),
      )
    );
  }
}
