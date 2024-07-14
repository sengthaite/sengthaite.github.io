import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:sengthaite_blog/components/category_item_icon.dart';
import 'package:sengthaite_blog/components/tab_bar_layout_view.dart';
import 'package:sengthaite_blog/components/tab_bar_navigation_title.dart';
import 'package:sengthaite_blog/constants/enum.constants.dart';
import 'package:sengthaite_blog/constants/image.constants.dart';
import 'package:sengthaite_blog/extensions/string_ext.dart';
import 'package:sengthaite_blog/features/content/tab_bar_detail_view.dart';
import 'package:sengthaite_blog/features/navigation/navigation.dart';
import 'package:sengthaite_blog/features/tool/text_editor/text_editor_tool_desktop.dart';
import 'package:sengthaite_blog/features/tool/text_editor/text_editor_tool_mobile.dart';
import 'package:sengthaite_blog/models/tool_model.dart';
import 'package:sengthaite_blog/shared/app.layout.dart';

class TabBarLayoutToolView extends TabBarLayoutView {
  const TabBarLayoutToolView({super.key}) : super(section: TabSection.tool);

  List<ToolItemModel> toolList() {
    return [
      ToolItemModel(
        index: 0,
        title: "Text editor",
        widgetBuilder: (context) => AppLayout(
          context: context,
          defaultWidget: TextEditorToolDesktop(
            controller: QuillController.basic(),
          ),
          mobileWidget:
              TextEditorToolMobile(controller: QuillController.basic()),
        ),
      ),
    ];
  }

  TabBarLayoutViewItem _mapItem(ToolItemModel item) {
    var title = item.title;
    return TabBarLayoutViewItem(
      itemTitle: TabBarNavigationTitle(
        title: title.toTitle(),
        index: item.index,
        onTap: (e) => Navigation().toolTabState?.removeUntil(e),
        widget: TabBarDetailView(
          title: title.toTitle(),
          widget: item.widgetBuilder != null
              ? Builder(builder: item.widgetBuilder!)
              : item.widget,
          onBackPressed: () => Navigation().toolTabState?.removeLast(),
        ),
      ),
      itemWidget: CategoryItemIcon(
        image: AssetIcons.textEditor.image,
        title: title.toTitle(),
      ),
    );
  }

  @override
  List<TabBarLayoutViewItem> get categories {
    final list = toolList();
    if (list.isEmpty) return [];
    return list.map((e) => _mapItem(e)).toList();
  }
}
