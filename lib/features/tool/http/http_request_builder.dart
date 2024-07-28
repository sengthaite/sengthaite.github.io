import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:sengthaite_blog/extensions/http_ext.dart';

class HttpRowData {
  bool isSelected;
  bool allowDeletion;
  final String? key;
  final String? value;
  final String? description;

  TextEditingController keyController = TextEditingController();
  TextEditingController valueController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  HttpRowData({
    this.allowDeletion = true,
    this.isSelected = true,
    this.key,
    this.value,
    this.description,
  });
}

class HttpRequestBuilder extends ChangeNotifier {
  final urlInputController = TextEditingController();
  final authInputController = TextEditingController();

  bool? selectedAllParam = true;
  bool? selectedAllHeader = true;

  List<HttpRowData> paramControllers = [];
  List<HttpRowData> headerControllers = [];

  HttpRequestBuilder() {
    paramControllers.add(HttpRowData(allowDeletion: false));
    headerControllers.add(HttpRowData(allowDeletion: false));
  }

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

  String? requestMethod;
  String? responseBody;

  bool get isValidUri =>
      Uri.tryParse(urlInputController.text)?.hasAbsolutePath ?? false;

  // bool get isSecureUri {
  //   final uri = Uri.tryParse(urlInputController.text);
  //   return uri != null && (uri.scheme == 'http' || uri.scheme == 'https');
  // }

  request() async {
    HttpRequestMethodType? method =
        HttpRequestMethodTypeExtension.methodByDisplay(
            requestMethod ?? HttpRequestMethodTypeExtension.defaultHttpMethod);
    if (method == null) {
      throw Exception("Unknown request method");
    }
    try {
      Uri? uri = Uri.tryParse(urlInputController.text);
      if (!isValidUri || uri == null) {
        throw Exception("Invalid uri request");
      }
      Response? response;
      switch (method) {
        case HttpRequestMethodType.get:
          response = await get(uri, headers: headers);
          break;
        case HttpRequestMethodType.head:
          response = await head(uri, headers: headers);
          break;
        case HttpRequestMethodType.post:
          response = await post(uri, headers: headers);
          break;
        case HttpRequestMethodType.put:
          response = await put(uri, headers: headers);
          break;
        case HttpRequestMethodType.delete:
          response = await delete(uri, headers: headers);
          break;
        case HttpRequestMethodType.connect:
        case HttpRequestMethodType.options:
        case HttpRequestMethodType.trace:
          break;
        case HttpRequestMethodType.patch:
          response = await patch(uri, headers: headers);
          break;
      }
      responseBody = response?.body;
    } catch (e) {
      debugPrint(e.toString());
    }
    notifyListeners();
  }
}
