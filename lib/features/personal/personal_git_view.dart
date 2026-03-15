import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:sengthaite_blog/features/personal/personal_git.data.dart';
import 'package:sengthaite_blog/features/tool/api/github/github_api.dart';
import 'package:sengthaite_blog/shared/app.data.dart';

class PersonalGitView extends StatefulWidget {
  const PersonalGitView({
    super.key,
    required this.url,
    required this.path,
    required this.token,
  });

  final String url;
  final String path;
  final String token;

  @override
  State<PersonalGitView> createState() => _PersonalGitViewState();
}

class _PersonalGitViewState extends State<PersonalGitView> {
  GitListRepoData list = GitListRepoData();

  @override
  void initState() {
    super.initState();
    fetchGitContent();
  }

  void fetchGitContent() async {
    if (!mounted) return;
    var githubApi = GithubAPI(personalAccessToken: widget.token);
    var data = await githubApi.listRepos(url: "${widget.url}/${widget.path}");
    list = GitListRepoData.fromJson(data);
    setState(() {});
  }

  void showGitContentDetail(
    BuildContext context,
    String baseUrl,
    String path,
  ) => Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) =>
          PersonalGitView(url: baseUrl, path: path, token: widget.token),
      fullscreenDialog: true,
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: list.isEmpty
          ? Center(child: Text("No content available"))
          : SingleChildScrollView(
              child: Wrap(
                spacing: 10,
                runSpacing: 10,
                alignment: WrapAlignment.spaceEvenly,
                children: List.generate(list.length, (index) {
                  var item = list.entries!.elementAt(index);
                  return IconButton.outlined(
                    onPressed: () async {
                      if (item.isDirectory) {
                        AppData().isLoading.value = true;
                        showGitContentDetail(context, widget.url, item.path!);
                        AppData().isLoading.value = false;
                      } else if (item.isFile && item.downloadUrl != null) {
                        AppData().isLoading.value = true;
                        // await launchUrl(Uri.parse(item.downloadUrl!));
                        // var dio = Dio(
                        //   BaseOptions(
                        //     headers: {
                        //       "Accept": "application/vnd.github.v3.raw",
                        //     },
                        //     receiveDataWhenStatusError: true,
                        //     followRedirects: true,
                        //     maxRedirects: 3,
                        //     persistentConnection: true,
                        //   ),
                        // );
                        // dio.get
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
                  );
                }),
              ),
            ),
    );
  }
}
