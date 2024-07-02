import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:sengthaite_blog/components/category_tab_item_view.dart';
import 'package:sengthaite_blog/models/category_tab_item_model.dart';

class TabBarDetailView extends StatelessWidget {
  const TabBarDetailView({
    super.key,
    required this.title,
    this.items,
    this.widget,
    this.onBackPressed,
  });

  final String title;
  final List<CategoryTabItemModel>? items;
  final Widget? widget;
  final void Function()? onBackPressed;

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(
      builder: (context, orientation) => Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            color: const Color.fromRGBO(252, 252, 252, 1),
            child: Row(
              children: [
                IconButton(
                  onPressed: onBackPressed,
                  icon: Icon(MdiIcons.arrowLeft),
                ),
                const SizedBox(
                  width: 20,
                ),
                Expanded(
                  child: Text(
                    softWrap: true,
                    title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
          if (widget != null) widget!,
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
  }
}
