import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sengthaite_blog/components/http_response_view.dart';
import 'package:sengthaite_blog/extensions/http_ext.dart';
import 'package:sengthaite_blog/extensions/string_ext.dart';
import 'package:sengthaite_blog/features/tool/api/api_request_builder.dart';

class APIViewMobile extends StatefulWidget {
  const APIViewMobile({super.key});

  @override
  State<APIViewMobile> createState() => _APIViewDesktopState();
}

class _APIViewDesktopState extends State<APIViewMobile> {
  bool allowSubmitRequest = false;
  Color? methodColor = HttpRequestMethodTypeExtension.methodByDisplay(
    HttpRequestMethodTypeExtension.defaultHttpMethod,
  )?.color;

  @override
  void dispose() {
    super.dispose();
    HttpRequestBuilder.getInstance().removeInstance();
  }

  @override
  Widget build(BuildContext context) {
    final selectedData = context.watch<HttpRestRequestDatum>();
    return Row(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  DropdownMenu(
                    width: 118,
                    textStyle: TextStyle(
                      color: methodColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 10,
                    ),
                    initialSelection:
                        selectedData.getRequestMethod ??
                        HttpRequestMethodTypeExtension.defaultHttpMethod,
                    requestFocusOnTap: false,
                    dropdownMenuEntries: HttpRequestMethodTypeExtension
                        .listRequestMethods
                        .map((e) => DropdownMenuEntry(value: e, label: e))
                        .toList(),
                    onSelected: (value) {
                      if (value == null) return;
                      selectedData.setRequestMethod = value;
                      setState(() {
                        methodColor =
                            HttpRequestMethodTypeExtension.methodByDisplay(
                              value,
                            )?.color;
                      });
                    },
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: TextFormField(
                      textInputAction: TextInputAction.done,
                      style: const TextStyle(fontSize: 10,),
                      controller: selectedData.urlInputController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "URL",
                      ),
                      onChanged: (value) {
                        setState(() => allowSubmitRequest = value.isUrl);
                      },
                      onFieldSubmitted: (value) {
                        allowSubmitRequest ? selectedData.request() : null;
                      },
                    ),
                  ),
                ],
              ),
              Expanded(
                child:
                    selectedData.response != null && !selectedData.isRequesting
                    ? HttpResponseView(response: selectedData.response)
                    : Center(
                        child: selectedData.isRequesting
                            ? const CircularProgressIndicator()
                            : const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text("Empty response"),
                              ),
                      ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 8),
      ],
    );
  }
}
