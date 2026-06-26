import 'package:flutter/material.dart';
import 'package:sengthaite_blog/extensions/build_context_ext.dart';

class TableRowData {
  final String title;
  final Widget? widget;
  final VoidCallback? onPress;

  const TableRowData({required this.title, this.widget, this.onPress});
}

class TablePopup extends StatelessWidget {
  const TablePopup({super.key, required this.rows, this.onPress});

  final List<TableRowData> rows;
  final void Function(int, TableRowData)? onPress;

  @override
  Widget build(BuildContext context) {
    EdgeInsets verticalPadding = EdgeInsets.symmetric(vertical: 16);
    EdgeInsets horizontalPadding = EdgeInsets.symmetric(horizontal: 10);

    return Container(
      padding: horizontalPadding,
      decoration: BoxDecoration(
        color: context.pfTheme.dialogBgColor,
        border: Border.all(color: context.pfTheme.borderColor, width: 2),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Table(
        defaultColumnWidth: IntrinsicColumnWidth(),
        defaultVerticalAlignment: TableCellVerticalAlignment.middle,
        border: TableBorder(
          horizontalInside: BorderSide(
            color: context.pfTheme.dividerColor,
            width: 0.8,
          ),
        ),
        children: rows.asMap().entries.map((entry) {
          int index = entry.key;
          TableRowData e = entry.value;
          return TableRow(
            children: [
              TableCell(
                verticalAlignment: TableCellVerticalAlignment.middle,
                child: InkWell(
                  onTap: () {
                    onPress?.call(index, e);
                    e.onPress?.call();
                  },
                  child: Container(
                    padding: verticalPadding,
                    width: 180,
                    child: Text(
                      e.title,
                      style: context.pfTheme.dialogTitleTextStyle,
                    ),
                  ),
                ),
              ),

              TableCell(
                child: InkWell(
                  onTap: () {
                    onPress?.call(index, e);
                    e.onPress?.call();
                  },
                  child: Padding(padding: verticalPadding, child: e.widget),
                ),
              ),
            ],
          );
        }).toList(),
      ),
    );
  }
}
