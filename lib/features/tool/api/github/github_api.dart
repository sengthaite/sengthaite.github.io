import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:sengthaite_blog/shared/app.data.dart';

 class GithubAPI {

  final String personalAccessToken;

  var dio = Dio();

  GithubAPI({required this.personalAccessToken});

  Future<dynamic> listRepos({required String url}) async {
    AppData().isLoading.value = true;
    debugPrint(personalAccessToken);
    try {
      var result = await dio.get(url, options: Options(headers: {
        'Authorization': 'Bearer $personalAccessToken',
        'Accept': 'application/vnd.github.object',
        'X-GitHub-Api-Version': '2022-11-28'
      }));
      AppData().isLoading.value = false;
      return result.data;
    } catch (error) {
      debugPrint(error.toString());
      AppData().isLoading.value = false;
      return {};
    }
  }
}