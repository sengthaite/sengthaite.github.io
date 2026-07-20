import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:sengthaite_blog/extensions/build_context_ext.dart';
import 'package:sengthaite_blog/extensions/style_ext.dart';
import 'package:sengthaite_blog/features/portfolio/widgets/star_rating.dart';

class FeedbackDialog extends StatelessWidget {
  /// Widget FeedbackDialog : display the whole feedback dialog which contain of the star rating and inputs (email, and feedback)
  ///
  FeedbackDialog({super.key});
  final formState = GlobalKey<FormState>();

  final List<TextEditingController> _controllers = [
    TextEditingController(),
    TextEditingController(),
  ];

  int starRating = 2;

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
    String email = _controllers[0].text;
    String comment = _controllers[1].text;
    try {
      var dio = Dio(
        BaseOptions(baseUrl: "https://api.sengthaite.dpdns.org/api/v1"),
      );
      dio
          .post<dynamic>(
            '/feedback/submit',
            data: {"rating": starRating, "email": email, "comment": comment},
          )
          .then((value) {
            debugPrint(value.toString());
          });
    } catch (err) {
      debugPrint(err.toString());
    }

    return true;
  }

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      fit: BoxFit.scaleDown,
      child: AlertDialog(
        alignment: Alignment.center,
        backgroundColor: context.pfTheme.containerBgColor,
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
              StarRating(
                defaultStarRating: starRating,
                onRatingChange: (int value) => starRating = value,
              ),
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
                      onEditingComplete: () =>
                          FocusScope.of(context).nextFocus(),
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
                          context.navState.pop();
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
            onPressed: () => context.navState.pop(),
            child: Text(
              context.l10n.cancel,
              style: context.textTheme.labelMedium,
            ),
          ),
          TextButton(
            onPressed: () {
              onSubmit();
              context.navState.pop();
            },
            child: Text(
              context.l10n.submit,
              style: context.textTheme.labelMedium.bold,
            ),
          ),
        ],
      ),
    );
  }
}
