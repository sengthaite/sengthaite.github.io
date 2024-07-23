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

  HttpRequestMethodType? methodByDisplay(String methodDisplay) {
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
}
