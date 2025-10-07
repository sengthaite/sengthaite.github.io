import 'package:cosmic_frontmatter/cosmic_frontmatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:markdown_widget/config/all.dart';
import 'package:markdown_widget/widget/blocks/leaf/heading.dart';
import 'package:markdown_widget/widget/widget_visitor.dart';
import 'package:sengthaite_blog/components/category_item_icon.dart';
import 'package:sengthaite_blog/components/tab_bar_layout_view.dart';
import 'package:sengthaite_blog/components/tab_bar_navigation_title.dart';
import 'package:sengthaite_blog/constants/enum.constants.dart';
import 'package:sengthaite_blog/constants/image.constants.dart';
import 'package:sengthaite_blog/extensions/datetime_ext.dart';
import 'package:sengthaite_blog/extensions/string_ext.dart';
import 'package:sengthaite_blog/features/content/tab_bar_detail_view.dart';
import 'package:sengthaite_blog/features/navigation/navigation.dart';
import 'package:sengthaite_blog/features/tool/markdown_view/markdown_view_desktop.dart';
import 'package:sengthaite_blog/features/tool/markdown_view/markdown_view_mobile.dart';
import 'package:sengthaite_blog/generated/app_model_frontmatter.dart';
import 'package:sengthaite_blog/generated/models/app_model.dart';
import 'package:sengthaite_blog/generated/models/category_tab_item_model.dart';
import 'package:sengthaite_blog/shared/app.data.dart';
import 'package:sengthaite_blog/shared/app.layout.dart';

class TabBarLayoutContentView extends TabBarLayoutView {
  const TabBarLayoutContentView({super.key, required this.hideBottomAppBar})
      : super(section: TabSection.content, hideBottomBar: hideBottomAppBar);

  final bool hideBottomAppBar;

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
        () => Document(
          frontmatter: const AppModelFrontmatter(),
          body: content,
        ),
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
        TocController? tocController = data.hasToc ?? false
            ? (TocController()
              ..setTocList(
                  [Toc(node: HeadingNode(const H1Config(), WidgetVisitor()))]))
            : null;
        Navigation().contentTabState?.addItem(
              TabBarNavigationTitle(
                title: title,
                index: data.index ?? 0,
                widget: TabBarDetailView(
                  title: title,
                  endDrawer: data.hasToc ?? false
                      ? Drawer(
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(8),
                              bottomLeft: Radius.circular(8),
                            ),
                          ),
                          child: Column(
                            children: [
                              const Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 4, vertical: 10),
                                child: Text(
                                  "Table of Content",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 4,
                              ),
                              Expanded(
                                child: TocWidget(
                                  physics: BouncingScrollPhysics(),
                                  controller: tocController!,
                                ),
                              ),
                            ],
                          ),
                        )
                      : null,
                  widget: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Builder(
                      builder: (context) => AppLayout(
                        context: context,
                        defaultWidget: MarkdownViewDesktop(
                          markdown: document?.body ?? '',
                          tocController: tocController,
                        ),
                        mobileWidget: MarkdownViewMobile(
                          markdown: document?.body ?? '',
                          tocController: tocController,
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
        title: title.toTitle(),
        index: item.index ?? 0,
        onTap: (e) => Navigation().contentTabState?.removeUntil(e),
        widget: TabBarDetailView(
          title: title.toTitle(),
          items: (item.files ?? []).map((e) => _mapTabItem(e)).toList(),
          onBackPressed: () => Navigation().contentTabState?.removeLast(),
        ),
      ),
      itemWidget: CategoryItemIcon(
        image: AssetIcons.fromImageName(item.icon ?? '').image,
        title: title.toTitle(),
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
