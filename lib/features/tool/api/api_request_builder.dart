import 'dart:convert';

import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:sengthaite_blog/extensions/http_ext.dart';
import 'package:sengthaite_blog/features/tool/api/api_util_table_data.dart';
import 'package:sengthaite_blog/features/tool/api/api_utils/api_util.dart';
import 'package:sengthaite_blog/shared/dialog/error_dialog.dart';
import 'package:sengthaite_blog/shared/file/hivedir.dart';
import 'package:uuid/v4.dart';

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
    paramData.add(APIRowData(allowDeletion: false));
    headerData.add(APIRowData(allowDeletion: false));
    cryptoData.add(APIRowData(allowDeletion: false));
    functionData.add(APIRowData(allowDeletion: false));
    variableData.add(APIRowData(allowDeletion: false));
    liveVariableData.add(APIRowData(allowDeletion: false));
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
  final paramData = ApiUtilTableData();
  final headerData = ApiUtilTableData();
  final cryptoData = ApiUtilTableData();
  final functionData = ApiUtilTableData();
  final variableData = ApiUtilTableData();
  final liveVariableData = ApiUtilTableData();

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
    var updatedKey = key ?? paramData.controllers[rowIndex].key;
    var updatedValue = value ?? paramData.controllers[rowIndex].value;
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
    paramData.selectedAll = true;
    variableData.selectedAll = true;
    liveVariableData.selectedAll = true;
    functionData.selectedAll = true;
    cryptoData.selectedAll = true;
    headerData.selectedAll = true;

    paramData.controllers.clear();
    variableData.controllers.clear();
    liveVariableData.controllers.clear();
    functionData.controllers.clear();
    cryptoData.controllers.clear();
    headerData.controllers.clear();

    methodColor = HttpRequestMethodTypeExtension.methodByDisplay(
            HttpRequestMethodTypeExtension.defaultHttpMethod)
        ?.color;

    response = null;

    paramData.add(APIRowData(allowDeletion: false));
    liveVariableData.add(APIRowData(allowDeletion: false));
    variableData.add(APIRowData(allowDeletion: false));
    functionData.add(APIRowData(allowDeletion: false));
    cryptoData.add(APIRowData(allowDeletion: false));
    headerData.add(APIRowData(allowDeletion: false));

    notifyListeners();
    cancelToken = CancelToken();
    clearAuth();
  }

  Map<String, dynamic> get allVariables {
    final variablesMap = variableData.controllers.toMap ?? {};
    final liveVariablesMap = liveVariableData.controllers.toMap ?? {};
    return {...variablesMap, ...liveVariablesMap};
  }

  Headers? get headers {
    if (headerData.controllers.isEmpty) return null;
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
    for (var header in headerData.controllers) {
      var key = header.keyController.text;
      if (key.trim().isEmpty || !header.isSelected) continue;
      result[key] = header.valueController.text.split(',');
    }
    return Headers.fromMap(result);
  }

  String? _requestMethod;

  /// TODO: unexpect null
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
      var replacements = variableData.controllers.toMap;
      var path = urlInputController.text.replaceTextvariables(replacements);
      var body = bodyInputController.text.replaceTextvariables(replacements);
      var dio = Dio(
        BaseOptions(
          headers: headers?.map.toMapWithVariables(replacements),
          queryParameters:
              paramData.controllers.toMapWithVariables(replacements),
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

      var params = paramData.controllers.toMapWithVariables(replacements);

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
    _instance = HttpRequestBuilder._();
    return _instance!;
  }
}
