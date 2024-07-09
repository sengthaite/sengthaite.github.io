import 'package:flutter/material.dart';
import 'package:sengthaite_blog/models/category_tab_item_model.dart';

class CategoryTabItemView extends StatelessWidget {
  const CategoryTabItemView({
    super.key,
    required this.item,
  });

  final CategoryTabItemModel item;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(maxWidth: 450, minWidth: 450),
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).dialogBackgroundColor,
          borderRadius: const BorderRadius.all(Radius.circular(8)),
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).shadowColor.withAlpha(40),
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
                FittedBox(
                  child: Text(
                    item.title,
                    maxLines: 2,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 9,
                ),
                Flexible(
                  child: RichText(
                    softWrap: false,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    text: TextSpan(
                      text: "${item.date} | ",
                      children: [
                        TextSpan(
                          text: item.description,
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
