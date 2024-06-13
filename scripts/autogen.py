import os
import datetime
import frontmatter
import json

from pathlib import Path

ContentPath = "assets/contents"
IconPath = "assets/content_icons"


def contentDirMarkdown(path):
    contentResult = sorted(
        filter(
            lambda path: path.name.endswith(".txt"),
            os.scandir(path),
        ),
        key=lambda x: (x.is_file(), x.name),
    )
    finalResult = []
    for result in enumerate(contentResult):
        index = result[0]
        entry = result[1]
        statResult = entry.stat()
        with open(entry.path, "r") as file:
            post = frontmatter.loads(file.read())
            finalResult.append(
                {
                    "index": index,
                    "name": entry.name,
                    "title": post.get("title", ""),
                    "exerpt": post.get("exerpt", ""),
                    "full_path": entry.path,
                    "access_date": datetime.datetime.fromtimestamp(
                        statResult.st_atime
                    ).isoformat(),
                    "modified_date": datetime.datetime.fromtimestamp(
                        statResult.st_mtime
                    ).isoformat(),
                    "change_date": datetime.datetime.fromtimestamp(
                        statResult.st_ctime
                    ).isoformat(),
                }
            )
    return finalResult


def contentDir(path):
    contentResult = sorted(os.scandir(path), key=lambda x: (x.is_dir(), x.name))
    finalResult = []
    for result in enumerate(contentResult):
        index = result[0]
        entry = result[1]
        statResult = entry.stat()
        finalResult.append(
            {
                "index": index,
                "name": entry.name,
                "path": entry.path,
                "access_date": datetime.datetime.fromtimestamp(
                    statResult.st_atime
                ).isoformat(),
                "modified_date": datetime.datetime.fromtimestamp(
                    statResult.st_mtime
                ).isoformat(),
                "change_date": datetime.datetime.fromtimestamp(
                    statResult.st_ctime
                ).isoformat(),
            }
        )
    return finalResult


autogenPath = Path("assets/autogen_meta")
autogenPath.mkdir(parents=True, exist_ok=True)

dashboardData = {
    "version": "v1.0.0",
    "author": "Te Sengthai",
    "created_date": datetime.datetime.now().isoformat(),
    "type": "dashboard",
    "data": [],
}
contentResult = contentDir(ContentPath)
dashboardData["data"] = list(
    map(
        lambda res: {
            "index": res.get("index"),
            "name": res.get("name"),
            "path": res.get("path"),
            "created_date": res.get("change_date"),
            "icon": res.get("name") + ".svg",
            "files": contentDirMarkdown(res.get("path", "")),
        },
        contentResult,
    )
)

with open("assets/autogen_meta/data_content.json", "w") as out_file:
    json.dump(dashboardData, out_file, sort_keys=True, indent=4, ensure_ascii=False)
