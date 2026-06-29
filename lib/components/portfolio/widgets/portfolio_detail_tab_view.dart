import 'package:flutter/material.dart';
import 'package:sengthaite_blog/components/portfolio/widgets/portfolio_page_view.dart';
import 'package:sengthaite_blog/components/portfolio/widgets/text_menu_button.dart';
import 'package:sengthaite_blog/extensions/build_context_ext.dart';

class PortfolioDetailTabView extends StatefulWidget {
  final void Function(ContentSideSection)? onSelected;

  const PortfolioDetailTabView({super.key, this.onSelected});

  @override
  State<PortfolioDetailTabView> createState() => _PortfolioDetailTabViewState();
}

class _PortfolioDetailTabViewState extends State<PortfolioDetailTabView> {
  final ValueNotifier<bool> experienceSelected = ValueNotifier(true);

  final ValueNotifier<bool> educationSelected = ValueNotifier(false);

  void select(ContentSideSection type) {
    widget.onSelected?.call(type);
    switch (type) {
      case ContentSideSection.education:
        experienceSelected.value = false;
        educationSelected.value = true;
        break;
      case ContentSideSection.experience:
        experienceSelected.value = true;
        educationSelected.value = false;
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: context.colorScheme.onPrimary,
        borderRadius: BorderRadius.circular(25),
        border: Border.all(color: context.pfTheme.borderColor, width: 1),
      ),
      padding: EdgeInsets.all(10),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 10,
        children: [
          TextMenuButton(
            text: context.l10n.experience.toUpperCase(),
            isSelected: experienceSelected,
            onPressed: () => select(ContentSideSection.experience),
          ),
          TextMenuButton(
            text: context.l10n.education.toUpperCase(),
            isSelected: educationSelected,
            onPressed: () => select(ContentSideSection.education),
          ),
        ],
      ),
    );
  }
}
