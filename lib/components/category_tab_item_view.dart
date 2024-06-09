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
            color: Colors.white,
            borderRadius: const BorderRadius.all(Radius.circular(4)),
            boxShadow: [
              BoxShadow(
                  color: Colors.black.withAlpha(25),
                  blurRadius: 4,
                  offset: const Offset(0, 4))
            ]),
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
                      color: Colors.blueAccent,
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
                      style: TextStyle(color: Colors.black.withAlpha(70)),
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
