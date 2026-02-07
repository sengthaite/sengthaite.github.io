import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:sengthaite_blog/shared/app.data.dart';

 class GithubAPI {

  final String personalAccessToken;

  var dio = Dio();

  GithubAPI({required this.personalAccessToken});

  Future<Map<String, dynamic>> listRepos() async {
    AppData().isLoading.value = true;
    debugPrint(personalAccessToken);
    try {
      var result = await dio.get('https://api.github.com/repos/sengthaite/my_roadmap/contents', options: Options(headers: {
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