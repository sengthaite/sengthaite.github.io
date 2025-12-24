import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:sengthaite_blog/constants/theme.dart';
import 'package:sengthaite_blog/generated/models/category_tab_item_model.dart';

class CategoryTabItemView extends StatelessWidget {
  const CategoryTabItemView({super.key, required this.item});

  final CategoryTabItemModel item;

  @override
  Widget build(BuildContext context) {
    var colorScheme = MaterialTheme.colorScheme(context);
    var textTheme = MaterialTheme.textTheme().bodyMedium;
    return Container(
      constraints: const BoxConstraints(maxWidth: 450, minWidth: 400),
      child: Container(
        decoration: BoxDecoration(
          color: colorScheme.surfaceContainer,
          borderRadius: const BorderRadius.all(Radius.circular(8)),
        ),
        child: SizedBox(
          height: 118,
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  item.title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: textTheme!.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: FontSize.large.value,
                    color: colorScheme.onPrimaryContainer,
                  ),
                ),
                const SizedBox(height: 6),
                RichText(
                  softWrap: false,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  text: TextSpan(
                    style: textTheme.copyWith(color: colorScheme.outline),
                    text: "${item.date} | ",
                    children: [TextSpan(text: item.description)],
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
