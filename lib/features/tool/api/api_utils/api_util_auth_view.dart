import 'dart:core';

import 'package:flutter/material.dart';
import 'package:sengthaite_blog/features/tool/api/api_request_builder.dart';

class APIUtilAuthView extends StatefulWidget {
  const APIUtilAuthView({super.key, required this.requestBuilder});

  final HttpRequestBuilder requestBuilder;

  @override
  State<APIUtilAuthView> createState() => _APIUtilAuthViewState();
}

class _APIUtilAuthViewState extends State<APIUtilAuthView> {
  final controller = TextEditingController();

  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  String authType = "noAuth";

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(24),
      child: Column(
        children: [
          DropdownMenu(
            initialSelection: "noAuth",
            controller: controller,
            requestFocusOnTap: true,
            label: const Text('Auth Type'),
            onSelected: (String? value) {
              setState(() {
                authType = value ?? "noAuth";
              });
            },
            dropdownMenuEntries: [
              DropdownMenuEntry(value: "noAuth", label: "No Auth"),
              DropdownMenuEntry(value: "basic", label: "Basic"),
            ],
          ),
          if (authType == "basic")
            SizedBox(
              width: 250,
              child: Column(children: [
                SizedBox(height: 12),
                Padding(
                  padding: EdgeInsets.all(8),
                  child: TextField(
                    decoration: InputDecoration(
                        hintText: 'Username',
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.all(4)),
                    controller: usernameController,
                  ),
                ),
                SizedBox(height: 5),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    decoration: InputDecoration(
                        hintText: 'Password',
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.all(4)),
                    controller: passwordController,
                  ),
                )
              ]),
            )
        ],
      ),
    );
  }
}
