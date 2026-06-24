import 'package:flutter/material.dart';
import 'package:sengthaite_blog/extensions/build_context_ext.dart';

class RadioButtonData {
  final String text;
  final String value;

  const RadioButtonData({required this.text, required this.value});
}

class RadioButtons extends StatefulWidget {
  const RadioButtons({
    super.key,
    required this.list,
    this.defaultSelectedValue,
    this.onSelectedValueChange,
  });

  final String? defaultSelectedValue;
  final List<RadioButtonData> list;
  final Function(String?)? onSelectedValueChange;

  @override
  State<RadioButtons> createState() => _RadioButtonsState();
}

class _RadioButtonsState extends State<RadioButtons> {
  String? _selectedValue;
  @override
  void initState() {
    _selectedValue = widget.defaultSelectedValue;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.list.isEmpty) return Container();
    return Row(
      mainAxisSize: MainAxisSize.min,
      spacing: 16,
      children: widget.list.map((e) {
        return RadioMenuButton<String>(
          value: e.value,
          groupValue: _selectedValue,
          onChanged: (newValue) {
            widget.onSelectedValueChange?.call(newValue);
            setState(() => _selectedValue = newValue);
          },
          style: ButtonStyle(
            padding: WidgetStatePropertyAll(EdgeInsets.fromLTRB(6, 2, 12, 2)),
            backgroundColor: WidgetStatePropertyAll(Colors.white),
            shape: WidgetStatePropertyAll<OutlinedBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(
                  20,
                ), // Adjust the radius here
              ),
            ),
          ),
          child: Center(
            child: Text(
              e.text,
              style: context.pfTheme.dialogRadioTitleTextStyle,
              textAlign: TextAlign.center,
            ),
          ),
        );
      }).toList(),
    );
  }
}
