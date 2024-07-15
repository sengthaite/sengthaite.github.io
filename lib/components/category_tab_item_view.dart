import 'package:flutter/material.dart';
import 'package:sengthaite_blog/constants/theme.dart';
import 'package:sengthaite_blog/models/category_tab_item_model.dart';

class CategoryTabItemView extends StatelessWidget {
  const CategoryTabItemView({
    super.key,
    required this.item,
  });

  final CategoryTabItemModel item;

  @override
  Widget build(BuildContext context) {
    var colorScheme = MaterialTheme.colorScheme(context);
    return Container(
      constraints: const BoxConstraints(maxWidth: 450, minWidth: 450),
      child: Container(
        decoration: BoxDecoration(
          color: colorScheme.surfaceContainer,
          borderRadius: const BorderRadius.all(Radius.circular(8)),
          boxShadow: [
            BoxShadow(
              color: colorScheme.surfaceContainer.withAlpha(40),
              blurRadius: 2,
            )
          ],
        ),
        child: SizedBox(
          height: 100,
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: MaterialTheme.textTheme().labelMedium?.copyWith(
                        color: colorScheme.onSurface,
                      ),
                ),
                const SizedBox(
                  height: 9,
                ),
                RichText(
                  softWrap: false,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  text: TextSpan(
                    style: MaterialTheme.textTheme().labelSmall?.copyWith(
                          color: colorScheme.primary,
                        ),
                    text: "${item.date} | ",
                    children: [
                      TextSpan(
                        text: item.description,
                        style: MaterialTheme.textTheme().labelSmall?.copyWith(
                              color: colorScheme.primary,
                            ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
