import 'dart:core';

import 'package:flutter/material.dart';
import 'package:sengthaite_blog/features/tool/api/api_request_builder.dart';

class APIUtilAuthView extends StatefulWidget {
  const APIUtilAuthView({super.key});

  @override
  State<APIUtilAuthView> createState() => _APIUtilAuthViewState();
}

class _APIUtilAuthViewState extends State<APIUtilAuthView> {
  var requestBuilder = HttpRequestBuilder.getInstance();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(24),
      child: Column(
        children: [
          DropdownMenu(
            initialSelection: requestBuilder.authType,
            requestFocusOnTap: true,
            label: const Text('Auth Type'),
            onSelected: (String? value) {
              setState(() {
                requestBuilder.authType = value ?? "noAuth";
                if (value == "noAuth") {
                  requestBuilder.clearAuth();
                }
              });
            },
            dropdownMenuEntries: [
              DropdownMenuEntry(value: "noAuth", label: "No Auth"),
              DropdownMenuEntry(value: "basic", label: "Basic"),
              DropdownMenuEntry(value: "bearer", label: "Bearer"),
              DropdownMenuEntry(value: "jsonwebtoken", label: "Json Web Token"),
            ],
          ),
          if (requestBuilder.authType == "basic")
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
                    controller: requestBuilder.usernameController,
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
                    controller: requestBuilder.passwordController,
                  ),
                )
              ]),
            ),
          if (requestBuilder.authType == "bearer")
            SizedBox(
              width: 250,
              child: Column(children: [
                SizedBox(height: 12),
                Padding(
                  padding: EdgeInsets.all(8),
                  child: TextField(
                    decoration: InputDecoration(
                        hintText: 'Bearer Token',
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.all(4)),
                    controller: requestBuilder.bearerController,
                  ),
                ),
              ]),
            ),
          if (requestBuilder.authType == "jsonwebtoken")
            SizedBox(
              width: 250,
              child: Column(children: [
                SizedBox(height: 12),
                Padding(
                  padding: EdgeInsets.all(8),
                  child: DropdownMenu(
                    initialSelection: "HS256",
                    requestFocusOnTap: true,
                    label: const Text('Algorithm'),
                    controller: requestBuilder.jwtAlgorithm,
                    dropdownMenuEntries: [
                      DropdownMenuEntry(value: "HS256", label: "HS256"),
                      DropdownMenuEntry(value: "HS384", label: "HS384"),
                      DropdownMenuEntry(value: "HS512", label: "HS512"),
                      DropdownMenuEntry(value: "PS256", label: "PS256"),
                      DropdownMenuEntry(value: "PS384", label: "PS384"),
                      DropdownMenuEntry(value: "PS512", label: "PS512"),
                      DropdownMenuEntry(value: "RS256", label: "RS256"),
                      DropdownMenuEntry(value: "RS384", label: "RS384"),
                      DropdownMenuEntry(value: "RS512", label: "RS512"),
                      DropdownMenuEntry(value: "ES256", label: "ES256"),
                      DropdownMenuEntry(value: "ES256K", label: "ES256K"),
                      DropdownMenuEntry(value: "ES384", label: "ES384"),
                      DropdownMenuEntry(value: "ES512", label: "ES512"),
                      DropdownMenuEntry(value: "EdDSA", label: "EdDSA"),
                    ],
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
                    controller: requestBuilder.passwordController,
                  ),
                )
              ]),
            )
        ],
      ),
    );
  }
}
