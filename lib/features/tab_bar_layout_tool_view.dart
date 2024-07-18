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
  TabBarLayoutToolView({super.key, required this.hideBottomAppBar})
      : super(section: TabSection.tool, hideBottomBar: hideBottomAppBar);

  final bool hideBottomAppBar;

  final QuillController _controller = QuillController.basic();

  List<ToolItemModel> toolList() {
    return [
      ToolItemModel(
        index: 0,
        title: "Text editor",
        widgetBuilder: (context) => AppLayout(
          context: context,
          defaultWidget: TextEditorToolDesktop(controller: _controller),
          mobileWidget: TextEditorToolMobile(controller: _controller),
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
          actions: [
            IconButton(
              icon: const Icon(Icons.extension),
              onPressed: () {
                var context = Navigation().tabBarDetailContext;
                if (context == null) return;
                showModalBottomSheet(
                    context: context,
                    showDragHandle: true,
                    builder: (context) {
                      return Padding(
                        padding: const EdgeInsets.only(
                            left: 4, right: 4, top: 4, bottom: 8),
                        child: QuillToolbar.simple(
                          configurations: QuillSimpleToolbarConfigurations(
                            controller: _controller,
                            toolbarIconAlignment: WrapAlignment.start,
                            toolbarIconCrossAlignment: WrapCrossAlignment.start,
                            sharedConfigurations:
                                const QuillSharedConfigurations(
                              locale: Locale('en'),
                            ),
                          ),
                        ),
                      );
                    });
              },
            ),
          ],
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
