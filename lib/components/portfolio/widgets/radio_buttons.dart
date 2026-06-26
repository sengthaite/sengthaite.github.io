import 'package:flutter/material.dart';
import 'package:sengthaite_blog/extensions/build_context_ext.dart';

class RadioButtonData<T> {
  final String text;
  final T value;

  const RadioButtonData({required this.text, required this.value});
}

class RadioButtons<T> extends StatefulWidget {
  const RadioButtons({
    super.key,
    required this.list,
    this.defaultSelectedValue,
    this.onSelectedValueChange,
  });

  final T? defaultSelectedValue;
  final List<RadioButtonData<T>> list;
  final void Function(T?)? onSelectedValueChange;

  @override
  State<RadioButtons<T>> createState() => _RadioButtonsState();
}

class _RadioButtonsState<T> extends State<RadioButtons<T>> {
  T? _selectedValue;
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
        return RadioMenuButton<T>(
          value: e.value,
          groupValue: _selectedValue,
          onChanged: (newValue) {
            widget.onSelectedValueChange?.call(newValue);
            setState(() => _selectedValue = newValue);
          },
          style: ButtonStyle(
            padding: WidgetStatePropertyAll(EdgeInsets.fromLTRB(6, 2, 12, 2)),
            backgroundColor: WidgetStatePropertyAll(
              context.pfTheme.containerBgColor,
            ),
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
