import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:sengthaite_blog/extensions/http_ext.dart';
import 'package:sengthaite_blog/features/navigation/navigation.dart';

class HttpRowData {
  bool isSelected;
  bool allowDeletion;
  final String? key;
  final dynamic value;
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
  final bodyInputController = TextEditingController();

  bool isRequesting = false;
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

  Map<String, dynamic>? get params {
    if (paramControllers.isEmpty) return null;
    Map<String, dynamic> result = {};
    for (var param in paramControllers) {
      var key = param.key;
      if (key == null || !param.isSelected) continue;
      result[key] = param.value;
    }
    return result;
  }

  Map<String, dynamic>? get headers {
    if (headerControllers.isEmpty) return null;
    Map<String, dynamic> result = {};
    for (var header in headerControllers) {
      var key = header.key;
      if (key == null || !header.isSelected) continue;
      result[key] = header.value;
    }
    return result;
  }

  String? requestMethod;
  Response? response;

  bool get isValidUri =>
      Uri.tryParse(urlInputController.text)?.hasAbsolutePath ?? false;

  request() async {
    HttpRequestMethodType? method =
        HttpRequestMethodTypeExtension.methodByDisplay(
            requestMethod ?? HttpRequestMethodTypeExtension.defaultHttpMethod);
    if (method == null) {
      throw Exception("Unknown request method");
    }
    var path = urlInputController.text;
    var body = bodyInputController.text;
    var dio = Dio(BaseOptions(headers: headers, queryParameters: params));
    try {
      Uri? uri = Uri.tryParse(path);
      if (!isValidUri || uri == null) {
        showDialog(
            context: Navigation().context,
            builder: (context) {
              return AlertDialog(
                icon: const Icon(Icons.error),
                title: const Text("URL Error",
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                content: RichText(
                    text: TextSpan(children: [
                  const TextSpan(
                      text: "Invalid url: ", style: TextStyle(fontSize: 12)),
                  TextSpan(
                      text: path,
                      style: const TextStyle(
                          fontSize: 12, fontWeight: FontWeight.bold))
                ])),
                actions: [
                  TextButton(
                    onPressed: () {
                      urlInputController.clear();
                      Navigator.pop(context, 'OK');
                    },
                    child: const Text('OK'),
                  ),
                ],
              );
            });
        return;
      }
      isRequesting = true;
      notifyListeners();

      switch (method) {
        case HttpRequestMethodType.get:
          response = await dio.get(path);
          break;
        case HttpRequestMethodType.head:
          response = await dio.head(path, data: body);
          break;
        case HttpRequestMethodType.post:
          response = await dio.post(path, data: body);
          break;
        case HttpRequestMethodType.put:
          response = await dio.put(path, data: body);
          break;
        case HttpRequestMethodType.delete:
          response = await dio.delete(path, data: body);
          break;
        case HttpRequestMethodType.connect:
        case HttpRequestMethodType.options:
        case HttpRequestMethodType.trace:
          break;
        case HttpRequestMethodType.patch:
          response = await dio.patch(path, data: body);
          break;
      }
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      isRequesting = false;
    }

    notifyListeners();
  }
}
