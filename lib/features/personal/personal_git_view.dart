import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:sengthaite_blog/features/personal/personal_git.data.dart';
import 'package:sengthaite_blog/features/tool/api/github/github_api.dart';
import 'package:sengthaite_blog/shared/app.data.dart';

class PersonalGitView extends StatefulWidget {
  const PersonalGitView({super.key, required this.url, required this.token});

  final String url;
  final String token;

  @override
  State<PersonalGitView> createState() => _PersonalGitViewState();
}

class _PersonalGitViewState extends State<PersonalGitView> {
  GitListRepoData list = GitListRepoData();

  @override
  void initState() {
    setState(() async {
      var githubApi = GithubAPI(personalAccessToken: widget.token);
      list = await githubApi.listRepos(url: widget.url);
    });
    super.initState();
  }

  void showGitContentDetail(BuildContext context, String? baseUrl) => Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => PersonalGitView(url: baseUrl!, token: widget.token),
                                          fullscreenDialog: true,
                                        ),
                                      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: list.isEmpty
          ? Center(child: Text("No content available"))
          : GridView.extent(
              maxCrossAxisExtent: 150,
              shrinkWrap: true,
              children: List.generate(list.length, (index) {
                var item = list.entries!.elementAt(index);
                return Center(
                  child: IconButton.outlined(
                    onPressed: () async {
                      if (item.isDirectory) {
                        AppData().isLoading.value = true;
                        var fullUrl = "${widget.url}/${item.path}";
                        showGitContentDetail(context, fullUrl);
                        AppData().isLoading.value = false;
                      }
                    },
                    icon: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text("${item.name}"),
                        Icon(
                          item.isDirectory ? MdiIcons.folder : MdiIcons.file,
                        ),
                      ],
                    ),
                  ),
                );
              }),
            ),
    );
  }
}
