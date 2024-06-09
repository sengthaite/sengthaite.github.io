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
import 'package:sengthaite_blog/models/tool_model.dart';

class TabBarLayoutToolView extends TabBarLayoutView {
  const TabBarLayoutToolView({super.key}) : super(section: TabSection.tool);

  List<ToolItemModel> toolList() {
    QuillController controller = QuillController.basic();

    final textEditor = Column(
      children: [
        QuillToolbar.simple(
          configurations: QuillSimpleToolbarConfigurations(
            controller: controller,
            sharedConfigurations: const QuillSharedConfigurations(
              locale: Locale('en'),
            ),
          ),
        ),
        LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            double height = MediaQuery.of(context).size.height * 0.53;

            return QuillEditor.basic(
              configurations: QuillEditorConfigurations(
                controller: controller,
                minHeight: 200,
                maxHeight: height,
                sharedConfigurations: const QuillSharedConfigurations(
                  locale: Locale('en'),
                ),
              ),
            );
          },
        )
      ],
    );

    return [
      ToolItemModel(
        index: 0,
        title: "Text editor",
        widget: textEditor,
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
          widget: item.widget,
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
