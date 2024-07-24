import 'package:flutter/material.dart';

class HttpRequestBuilder {
  final urlInputController = TextEditingController();
  final authInputController = TextEditingController();

  List<Map<bool, Map<String, TextEditingController>>> paramControllers = [];
  List<Map<bool, Map<String, TextEditingController>>> headerControllers = [];

  addParam(Map<bool, Map<String, TextEditingController>> data) =>
      paramControllers.add(data);

  removeParamAt(int index) => paramControllers.removeAt(index);

  addHeader(Map<bool, Map<String, TextEditingController>> data) =>
      headerControllers.add(data);

  removeHeaderAt(int index) => headerControllers.removeAt(index);

  Map<String, String> get params => {};
  Map<String, String> get headers => {};
}
