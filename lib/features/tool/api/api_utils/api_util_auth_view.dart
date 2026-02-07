import 'dart:core';
import 'package:flutter/material.dart';
import 'package:sengthaite_blog/extensions/file_picker.dart';
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
  var currentRequest = HttpRequestBuilder.getInstance().selectedDatum;

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
            initialSelection: currentRequest?.authType,
            requestFocusOnTap: true,
            label: const Text('Auth Type'),
            onSelected: (String? value) {
              setState(() {
                currentRequest?.authType = value ?? "noAuth";
                if (value == "noAuth") {
                  currentRequest?.clearAuth();
                }
              });
            },
            dropdownMenuEntries: authTypes,
          ),
          if (currentRequest?.authType == "basic")
            SizedBox(
              width: 250,
              child: Column(
                children: [
                  SizedBox(height: 12),
                  Padding(
                    padding: EdgeInsets.all(8),
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Username',
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.all(4),
                      ),
                      controller: currentRequest?.usernameController,
                    ),
                  ),
                  SizedBox(height: 5),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Password',
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.all(4),
                      ),
                      controller: currentRequest?.passwordController,
                    ),
                  ),
                ],
              ),
            ),
          if (currentRequest?.authType == "bearer")
            SizedBox(
              width: 250,
              child: Column(
                children: [
                  SizedBox(height: 12),
                  Padding(
                    padding: EdgeInsets.all(8),
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Bearer Token',
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.all(4),
                      ),
                      controller: currentRequest?.bearerController,
                    ),
                  ),
                ],
              ),
            ),
          if (currentRequest?.authType == "jsonwebtoken")
            SizedBox(
              width: 250,
              child: Column(
                children: [
                  SizedBox(height: 12),
                  Padding(
                    padding: EdgeInsets.all(8),
                    child: DropdownMenu(
                      initialSelection: currentRequest?.jwtAlgorithm.text,
                      requestFocusOnTap: true,
                      label: const Text('Algorithm'),
                      dropdownMenuEntries: jwtAlgorithms,
                      onSelected: (value) => setState(() {
                        currentRequest?.jwtAlgorithm.text = value ?? "HS256";
                      }),
                    ),
                  ),
                  SizedBox(height: 5),
                  if (currentRequest?.isHashingAlgorithm ?? false)
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
                              controller: currentRequest?.jwtSecret,
                            ),
                          ),
                          Row(
                            children: [
                              Checkbox(
                                value: currentRequest?.isSecretBase64,
                                onChanged: (value) => setState(() {
                                  currentRequest?.isSecretBase64 =
                                      value ?? false;
                                }),
                              ),
                              Text("Secret Base64 encoded"),
                            ],
                          ),
                        ],
                      ),
                    ),
                  if (!(currentRequest?.isHashingAlgorithm ?? true))
                    SizedBox(
                      width: 250,
                      child: Column(
                        children: [
                          TextButton(
                            onPressed: () async {
                              String? fileContent =
                                  await openFilePicker() ?? '';
                              setState(() {
                                currentRequest?.jwtPrivateKey.text =
                                    fileContent;
                              });
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
                              controller: currentRequest?.jwtPrivateKey,
                            ),
                          ),
                        ],
                      ),
                    ),
                  SizedBox(height: 12),
                  Padding(
                    padding: EdgeInsets.all(8),
                    child: TextField(
                      controller: currentRequest?.jwtPayload,
                      decoration: InputDecoration(
                        hintText: 'Payload',
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.all(4),
                      ),
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
