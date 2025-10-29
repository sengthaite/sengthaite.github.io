import 'package:flutter/material.dart';

class APIRowData {
  bool isSelected;
  bool allowDeletion;
  bool keyReadOnly = false;
  bool valueReadOnly = false;
  bool descriptionReadOnly = false;
  String? function;
  final String? key;
  final dynamic value;
  final String? description;

  TextEditingController keyController = TextEditingController();
  TextEditingController valueController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  APIRowData({
    this.allowDeletion = true,
    this.isSelected = true,
    this.keyReadOnly = false,
    this.valueReadOnly = false,
    this.descriptionReadOnly = false,
    this.key,
    this.value,
    this.description,
    this.function,
  }) {
    keyController.text = key ?? '';
    valueController.text = value ?? '';
    descriptionController.text = description ?? '';
  }

  APIRowData.fromJson(Map<String, dynamic> json)
    : allowDeletion = json['allowDeletion'] ?? true,
      isSelected = json['isSelected'] ?? true,
      key = json['key'],
      value = json['value'],
      description = json['description'],
      function = json['function'];

  Map<String, dynamic> toJson() => {
    'allowDeletion': allowDeletion,
    'isSelected': isSelected,
    'key': keyController.text,
    'value': valueController.text,
    'description': descriptionController.text,
    'function': function,
  };
}

extension MapKeyValueReplacement on Map<String, List<String>> {
  Map<String, String>? toMapWithVariables(Map<String, String>? replacements) {
    if (isEmpty) return null;
    var entries = this.entries;
    Map<String, String> result = {};
    for (var entry in entries) {
      var key = entry.key;
      result[key] = entry.value.join(",").replaceTextvariables(replacements);
    }
    return result;
  }
}

extension ListAPIRowData on List<APIRowData> {
  Map<String, String>? toMapWithVariables(Map<String, String>? replacements) {
    if (isEmpty) return null;
    Map<String, String> result = {};
    for (var each in this) {
      var key = each.keyController.text;
      if (!each.isSelected) continue;
      result[key] = each.valueController.text.replaceTextvariables(
        replacements,
      );
    }
    return result;
  }

  Map<String, String>? get toMap {
    if (isEmpty) return null;
    Map<String, String> result = {};
    for (var param in this) {
      var key = param.keyController.text;
      if (key.trim().isEmpty || !param.isSelected) continue;
      result[key] = param.valueController.text;
    }
    return result;
  }
}

extension APIRowDataVariables on String {
  String replaceTextvariables(Map<String, String>? replacements) {
    if (replacements == null) return this;
    // Regex to find text between double curly braces ({{text}})
    final doubleBraceRegex = RegExp(r'\{\{([^}]+)\}\}');

    // Regex to find text between escaped curly braces (\{text1\})
    final escapedBraceRegex = RegExp(r'\\\{([^}]+)\\\}');

    // First, handle the escaped curly braces to prevent them from being
    // treated as regular double curly braces. We replace them with a
    // temporary placeholder that is unlikely to appear in the input.
    String tempString = replaceAllMapped(escapedBraceRegex, (match) {
      return '__ESCAPED_BRACE_START__${match.group(1)}__ESCAPED_BRACE_END__';
    });

    // Now, handle the regular double curly braces
    String replacedString = tempString.replaceAllMapped(doubleBraceRegex, (
      match,
    ) {
      final key = match.group(1);
      return replacements.containsKey(key)
          ? replacements[key]!
          : match.group(0)!;
    });

    // Finally, revert the temporary placeholder for escaped curly braces
    return replacedString
        .replaceAll('__ESCAPED_BRACE_START__', '{')
        .replaceAll('__ESCAPED_BRACE_END__', '}');
  }
}

class RequestData {
  Map<String, String> headers = {};
  Map<String, String> params = {};
  Map<String, String> body = {};
  Map<String, String> auth = {};

  Map<String, Map<String, String>> toJson() {
    return {"headers": headers, "params": params, "body": body, "auth": auth};
  }

  void fromJson(Map<String, dynamic> json) {
    headers = Map<String, String>.from(json["headers"]);
    params = Map<String, String>.from(json["params"]);
    body = Map<String, String>.from(json["body"]);
    auth = Map<String, String>.from(json["auth"]);
  }
}

class ApiUtilTableData {
  List<APIRowData> controllers = [];

  bool? selectedAll = true;

  void selectedRowAt(int index) {
    controllers[index].isSelected = true;
    var shouldSelectAll = true;
    for (var row in controllers) {
      if (!row.isSelected) {
        shouldSelectAll = false;
        break;
      }
    }
    selectedAll = shouldSelectAll;
  }

  void deSelectedRowAt(int index) {
    selectedAll = false;
    controllers[index].isSelected = false;
  }

  void toggleAllRow() {
    if (selectedAll == null) return;
    selectedAll! ? deSelectAllRow() : selectAllRow();
  }

  void toggleRowSelectionAt(int index) {
    controllers[index].isSelected = !controllers[index].isSelected;
    var shouldSelectAll = true;
    for (var row in controllers) {
      if (!row.isSelected) {
        shouldSelectAll = false;
        break;
      }
    }
    selectedAll = shouldSelectAll;
  }

  void selectAllRow() {
    selectedAll = true;
    for (var row in controllers) {
      if (row.isSelected) continue;
      row.isSelected = true;
    }
  }

  void deSelectAllRow() {
    selectedAll = false;
    for (var row in controllers) {
      if (!row.isSelected) continue;
      row.isSelected = false;
    }
  }

  void addList(List<APIRowData> data) => controllers.addAll(data);

  void add(APIRowData data) => controllers.add(data);

  APIRowData removeAt(int index) => controllers.removeAt(index);
}
