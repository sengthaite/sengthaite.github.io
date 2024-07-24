import 'package:flutter/material.dart';

class HttpRowData {
  bool isSelected;
  final String? key;
  final String? value;

  HttpRowData(
      {required this.isSelected, required this.key, required this.value});
}

class HttpRequestBuilder {
  final urlInputController = TextEditingController();
  final authInputController = TextEditingController();

  bool? selectedAllParam = true;
  bool? selectedAllHeader = true;

  List<HttpRowData> paramControllers = [];
  List<HttpRowData> headerControllers = [];

  setParamSelectedRowAt(int index) {
    paramControllers[index].isSelected = true;
    var shouldSelectAllParam = true;
    for (var row in paramControllers) {
      if (!row.isSelected) {
        shouldSelectAllParam = false;
        break;
      }
    }
    selectedAllParam = shouldSelectAllParam;
  }

  setParamUnSelectedRowAt(int index) {
    selectedAllParam = false;
    paramControllers[index].isSelected = false;
  }

  toggleParamAllRow() {
    if (selectedAllParam == null) return;
    selectedAllParam! ? deSelectParamAllRow() : selectParamAllRow();
  }

  toggleParamRowSelectionAt(int index) {
    paramControllers[index].isSelected = !paramControllers[index].isSelected;
    var shouldSelectAllParam = true;
    for (var row in paramControllers) {
      if (!row.isSelected) {
        shouldSelectAllParam = false;
        break;
      }
    }
    selectedAllParam = shouldSelectAllParam;
  }

  selectParamAllRow() {
    selectedAllParam = true;
    for (var row in paramControllers) {
      if (row.isSelected) continue;
      row.isSelected = true;
    }
  }

  deSelectParamAllRow() {
    selectedAllParam = false;
    for (var row in paramControllers) {
      if (!row.isSelected) continue;
      row.isSelected = false;
    }
  }

  addParam(HttpRowData data) => paramControllers.add(data);

  removeParamAt(int index) => paramControllers.removeAt(index);

  setHeaderSelectedRowAt(int index) {
    headerControllers[index].isSelected = true;
    var shouldSelectAllHeader = true;
    for (var row in headerControllers) {
      if (!row.isSelected) {
        shouldSelectAllHeader = false;
        break;
      }
    }
    selectedAllHeader = shouldSelectAllHeader;
  }

  setHeaderUnSelectedRowAt(int index) {
    headerControllers[index].isSelected = false;
    selectedAllHeader = false;
  }

  toggleHeaderAllRow() {
    if (selectedAllHeader == null) return;
    selectedAllHeader! ? deSelectHeaderAllRow() : selectHeaderAllRow();
  }

  toggleHeaderRowSelectionAt(int index) {
    headerControllers[index].isSelected = !headerControllers[index].isSelected;
    var shouldSelectAllHeader = true;
    for (var row in headerControllers) {
      if (!row.isSelected) {
        shouldSelectAllHeader = false;
        break;
      }
    }
    selectedAllHeader = shouldSelectAllHeader;
  }

  selectHeaderAllRow() {
    selectedAllHeader = true;
    for (var row in headerControllers) {
      if (row.isSelected) continue;
      row.isSelected = true;
    }
  }

  deSelectHeaderAllRow() {
    selectedAllHeader = false;
    for (var row in headerControllers) {
      if (!row.isSelected) continue;
      row.isSelected = false;
    }
  }

  addHeader(HttpRowData data) => headerControllers.add(data);

  removeHeaderAt(int index) => headerControllers.removeAt(index);

  Map<String, String> get params => {};
  Map<String, String> get headers => {};
}
