import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            IconButton(
              onPressed: onBackPressed,
              icon: Icon(MdiIcons.arrowLeft),
            ),
            const Spacer(),
            Text(title,
                textAlign: TextAlign.center,
                style:
                    const TextStyle(fontSize: 24, fontWeight: FontWeight.w500)),
            const Spacer()
          ],
        ),
        if (widget != null) widget!,
        if (items != null)
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Wrap(
                  alignment: WrapAlignment.center,
                  spacing: 12,
                  runSpacing: 12,
                  children: items!
                      .map((e) => InkWell(
                            onTap: e.onTap,
                            child: CategoryTabItemView(item: e),
                          ))
                      .toList(),
                ),
              ),
            ),
          )
      ],
    );
  }
}

class CategoryTabItemModel {
  final String title;
  final String date;
  final String description;
  final void Function()? onTap;

  CategoryTabItemModel({
    required this.title,
    required this.date,
    required this.description,
    this.onTap,
  });
}

class CategoryTabItemView extends StatelessWidget {
  const CategoryTabItemView({super.key, required this.item});

  final CategoryTabItemModel item;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(maxWidth: 370),
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
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                item.title,
                style: const TextStyle(
                  color: Colors.blueAccent,
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(
                height: 9,
              ),
              RichText(
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  text: TextSpan(
                      text: "${item.date} | ",
                      style: TextStyle(color: Colors.black.withAlpha(70)),
                      children: [
                        TextSpan(
                          text: item.description,
                        ),
                      ]))
            ],
          ),
        ),
      ),
    );
  }
}
