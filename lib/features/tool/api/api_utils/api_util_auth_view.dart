import 'dart:core';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:sengthaite_blog/features/tool/api/api_request_builder.dart';

class APIUtilAuthView extends StatefulWidget {
  const APIUtilAuthView({super.key});

  @override
  State<APIUtilAuthView> createState() => _APIUtilAuthViewState();
}

extension APIUtilList on Map<String, String> {
  List<DropdownMenuEntry<String>> get toDropdownMenuEntries => entries
      .map((e) => DropdownMenuEntry(value: e.value, label: e.key))
      .toList();
}

class _APIUtilAuthViewState extends State<APIUtilAuthView> {
  var requestBuilder = HttpRequestBuilder.getInstance();

  List<DropdownMenuEntry<String>> authTypes = {
    "No Auth": "noAuth",
    "Basic": "basic",
    "Bearer": "bearer",
    "Json Web Token": "jsonwebtoken",
  }.toDropdownMenuEntries;

  List<DropdownMenuEntry<String>> jwtAlgorithms = {
    "HS256": "HS256",
    "HS384": "HS384",
    "HS512": "HS512",
    "PS256": "PS256",
    "PS384": "PS384",
    "PS512": "PS512",
    "RS256": "RS256",
    "RS384": "RS384",
    "RS512": "RS512",
    "ES256": "ES256",
    "ES256K": "ES256K",
    "ES384": "ES384",
    "ES512": "ES512",
    "EdDSA": "EdDSA",
  }.toDropdownMenuEntries;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
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
            dropdownMenuEntries: authTypes,
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
                    initialSelection: requestBuilder.jwtAlgorithm.text,
                    requestFocusOnTap: true,
                    label: const Text('Algorithm'),
                    dropdownMenuEntries: jwtAlgorithms,
                    onSelected: (value) => setState(() {
                      requestBuilder.jwtAlgorithm.text = value ?? "HS256";
                    }),
                  ),
                ),
                SizedBox(height: 5),
                if (requestBuilder.isHashingAlgorithm)
                  SizedBox(
                    width: 250,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextField(
                            maxLines: 5,
                            keyboardType: TextInputType.multiline,
                            decoration: InputDecoration(
                              hintText: 'secret',
                              border: OutlineInputBorder(),
                              contentPadding: EdgeInsets.all(4),
                            ),
                            controller: requestBuilder.jwtSecret,
                          ),
                        ),
                        Row(
                          children: [
                            Checkbox(
                              value: requestBuilder.isSecretBase64,
                              onChanged: (value) => setState(() {
                                requestBuilder.isSecretBase64 = value ?? false;
                              }),
                            ),
                            Text("Secret Base64 encoded"),
                          ],
                        )
                      ],
                    ),
                  ),
                if (!requestBuilder.isHashingAlgorithm)
                  SizedBox(
                    width: 250,
                    child: Column(
                      children: [
                        TextButton(
                          onPressed: () async {
                            FilePickerResult? result =
                                await FilePicker.platform.pickFiles();
                            if (result != null) {
                              final fileContent = await result
                                  .files.single.xFile
                                  .readAsString();
                              setState(() {
                                requestBuilder.jwtPrivateKey.text = fileContent;
                              });
                            } else {
                              // User canceled the picker
                            }
                          },
                          child: Text("Select File"),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: 'Private key',
                              border: OutlineInputBorder(),
                              contentPadding: EdgeInsets.all(4),
                            ),
                            controller: requestBuilder.jwtPrivateKey,
                          ),
                        ),
                      ],
                    ),
                  ),
                SizedBox(height: 12),
                Padding(
                    padding: EdgeInsets.all(8),
                    child: TextField(
                      controller: requestBuilder.jwtPayload,
                      decoration: InputDecoration(
                        hintText: 'Payload',
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.all(4),
                      ),
                    )),
              ]),
            )
        ],
      ),
    );
  }
}
