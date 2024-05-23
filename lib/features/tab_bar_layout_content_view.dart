import 'package:cosmic_frontmatter/cosmic_frontmatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sengthaite_blog/app.model.dart';
import 'package:sengthaite_blog/components/category_item_icon.dart';
import 'package:sengthaite_blog/components/markdown_view.dart';
import 'package:sengthaite_blog/components/tab_bar_layout_view.dart';
import 'package:sengthaite_blog/components/tab_bar_navigation_title.dart';
import 'package:sengthaite_blog/constants/enum.constants.dart';
import 'package:sengthaite_blog/constants/image.constants.dart';
import 'package:sengthaite_blog/extensions/datetime_ext.dart';
import 'package:sengthaite_blog/features/content/tab_bar_detail_view.dart';
import 'package:sengthaite_blog/features/navigation/navigation.dart';
import 'package:sengthaite_blog/generated/app_model_frontmatter.dart';
import 'package:sengthaite_blog/shared/app.data.dart';

class TabBarLayoutContentView extends TabBarLayoutView {
  const TabBarLayoutContentView({super.key})
      : super(section: TabSection.content);

  Future<Document<AppModelFrontmatter>?> _getMarkdownFromPath(
      String? path) async {
    if (path == null) return null;
    if (path.trim().isEmpty) return null;
    var content = await rootBundle.loadString(path);
    try {
      return parseFrontmatter(
        content: content,
        frontmatterBuilder: (map) => AppModelFrontmatter.fromJson(map),
      );
    } catch (error) {
      return Future(
        () => Document(frontmatter: const AppModelFrontmatter(), body: content),
      );
    }
  }

  CategoryTabItemModel _mapTabItem(FileElement data) {
    String title = data.title ?? '';
    return CategoryTabItemModel(
      title: title,
      date: data.modifiedDate?.formatDateDisplay ?? '',
      description: data.exerpt ?? 'No description available.',
      onTap: () async {
        var document = await _getMarkdownFromPath(data.fullPath);
        Navigation().contentTabState?.addItem(
              TabBarNavigationTitle(
                title: title,
                index: data.index ?? 0,
                widget: TabBarDetailView(
                  title: title,
                  widget: Expanded(
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: MarkdownView(
                          markdown: document?.body ?? '',
                        ),
                      ),
                    ),
                  ),
                  onBackPressed: () =>
                      Navigation().contentTabState?.removeLast(),
                ),
              ),
            );
      },
    );
  }

  TabBarLayoutViewItem _mapItem(Datum item) {
    var title = item.name ?? '';
    return TabBarLayoutViewItem(
      itemTitle: TabBarNavigationTitle(
        title: title,
        index: item.index ?? 0,
        onTap: (e) => Navigation().contentTabState?.removeUntil(e),
        widget: TabBarDetailView(
          title: title,
          items: (item.files ?? []).map((e) => _mapTabItem(e)).toList(),
          onBackPressed: () => Navigation().contentTabState?.removeLast(),
        ),
      ),
      itemWidget: CategoryItemIcon(
        image: AssetIcons.fromImageName(item.icon ?? '').image,
        title: title,
      ),
    );
  }

  @override
  List<TabBarLayoutViewItem> get categories {
    var list = AppData().model?.data ?? [];
    if (list.isEmpty) return [];
    return list.map((e) => _mapItem(e)).toList();
  }
}
