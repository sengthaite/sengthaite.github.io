import 'dart:convert';

import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:sengthaite_blog/extensions/http_ext.dart';
import 'package:sengthaite_blog/features/tool/api/api_utils/api_util.dart';
import 'package:sengthaite_blog/shared/dialog/error_dialog.dart';
import 'package:sengthaite_blog/shared/file/hivedir.dart';
import 'package:uuid/v4.dart';

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
  }) {
    keyController.text = key ?? '';
    valueController.text = value ?? '';
    descriptionController.text = description ?? '';
  }
}

extension MapKeyValueReplacement on Map<String, List<String>> {
  Map<String, String>? toMapWithVariables(Map<String, String>? replacements) {
    if (isEmpty) return null;
    var entries = this.entries;
    Map<String, String> result = {};
    for (var entry in entries) {
      var key = entry.key;
      result[key] =
          entry.value.join(",").replaceTextStaticVariables(replacements);
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
      result[key] =
          each.valueController.text.replaceTextStaticVariables(replacements);
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
  String replaceTextStaticVariables(Map<String, String>? replacements) {
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
    String replacedString =
        tempString.replaceAllMapped(doubleBraceRegex, (match) {
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

  toJson() {
    return {
      "headers": headers,
      "params": params,
      "body": body,
      "auth": auth,
    };
  }

  fromJson(Map<String, dynamic> json) {
    headers = Map<String, String>.from(json["headers"]);
    params = Map<String, String>.from(json["params"]);
    body = Map<String, String>.from(json["body"]);
    auth = Map<String, String>.from(json["auth"]);
  }
}

class HttpRestRequestDatum extends ChangeNotifier {
  String id = "request_${UuidV4().generate()}";
  bool isSelected = false;
  String method = "GET";
  String url = "";
  List<RequestData> requestData = [RequestData()];
  String selectedRequest = "";
  String responsePath = "";
  Map<String, String> variables = {};

  HttpRestRequestDatum() {
    paramControllers.add(APIRowData(allowDeletion: false));
    headerControllers.add(APIRowData(allowDeletion: false));
    staticVariableControllers.add(APIRowData(allowDeletion: false));
  }

  final urlInputController = TextEditingController();
  final bodyInputController = TextEditingController();

  // basic auth type
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  // bearer auth type
  final bearerController = TextEditingController();

  // json web token
  final jwtAlgorithm = TextEditingController(text: "HS256");
  final jwtSecret = TextEditingController();
  bool isSecretBase64 = false;
  final jwtPayload = TextEditingController();
  final jwtPrivateKey = TextEditingController();

  String authType = "noAuth";

  var cancelToken = CancelToken();

  Color? methodColor = HttpRequestMethodTypeExtension.methodByDisplay(
          HttpRequestMethodTypeExtension.defaultHttpMethod)
      ?.color;

  bool isRequesting = false;
  bool? selectedAllParam = true;
  bool? selectedAllHeader = true;
  bool? selectedAllStaticVariables = true;
  bool? selectedAllDynamicVaraibles = true;

  List<APIRowData> paramControllers = [];
  List<APIRowData> headerControllers = [];
  List<APIRowData> staticVariableControllers = [];
  List<APIRowData> dynamicVariableControllers = [];

  set autopopulateData(TempFile api) {
    urlInputController.text = api.url;
    _requestMethod = api.requestMethod;
    methodColor = HttpRequestMethodTypeExtension.methodByDisplay(
            _requestMethod ?? HttpRequestMethodTypeExtension.defaultHttpMethod)
        ?.color;
    notifyListeners();
  }

  clearAuth() {
    usernameController.clear();
    passwordController.clear();
    bearerController.clear();
  }

  bool get isHashingAlgorithm =>
      ["HS256", "HS384", "HS512"].contains(jwtAlgorithm.text);

  String? get basicAuth {
    var username = usernameController.text;
    var password = passwordController.text;
    if (username.isEmpty && password.isEmpty) return null;
    var base64Credential = base64.encode(utf8.encode("$username:$password"));
    return "Basic $base64Credential";
  }

  String? get bearerAuth => "Bearer ${bearerController.text}";

  String? get jwtBearerToken {
    var jwt = JWT(jwtPayload.text);
    JWTAlgorithm algorithm = JWTAlgorithm.HS256;
    JWTKey key = SecretKey(jwtSecret.text, isBase64Encoded: isSecretBase64);
    switch (jwtAlgorithm.text) {
      case "HS256":
        algorithm = JWTAlgorithm.HS256;
        key = SecretKey(jwtSecret.text, isBase64Encoded: isSecretBase64);
        break;
      case "HS384":
        algorithm = JWTAlgorithm.HS384;
        key = SecretKey(jwtSecret.text, isBase64Encoded: isSecretBase64);
        break;
      case "HS512":
        algorithm = JWTAlgorithm.HS512;
        key = SecretKey(jwtSecret.text, isBase64Encoded: isSecretBase64);
        break;
      case "PS256":
        algorithm = JWTAlgorithm.PS256;
        key = RSAPrivateKey(jwtPrivateKey.text);
        break;
      case "PS384":
        algorithm = JWTAlgorithm.PS384;
        key = RSAPrivateKey(jwtPrivateKey.text);
        break;
      case "PS512":
        algorithm = JWTAlgorithm.PS512;
        key = RSAPrivateKey(jwtPrivateKey.text);
        break;
      case "RS256":
        algorithm = JWTAlgorithm.RS256;
        key = RSAPrivateKey(jwtPrivateKey.text);
        break;
      case "RS384":
        algorithm = JWTAlgorithm.RS384;
        key = RSAPrivateKey(jwtPrivateKey.text);
        break;
      case "RS512":
        algorithm = JWTAlgorithm.RS512;
        key = RSAPrivateKey(jwtPrivateKey.text);
        break;
      case "ES256":
        algorithm = JWTAlgorithm.ES256;
        key = ECPrivateKey(jwtPrivateKey.text);
        break;
      case "ES256K":
        algorithm = JWTAlgorithm.ES256K;
        key = ECPrivateKey(jwtPrivateKey.text);
        break;
      case "ES384":
        algorithm = JWTAlgorithm.ES384;
        key = ECPrivateKey(jwtPrivateKey.text);
        break;
      case "ES512":
        algorithm = JWTAlgorithm.ES512;
        key = ECPrivateKey(jwtPrivateKey.text);
        break;
      case "EdDSA":
        algorithm = JWTAlgorithm.EdDSA;
        key = EdDSAPrivateKey.fromPEM(jwtPrivateKey.text);
        break;
    }
    try {
      var token = jwt.sign(
        key,
        algorithm: algorithm,
      );
      return "Bearer $token";
    } catch (error) {
      APIUtil.showTextDialog(error.toString());
      return null;
    }
  }

  buildUrlWithQueryParams(int rowIndex, {String? key, String? value}) {
    final uri = Uri.parse(urlInputController.text);
    var updatedParams = {};
    var updatedKey = key ?? paramControllers[rowIndex].key;
    var updatedValue = value ?? paramControllers[rowIndex].value;
    if (updatedKey != null) {
      updatedParams[updatedKey] = updatedValue;
    }

    final fullUri = uri
        .replace(queryParameters: {...uri.queryParameters, ...updatedParams});

    var parsedUrl = fullUri.toString();

    if (parsedUrl[parsedUrl.length - 1] == '?') {
      parsedUrl = parsedUrl.substring(0, parsedUrl.length - 1);
    }

    urlInputController.text = parsedUrl;
  }

  reset() {
    cancelToken.cancel("Request is canceled.");
    urlInputController.clear();
    bodyInputController.clear();
    isRequesting = false;
    selectedAllParam = null;
    selectedAllHeader = null;
    paramControllers.clear();
    headerControllers.clear();

    methodColor = HttpRequestMethodTypeExtension.methodByDisplay(
            HttpRequestMethodTypeExtension.defaultHttpMethod)
        ?.color;

    paramControllers.add(APIRowData(allowDeletion: false));
    headerControllers.add(APIRowData(allowDeletion: false));
    response = null;

    notifyListeners();
    cancelToken = CancelToken();
    clearAuth();
  }

  /// Params
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

  /// Headers
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

  /// Static variables
  selectStaticVariablesAllRow() {
    selectedAllStaticVariables = true;
    for (var row in staticVariableControllers) {
      if (row.isSelected) continue;
      row.isSelected = true;
    }
  }

  deSelectStaticVariablesAllRow() {
    selectedAllStaticVariables = false;
    for (var row in staticVariableControllers) {
      if (!row.isSelected) continue;
      row.isSelected = false;
    }
  }

  toggleStaticVariablesAllRow() {
    if (selectedAllStaticVariables == null) return;
    selectedAllStaticVariables!
        ? deSelectStaticVariablesAllRow()
        : selectStaticVariablesAllRow();
  }

  toggleStaticVariablesRowSelectionAt(int index) {
    staticVariableControllers[index].isSelected =
        !staticVariableControllers[index].isSelected;
    var shouldSelectAllStaticVariables = true;
    for (var row in staticVariableControllers) {
      if (!row.isSelected) {
        shouldSelectAllStaticVariables = false;
        break;
      }
    }
    selectedAllStaticVariables = shouldSelectAllStaticVariables;
  }

  addStaticVariables(APIRowData data) => staticVariableControllers.add(data);

  removeStaticVariablesAt(int index) =>
      staticVariableControllers.removeAt(index);

  Headers? get headers {
    if (headerControllers.isEmpty) return null;
    Map<String, List<String>> result = {};
    String auth = '';
    switch (authType) {
      case 'basic':
        auth = basicAuth ?? '';
        break;
      case 'bearer':
        auth = bearerAuth ?? '';
        break;
      case 'jsonwebtoken':
        auth = jwtBearerToken ?? '';
        break;
      default:
        break;
    }
    if (auth.isNotEmpty) {
      result["Authorization"] = [auth];
    }
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
      var replacements = staticVariableControllers.toMap;
      var path =
          urlInputController.text.replaceTextStaticVariables(replacements);
      var body =
          bodyInputController.text.replaceTextStaticVariables(replacements);
      var dio = Dio(
        BaseOptions(
          headers: headers?.map.toMapWithVariables(replacements),
          queryParameters: paramControllers.toMapWithVariables(replacements),
          responseType: headers?.responseType ?? ResponseType.bytes,
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

      var params = paramControllers.toMapWithVariables(replacements);

      switch (method) {
        case HttpRequestMethodType.get:
          response = await dio.get(path,
              queryParameters: params, cancelToken: cancelToken);
          break;
        case HttpRequestMethodType.head:
          response = await dio.head(path,
              data: body, queryParameters: params, cancelToken: cancelToken);
          break;
        case HttpRequestMethodType.post:
          response = await dio.post(path,
              data: body, queryParameters: params, cancelToken: cancelToken);
          break;
        case HttpRequestMethodType.put:
          response = await dio.put(path,
              data: body, queryParameters: params, cancelToken: cancelToken);
          break;
        case HttpRequestMethodType.delete:
          response = await dio.delete(path,
              data: body, queryParameters: params, cancelToken: cancelToken);
          break;
        case HttpRequestMethodType.connect:
        case HttpRequestMethodType.options:
        case HttpRequestMethodType.trace:
          break;
        case HttpRequestMethodType.patch:
          response = await dio.patch(path,
              data: body, queryParameters: params, cancelToken: cancelToken);
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

  Map<String, dynamic> toJson() {
    return {
      id: id,
      "isSelected": isSelected,
      "method": method,
      "url": url,
      "requestData": requestData.map((e) => e.toJson()).toList(),
      "selectedRequest": selectedRequest,
      "responsePath": responsePath,
      "variables": variables,
    };
  }

  fromJson(Map<String, dynamic> json) {}

  // AES
}

class HttpRestRequestData extends ChangeNotifier {
  /// Import and Export zip file
  export() {}
  import() {}

  String id = UuidV4().generate();
  String version;
  String author;
  String createDate = DateTime.now().toIso8601String();
  String modifiedDate = DateTime.now().toIso8601String();
  List<HttpRestRequestDatum> collection = [];
  Map<String, dynamic> globalVariables = {};

  Function? onCollectionChanged;

  HttpRestRequestData({
    this.version = "1.0",
    this.author = "",
    this.onCollectionChanged,
  });

  itemAt(int index) => collection.elementAt(index);

  add() {
    collection.add(HttpRestRequestDatum());
    if (onCollectionChanged != null) {
      onCollectionChanged!();
    }
  }

  remove(String id) {
    collection.removeWhere((element) => element.id == id);
    if (onCollectionChanged != null) {
      onCollectionChanged!();
    }
  }
}

class HttpRequestBuilder extends ChangeNotifier {
  static HttpRequestBuilder? _instance;

  removeInstance() => _instance = null;

  HttpRestRequestData data = HttpRestRequestData()..add();

  HttpRestRequestDatum? selectedDatum;

  reset() => selectedDatum?.reset();

  set autopopulateData(TempFile file) => selectedDatum?.autopopulateData = file;

  set setRequestMethod(String method) =>
      selectedDatum?.setRequestMethod = method;

  String? get getRequestMethod => selectedDatum?.getRequestMethod;

  Color? get methodColor => selectedDatum?.methodColor;

  TextEditingController? get urlInputController =>
      selectedDatum?.urlInputController;

  request() => selectedDatum?.request();

  bool get isRequesting => selectedDatum?.isRequesting ?? false;

  HttpRequestBuilder._() {
    selectedDatum = data.collection.first;
  }

  factory HttpRequestBuilder.getInstance() {
    _instance ??= HttpRequestBuilder._();
    return _instance!;
  }
}
