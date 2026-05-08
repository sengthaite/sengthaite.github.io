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

    factory GitListRepoData.fromJson(Map<String, dynamic> json) => GitListRepoData(
        name: json["name"],
        path: json["path"],
        sha: json["sha"],
        size: json["size"],
        url: json["url"],
        htmlUrl: json["html_url"],
        gitUrl: json["git_url"],
        downloadUrl: json["download_url"],
        type: json["type"],
        links: json["_links"] == null ? null : Links.fromJson(json["_links"]),
        entries: json["entries"] == null ? [] : List<GitListRepoData>.from(json["entries"]!.map((x) => GitListRepoData.fromJson(x))),
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
        "entries": entries == null ? [] : List<dynamic>.from(entries!.map((x) => x.toJson())),
    };
}

class Links {
    String? self;
    String? git;
    String? html;

    Links({
        this.self,
        this.git,
        this.html,
    });

    factory Links.fromJson(Map<String, dynamic> json) => Links(
        self: json["self"],
        git: json["git"],
        html: json["html"],
    );

    Map<String, dynamic> toJson() => {
        "self": self,
        "git": git,
        "html": html,
    };
}
