import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:sengthaite_blog/components/category_tab_item_view.dart';
import 'package:sengthaite_blog/constants/theme.dart';
import 'package:sengthaite_blog/features/navigation/navigation.dart';
import 'package:sengthaite_blog/models/category_tab_item_model.dart';

class TabBarDetailView extends StatelessWidget {
  const TabBarDetailView({
    super.key,
    required this.title,
    this.items,
    this.widget,
    this.widgetBuilder,
    this.onBackPressed,
    this.endDrawer,
    this.actions,
  });

  final String title;
  final List<CategoryTabItemModel>? items;
  final Widget? widget;
  final WidgetBuilder? widgetBuilder;
  final void Function()? onBackPressed;
  final Widget? endDrawer;
  final List<Widget>? actions;

  @override
  Widget build(BuildContext context) {
    Navigation().tabBarDetailContext = context;
    return OrientationBuilder(builder: (context, orientation) {
      var colorScheme = MaterialTheme.colorScheme(context);
      return Scaffold(
        endDrawer: endDrawer,
        appBar: AppBar(
          surfaceTintColor: Colors.transparent,
          actions: actions,
          title: Text(
            softWrap: true,
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          leading: IconButton(
            color: colorScheme.onBackground,
            hoverColor: colorScheme.surfaceDim,
            onPressed: onBackPressed,
            icon: Icon(
              MdiIcons.arrowLeft,
              color: colorScheme.primary,
            ),
          ),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (widget != null)
              Expanded(
                child: Container(
                    color: Theme.of(context).cardColor, child: widget),
              )
            else if (widgetBuilder != null)
              Expanded(
                child: Builder(
                  builder: widgetBuilder!,
                ),
              ),
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
                                child: CategoryTabItemView(item: e),
                              ),
                            )
                            .toList(),
                      )),
                ),
              )
          ],
        ),
      );
    });
  }
}
