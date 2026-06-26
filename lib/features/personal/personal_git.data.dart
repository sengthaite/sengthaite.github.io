class GitListRepoData {
  String? name;
  String? path;
  String? sha;
  int? size;
  String? url;
  String? htmlUrl;
  String? gitUrl;
  String? downloadUrl;
  String? type;
  Links? links;
  List<GitListRepoData>? entries;

  int get length => entries?.length ?? 0;

  bool get isEmpty => entries == null || entries!.isEmpty;

  bool get isDirectory => type == "dir";

  bool get isFile => type == "file";

  GitListRepoData({
    this.name,
    this.path,
    this.sha,
    this.size,
    this.url,
    this.htmlUrl,
    this.gitUrl,
    this.downloadUrl,
    this.type,
    this.links,
    this.entries,
  });

  factory GitListRepoData.fromJson(Map<String, dynamic> json) =>
      GitListRepoData(
        name: json["name"] as String?,
        path: json["path"] as String?,
        sha: json["sha"] as String?,
        size: json["size"] as int?,
        url: json["url"] as String?,
        htmlUrl: json["html_url"] as String?,
        gitUrl: json["git_url"] as String?,
        downloadUrl: json["download_url"] as String?,
        type: json["type"] as String?,
        links: json["_links"] == null
            ? null
            : Links.fromJson(json["_links"] as Map<String, String?>),
        entries: json["entries"] == null
            ? []
            : List<GitListRepoData>.from(
                (json["entries"]! as List<Map<String, dynamic>>).map(
                  (x) => GitListRepoData.fromJson(x),
                ),
              ),
      );

  Map<String, dynamic> toJson() => {
    "name": name,
    "path": path,
    "sha": sha,
    "size": size,
    "url": url,
    "html_url": htmlUrl,
    "git_url": gitUrl,
    "download_url": downloadUrl,
    "type": type,
    "_links": links?.toJson(),
    "entries": entries == null
        ? List<Map<String, dynamic>>.empty()
        : List<Map<String, dynamic>>.from(entries!.map((x) => x.toJson())),
  };
}

class Links {
  String? self;
  String? git;
  String? html;

  Links({this.self, this.git, this.html});

  factory Links.fromJson(Map<String, dynamic> json) => Links(
    self: json["self"] as String?,
    git: json["git"] as String?,
    html: json["html"] as String?,
  );

  Map<String, dynamic> toJson() => {"self": self, "git": git, "html": html};
}
