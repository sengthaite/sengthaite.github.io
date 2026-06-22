import 'package:flutter/material.dart';
import 'package:sengthaite_blog/components/portfolio/widgets/text_menu_button.dart';
import 'package:sengthaite_blog/constants/portfolio.constants.dart';

class ContentSideNav extends StatefulWidget {
  const ContentSideNav({super.key});

  @override
  State<ContentSideNav> createState() => _ContentSideNavState();
}

class _ContentSideNavState extends State<ContentSideNav> {
  ValueNotifier<bool> experienceSelected = ValueNotifier(true);
  ValueNotifier<bool> educationSelected = ValueNotifier(false);
  ValueNotifier<bool> skillSelected = ValueNotifier(false);

  void select(String type) {
    switch (type) {
      case 'edu':
        experienceSelected.value = false;
        educationSelected.value = true;
        skillSelected.value = false;
        break;
      case 'exp':
        experienceSelected.value = true;
        educationSelected.value = false;
        skillSelected.value = false;
        break;
      case 'skill':
        experienceSelected.value = false;
        educationSelected.value = false;
        skillSelected.value = true;
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: Align(
        alignment: Alignment.topLeft,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              decoration: BoxDecoration(
                color: onBackgroundColor,
                borderRadius: BorderRadius.circular(25),
                border: Border.all(color: borderColor, width: 1),
              ),
              padding: EdgeInsets.all(10),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 10,
                children: [
                  TextMenuButton(
                    text: "EXPERIENCE",
                    isSelected: experienceSelected,
                    onPressed: () => select('exp'),
                  ),
                  TextMenuButton(
                    text: "EDUCATION",
                    isSelected: educationSelected,
                    onPressed: () => select('edu'),
                  ),
                  TextMenuButton(
                    text: "SKILLS",
                    isSelected: skillSelected,
                    onPressed: () => select('skill'),
                  ),
                ],
              ),
            ),
            IconButton(
              onPressed: () {},
              color: buttonBackgroundColor,
              icon: Icon(Icons.share_outlined, color: textButtonColor),
            ),
          ],
        ),
      ),
    );
  }
}
