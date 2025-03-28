import 'dart:convert';

import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:sengthaite_blog/extensions/http_ext.dart';
import 'package:sengthaite_blog/features/tool/api/api_utils/api_util.dart';
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
  }) {
    keyController.text = key ?? '';
    valueController.text = value ?? '';
    descriptionController.text = description ?? '';
  }
}

class HttpRequestBuilder extends ChangeNotifier {
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

  List<APIRowData> paramControllers = [];
  List<APIRowData> headerControllers = [];

  static HttpRequestBuilder? _instance;

  HttpRequestBuilder._() {
    headerControllers.add(APIRowData(allowDeletion: false));
  }

  removeInstance() => _instance = null;

  factory HttpRequestBuilder.getInstance() {
    _instance ??= HttpRequestBuilder._();
    return _instance!;
  }

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
      var path = urlInputController.text;
      var body = bodyInputController.text;
      var dio = Dio(
        BaseOptions(
          headers: headers?.map,
          queryParameters: params,
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
}
