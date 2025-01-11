import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:sengthaite_blog/extensions/http_ext.dart';
import 'package:sengthaite_blog/shared/dialog/error_dialog.dart';
import 'package:sengthaite_blog/shared/file/hivedir.dart';

class APIRowData {
  bool isSelected;
  bool allowDeletion;
  final String? key;
  final dynamic value;
  final String? description;

  TextEditingController keyController = TextEditingController();
  TextEditingController valueController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  APIRowData({
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

  var cancelToken = CancelToken();

  Color? methodColor = HttpRequestMethodTypeExtension.methodByDisplay(
          HttpRequestMethodTypeExtension.defaultHttpMethod)
      ?.color;

  bool isRequesting = false;
  bool? selectedAllParam = true;
  bool? selectedAllHeader = true;

  List<APIRowData> paramControllers = [];
  List<APIRowData> headerControllers = [];

  HttpRequestBuilder() {
    paramControllers.add(APIRowData(allowDeletion: false));
    headerControllers.add(APIRowData(allowDeletion: false));
  }

  set autopopulateData(TempFile api) {
    urlInputController.text = api.url;
    _requestMethod = api.requestMethod;
    methodColor = HttpRequestMethodTypeExtension.methodByDisplay(
            _requestMethod ?? HttpRequestMethodTypeExtension.defaultHttpMethod)
        ?.color;
    notifyListeners();
  }

  reset() {
    cancelToken.cancel("Request is canceled.");
    urlInputController.clear();
    authInputController.clear();
    bodyInputController.clear();
    isRequesting = false;
    selectedAllParam = null;
    selectedAllHeader = null;
    response = null;
    paramControllers.clear();
    headerControllers.clear();

    methodColor = HttpRequestMethodTypeExtension.methodByDisplay(
            HttpRequestMethodTypeExtension.defaultHttpMethod)
        ?.color;

    paramControllers.add(APIRowData(allowDeletion: false));
    headerControllers.add(APIRowData(allowDeletion: false));

    notifyListeners();
    cancelToken = CancelToken();
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

  addParam(APIRowData data) => paramControllers.add(data);

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

  addHeader(APIRowData data) => headerControllers.add(data);

  removeHeaderAt(int index) => headerControllers.removeAt(index);

  Map<String, dynamic>? get params {
    if (paramControllers.isEmpty) return null;
    Map<String, dynamic> result = {};
    for (var param in paramControllers) {
      var key = param.keyController.text;
      if (key.trim().isEmpty || !param.isSelected) continue;
      result[key] = param.valueController.text;
    }
    return result;
  }

  Headers? get headers {
    if (headerControllers.isEmpty) return null;
    Map<String, List<String>> result = {};
    for (var header in headerControllers) {
      var key = header.keyController.text;
      if (key.trim().isEmpty || !header.isSelected) continue;
      result[key] = header.valueController.text.split(',');
    }
    return Headers.fromMap(result);
  }

  String? _requestMethod;
  Response? response;

  get getRequestMethod => _requestMethod;

  set setRequestMethod(String method) {
    _requestMethod = method;
    methodColor = HttpRequestMethodTypeExtension.methodByDisplay(method)?.color;
    notifyListeners();
  }

  bool get isValidUri => Uri.tryParse(urlInputController.text) != null;

  request() async {
    try {
      HttpRequestMethodType? method =
          HttpRequestMethodTypeExtension.methodByDisplay(_requestMethod ??
              HttpRequestMethodTypeExtension.defaultHttpMethod);
      if (method == null) {
        throw Exception("Unknown request method");
      }
      var path = urlInputController.text;
      var body = bodyInputController.text;
      var dio = Dio(
        BaseOptions(
          headers: headers?.map,
          queryParameters: params,
          responseType: headers?.responseType,
          contentType: headers?.value(Headers.contentTypeHeader),
          receiveDataWhenStatusError: true,
          followRedirects: true,
          maxRedirects: 3,
          persistentConnection: true,
        ),
      );

      Uri? uri = Uri.tryParse(path);
      if (!isValidUri || uri == null) {
        showErrorDialog(
            title: const Text("URL Error",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
            content: RichText(
                text: TextSpan(children: [
              const TextSpan(
                  text: "Invalid url: ", style: TextStyle(fontSize: 12)),
              TextSpan(
                  text: path,
                  style: const TextStyle(
                      fontSize: 12, fontWeight: FontWeight.bold))
            ])),
            onDismiss: () {
              urlInputController.clear();
            });
        return;
      }
      isRequesting = true;
      notifyListeners();

      switch (method) {
        case HttpRequestMethodType.get:
          response = await dio.get(path, cancelToken: cancelToken);
          break;
        case HttpRequestMethodType.head:
          response = await dio.head(path, data: body, cancelToken: cancelToken);
          break;
        case HttpRequestMethodType.post:
          response = await dio.post(path, data: body, cancelToken: cancelToken);
          break;
        case HttpRequestMethodType.put:
          response = await dio.put(path, data: body, cancelToken: cancelToken);
          break;
        case HttpRequestMethodType.delete:
          response =
              await dio.delete(path, data: body, cancelToken: cancelToken);
          break;
        case HttpRequestMethodType.connect:
        case HttpRequestMethodType.options:
        case HttpRequestMethodType.trace:
          break;
        case HttpRequestMethodType.patch:
          response =
              await dio.patch(path, data: body, cancelToken: cancelToken);
          break;
      }
    } catch (e) {
      showErrorDialog(
        title: const Text("Network Error",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
        content: Text(e.toString()),
      );
    } finally {
      isRequesting = false;
    }

    notifyListeners();
  }
}
