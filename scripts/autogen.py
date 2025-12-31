import os
import datetime
import frontmatter
import json
import re

from pathlib import Path

ContentPath = "assets/contents"
IconPath = "assets/content_icons"


def has_headings(markdown_text):
    heading_pattern = r"^#{1,6}\s+"
    return bool(re.search(heading_pattern, markdown_text, flags=re.MULTILINE))


def content_dir_markdown(path):
    content_result = sorted(
        filter(
            lambda path: path.name.endswith(".txt"),
            os.scandir(path),
        ),
        key=lambda x: (x.is_file(), x.name),
    )
    final_result = []
    for result in enumerate(content_result):
        index = result[0]
        entry = result[1]
        stat_result = entry.stat()
        with open(entry.path, "r") as file:
            file_content = file.read()
            has_heading = has_headings(file_content)
            post = frontmatter.loads(file_content)
            final_result.append(
                {
                    "index": index,
                    "hasToc": has_heading,
                    "name": entry.name,
                    "title": post.get("title", ""),
                    "exerpt": post.get("exerpt", ""),
                    "full_path": "assets/" + entry.path,
                    "access_date": datetime.datetime.fromtimestamp(
                        stat_result.st_atime
                    ).isoformat(),
                    "modified_date": datetime.datetime.fromtimestamp(
                        stat_result.st_mtime
                    ).isoformat(),
                    "change_date": datetime.datetime.fromtimestamp(
                        stat_result.st_ctime
                    ).isoformat(),
                }
            )
    return final_result


def content_dir(path):
    content_result = sorted(os.scandir(path), key=lambda x: (x.is_dir(), x.name))
    final_result = []
    for result in enumerate(content_result):
        index = result[0]
        entry = result[1]
        stat_result = entry.stat()
        final_result.append(
            {
                "index": index,
                "name": entry.name,
                "path": entry.path,
                "access_date": datetime.datetime.fromtimestamp(
                    stat_result.st_atime
                ).isoformat(),
                "modified_date": datetime.datetime.fromtimestamp(
                    stat_result.st_mtime
                ).isoformat(),
                "change_date": datetime.datetime.fromtimestamp(
                    stat_result.st_ctime
                ).isoformat(),
            }
        )
    return final_result


autogenPath = Path("assets/autogen_meta")
autogenPath.mkdir(parents=True, exist_ok=True)

dashboardData = {
    "version": "v1.0.0",
    "author": "Te Sengthai",
    "created_date": datetime.datetime.now().isoformat(),
    "type": "dashboard",
    "data": [],
}
content_result = content_dir(ContentPath)
dashboardData["data"] = [
    {
        "index": res.get("index"),
        "name": res.get("name"),
        "path": res.get("path"),
        "created_date": res.get("change_date"),
        "icon": res.get("name") + ".svg",
        "files": content_dir_markdown(res.get("path")),
    }
    for res in content_result
]

with open("assets/autogen_meta/data_content.json", "w") as out_file:
    json.dump(dashboardData, out_file, sort_keys=True, indent=4, ensure_ascii=False)
