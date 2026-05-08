import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

enum HttpRequestMethodType {
  get,
  head,
  post,
  put,
  delete,
  connect,
  options,
  trace,
  patch
}


extension HttpRequestMethodTypeExtension on HttpRequestMethodType {
  static String get defaultHttpMethod => listRequestMethods.first;

  static List<String> get listRequestMethods => [
        'GET',
        'HEAD',
        'POST',
        'PUT',
        'DELETE',
        'CONNECT',
        'OPTIONS',
        'TRACE',
        'PATCH'
      ];

  static HttpRequestMethodType? methodByDisplay(String methodDisplay) {
    switch (methodDisplay) {
      case 'GET':
        return HttpRequestMethodType.get;
      case 'HEAD':
        return HttpRequestMethodType.head;
      case 'POST':
        return HttpRequestMethodType.post;
      case 'PUT':
        return HttpRequestMethodType.put;
      case 'DELETE':
        return HttpRequestMethodType.delete;
      case 'CONNECT':
        return HttpRequestMethodType.connect;
      case 'OPTIONS':
        return HttpRequestMethodType.options;
      case 'TRACE':
        return HttpRequestMethodType.trace;
      case 'PATCH':
        return HttpRequestMethodType.patch;
    }
    return null;
  }

  String get methodDisplay {
    switch (this) {
      case HttpRequestMethodType.get:
        return 'GET';
      case HttpRequestMethodType.head:
        return 'HEAD';
      case HttpRequestMethodType.post:
        return 'POST';
      case HttpRequestMethodType.put:
        return 'PUT';
      case HttpRequestMethodType.delete:
        return 'DELETE';
      case HttpRequestMethodType.connect:
        return 'CONNECT';
      case HttpRequestMethodType.options:
        return 'OPTIONS';
      case HttpRequestMethodType.trace:
        return 'TRACE';
      case HttpRequestMethodType.patch:
        return 'PATCH';
    }
  }

  Color get color {
    switch (this) {
      case HttpRequestMethodType.get:
        return Colors.blue;
      case HttpRequestMethodType.head:
        return Colors.grey;
      case HttpRequestMethodType.post:
        return Colors.green;
      case HttpRequestMethodType.put:
        return Colors.orange;
      case HttpRequestMethodType.delete:
        return Colors.red;
      case HttpRequestMethodType.connect:
        return Colors.pink;
      case HttpRequestMethodType.options:
        return Colors.deepPurpleAccent;
      case HttpRequestMethodType.trace:
        return Colors.yellow;
      case HttpRequestMethodType.patch:
        return Colors.purple;
    }
  }
}

extension HeadersExtension on Headers {
  ResponseType get responseType {
    var accept = value(Headers.acceptHeader)?.toLowerCase();
    var isJson = accept?.contains("json") ?? false;
    var isText = accept?.contains("text") ?? false;
    var isByte = accept?.contains("image") ??
        accept?.contains("video") ??
        accept?.contains("audio") ??
        accept?.contains("application") ??
        false;
    var isMultipart =
        accept?.contains("message") ?? accept?.contains("multipart") ?? false;
    if (isJson) {
      return ResponseType.json;
    }
    if (isText) {
      return ResponseType.plain;
    }
    if (isByte) {
      return ResponseType.bytes;
    }
    if (isMultipart) {
      return ResponseType.stream;
    }
    return ResponseType.json;
  }

  ResponseType get responseContentType {
    var accept = value(Headers.contentTypeHeader)?.toLowerCase();
    var isJson = accept?.contains("json") ?? false;
    var isText = accept?.contains("text") ?? false;
    var isByte = accept?.contains("image") ??
        accept?.contains("video") ??
        accept?.contains("audio") ??
        accept?.contains("application") ??
        false;
    var isMultipart =
        accept?.contains("message") ?? accept?.contains("multipart") ?? false;
    if (isJson) {
      return ResponseType.json;
    }
    if (isText) {
      return ResponseType.plain;
    }
    if (isByte) {
      return ResponseType.bytes;
    }
    if (isMultipart) {
      return ResponseType.stream;
    }
    return ResponseType.json;
  }
}
