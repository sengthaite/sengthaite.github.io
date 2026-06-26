import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class GithubAPI {
  final String personalAccessToken;

  var dio = Dio();

  GithubAPI({required this.personalAccessToken});

  Future<dynamic> listRepos({required String url}) async {
    debugPrint(personalAccessToken);
    try {
      var result = await dio.get<dynamic>(
        url,
        options: Options(
          headers: {
            'Authorization': 'Bearer $personalAccessToken',
            'Accept': 'application/vnd.github.object',
            'X-GitHub-Api-Version': '2022-11-28',
          },
        ),
      );
      return result.data;
    } catch (error) {
      debugPrint(error.toString());
      return {};
    }
  }
}
