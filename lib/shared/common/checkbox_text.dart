import 'package:flutter/material.dart';

class CheckboxText extends StatefulWidget {
  const CheckboxText({super.key, required this.text, this.defaultCheck = true});
  
  final String text;
  final bool defaultCheck;

  @override
  State<CheckboxText> createState() => _CheckboxTextState();
}

class _CheckboxTextState extends State<CheckboxText> {

  bool isSelected = true;

  @override
  void initState() {
    super.initState();
    isSelected = widget.defaultCheck;
  }

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisSize: MainAxisSize.min, children: [
      Checkbox(value: isSelected, onChanged: (value) {
        setState(() {
          isSelected = value ?? false;
        });
      }),
      Text(widget.text)
    ],);
  }
}