import 'package:flutter/material.dart';
import 'package:sengthaite_blog/components/blog/category_tab_item_view.dart';
import 'package:sengthaite_blog/extensions/build_context_ext.dart';
import 'package:sengthaite_blog/generated/models/category_tab_item_model.dart';

class TabBarDetailView extends StatelessWidget {
  const TabBarDetailView({
    super.key,
    required this.title,
    this.items,
    this.widget,
    this.widgetBuilder,
    this.futureBuilder,
    this.onBackPressed,
    this.endDrawer,
    this.actions,
  });

  final String title;
  final List<CategoryTabItemModel>? items;
  final Widget? widget;
  final WidgetBuilder? widgetBuilder;
  final FutureBuilder<dynamic>? futureBuilder;
  final void Function()? onBackPressed;
  final Widget? endDrawer;
  final List<Widget>? actions;

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(
      builder: (context, orientation) {
        var colorScheme = context.colorScheme;
        var textStyle = context.textTheme.titleMedium;
        return Scaffold(
          endDrawer: endDrawer,
          appBar: AppBar(
            surfaceTintColor: Colors.transparent,
            actions: actions,
            title: Text(
              softWrap: true,
              title,
              style: textStyle!.copyWith(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: colorScheme.onSurface,
              ),
            ),
            leading: IconButton(
              color: colorScheme.onSurface,
              hoverColor: colorScheme.surfaceDim,
              onPressed: onBackPressed,
              icon: Icon(Icons.arrow_back, color: colorScheme.primary),
            ),
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (widget != null)
                Expanded(
                  child: Container(
                    color: Theme.of(context).cardColor,
                    child: widget,
                  ),
                )
              else if (widgetBuilder != null)
                Expanded(child: Builder(builder: widgetBuilder!))
              else if (futureBuilder != null)
                Expanded(child: futureBuilder!),
              if (items != null)
                Expanded(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: Wrap(
                        alignment: orientation == Orientation.landscape
                            ? WrapAlignment.start
                            : WrapAlignment.center,
                        spacing: 12,
                        runSpacing: 12,
                        children: items!
                            .map(
                              (e) => InkWell(
                                onTap: e.onTap,
                                hoverColor: Colors.transparent,
                                child: CategoryTabItemView(item: e),
                              ),
                            )
                            .toList(),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}
