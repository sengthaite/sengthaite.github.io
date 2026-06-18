import 'package:flutter/material.dart';
import 'package:sengthaite_blog/constants/portfolio.constants.dart';

class TableRowData {
  final String title;
  final Widget? widget;
  final VoidCallback? onPress;

  const TableRowData({required this.title, this.widget, this.onPress});
}

class TablePopup extends StatelessWidget {
  const TablePopup({super.key, required this.rows, this.onPress});

  final List<TableRowData> rows;
  final Function(int, TableRowData)? onPress;

  @override
  Widget build(BuildContext context) {
    EdgeInsets verticalPadding = EdgeInsets.symmetric(vertical: 16);
    EdgeInsets horizontalPadding = EdgeInsets.symmetric(horizontal: 10);

    return Container(
      padding: horizontalPadding,
      decoration: BoxDecoration(
        color: popUpBackgroundColor,
        border: Border.all(color: popUpBorderColor, width: 2),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Table(
        defaultColumnWidth: IntrinsicColumnWidth(),
        defaultVerticalAlignment: TableCellVerticalAlignment.middle,
        border: TableBorder(
          horizontalInside: BorderSide(color: popUpDividerColor, width: 0.8),
        ),
        children: rows.asMap().entries.map((entry) {
          int index = entry.key;
          TableRowData e = entry.value;
          return TableRow(
            children: [
              InkWell(
                onTap: () {
                  onPress?.call(index, e);
                  e.onPress?.call();
                },
                child: TableCell(
                  verticalAlignment: TableCellVerticalAlignment.middle,
                  child: Container(
                    padding: verticalPadding,
                    width: 180,
                    child: Text(e.title, style: popUpTitleStyle),
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  onPress?.call(index, e);
                  e.onPress?.call();
                },
                child: TableCell(
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
