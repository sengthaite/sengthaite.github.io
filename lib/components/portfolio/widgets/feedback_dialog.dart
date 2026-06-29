import 'package:flutter/material.dart';
import 'package:sengthaite_blog/extensions/build_context_ext.dart';
import 'package:sengthaite_blog/extensions/style_ext.dart';

class FeedbackDialog extends StatelessWidget {
  FeedbackDialog({super.key});
  final formState = GlobalKey<FormState>();

  final List<TextEditingController> _controllers = [
    TextEditingController(),
    TextEditingController(),
  ];

  final List<FocusNode> _focusNodes = [FocusNode(), FocusNode()];

  bool onSubmit() {
    for (int i = 0; i < _focusNodes.length; i++) {
      final error = formState.currentState?.fields.elementAt(i).validate();
      formState.currentState?.save();

      if (error != null && error == false) {
        _focusNodes[i].requestFocus();
        return false;
      }
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      alignment: Alignment.center,
      title: Text(
        context.l10n.feedback.toUpperCase(),
        textAlign: TextAlign.center,
        style: context.pfTheme.feedbackTitleStyle,
      ),
      content: SizedBox(
        width: 400,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          spacing: 8,
          children: [
            Text(
              context.l10n.feedback_title,
              style: context.pfTheme.feedbackSubTitleStyle,
            ),
            StarRating(),
            Form(
              key: formState,
              child: Column(
                spacing: 8,
                children: [
                  TextFormField(
                    obscureText: false,
                    autofocus: true,
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.done,
                    controller: _controllers[0],
                    focusNode: _focusNodes[0],
                    style: context.pfTheme.feedbackInputStyle,
                    onEditingComplete: () => FocusScope.of(context).nextFocus(),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: context.l10n.username_email,
                    ),
                    validator: (value) {
                      final emailRegex = RegExp(
                        r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
                      );
                      if (value == null ||
                          value == '' ||
                          !emailRegex.hasMatch(value.trim())) {
                        return "Please input a valid email";
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    maxLines: 4,
                    controller: _controllers[1],
                    focusNode: _focusNodes[1],
                    textInputAction: TextInputAction.done,
                    style: context.pfTheme.feedbackInputStyle,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: context.l10n.comment,
                    ),
                    validator: (value) {
                      if (value == null || value == '') {
                        return "Please input some comment";
                      }
                      return null;
                    },
                    onFieldSubmitted: (value) {
                      if (onSubmit()) {
                        debugPrint("submited");
                        Navigator.of(context).pop();
                      }
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(
            context.l10n.cancel,
            style: context.textTheme.labelMedium,
          ),
        ),
        TextButton(
          onPressed: onSubmit,
          child: Text(
            context.l10n.submit,
            style: context.textTheme.labelMedium.bold,
          ),
        ),
      ],
    );
  }
}

class StarRating extends StatefulWidget {
  const StarRating({super.key});

  @override
  State<StarRating> createState() => _StarRatingState();
}

class _StarRatingState extends State<StarRating> {
  final _starKey = GlobalKey();
  int star = 2;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onHorizontalDragUpdate: (details) {
        var starRenderBox =
            _starKey.currentContext?.findRenderObject() as RenderBox?;
        if (starRenderBox == null) return;
        var offset = starRenderBox.localToGlobal(Offset.zero);
        var currentStartX = details.globalPosition.dx - offset.dx;
        var currentStar = ((currentStartX - 56) / 56).toInt();
        setState(() {
          star = currentStar;
        });
      },
      onTapDown: (details) {
        var starRenderBox =
            _starKey.currentContext?.findRenderObject() as RenderBox?;
        if (starRenderBox == null) return;
        var offset = starRenderBox.localToGlobal(Offset.zero);
        var currentStartX = details.globalPosition.dx - offset.dx;
        var currentStar = (currentStartX / 56).toInt();
        setState(() {
          star = currentStar;
        });
      },
      child: Row(
        key: _starKey,
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(5, (index) {
          return Icon(
            index < star ? Icons.star : Icons.star_outline,
            color: index < star
                ? context.pfTheme.starColor
                : context.pfTheme.buttonFgColor,
            size: 56,
          );
        }).toList(),
      ),
    );
  }
}
