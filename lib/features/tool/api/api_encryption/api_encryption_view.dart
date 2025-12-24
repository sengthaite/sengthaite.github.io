import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:sengthaite_blog/constants/enum.constants.dart';
import 'package:sengthaite_blog/constants/theme.dart';
import 'package:sengthaite_blog/features/tool/api/api_request_builder.dart';
import 'package:sengthaite_blog/features/tool/api/api_util_table_data.dart';

class APICryptoSelectionView extends StatefulWidget {
  final APIRowData dataRow;
  const APICryptoSelectionView({super.key, required this.dataRow});

  @override
  State<APICryptoSelectionView> createState() => _APICryptoSelectionViewState();
}

class _APICryptoSelectionViewState extends State<APICryptoSelectionView> {
  int selectedCryptoTypeIndex = 0;

  TextEditingController dataController = TextEditingController();
  TextEditingController keyController = TextEditingController();
  TextEditingController privateKeyController = TextEditingController();
  TextEditingController ivController = TextEditingController();
  TextEditingController nonceController = TextEditingController();
  TextEditingController aadController = TextEditingController();
  TextEditingController blockSizeController = TextEditingController();

  List<Widget> get inputWidget {
    CryptoType cryptoType = CryptoType.fromIndex(selectedCryptoTypeIndex);
    switch (cryptoType) {
      case CryptoType.aesCCMAEAD:
      case CryptoType.aesChaCha20Poly1305AEAD:
        return [
          TextFormField(
            controller: dataController,
            decoration: const InputDecoration(hintText: "data"),
          ),
          TextFormField(
            controller: keyController,
            decoration: const InputDecoration(hintText: "Key"),
          ),
          TextFormField(
            controller: nonceController,
            decoration: const InputDecoration(hintText: "Nonce"),
          ),
          TextFormField(
            controller: aadController,
            decoration: const InputDecoration(
              hintText: "AAD (Additional Authenticated Data)",
            ),
          ),
        ];
      case CryptoType.rsa:
      case CryptoType.rsaOAEP:
        return [
          TextFormField(
            controller: dataController,
            decoration: const InputDecoration(hintText: "data"),
          ),
          TextFormField(
            controller: keyController,
            decoration: const InputDecoration(hintText: "Public Key"),
          ),
          TextFormField(
            controller: privateKeyController,
            decoration: const InputDecoration(hintText: "Private Key"),
          ),
        ];
      default:
        return [
          TextFormField(
            controller: dataController,
            decoration: const InputDecoration(hintText: "data"),
          ),
          TextFormField(
            controller: keyController,
            decoration: const InputDecoration(hintText: "Key"),
          ),
          TextFormField(
            controller: ivController,
            decoration: const InputDecoration(hintText: "IV"),
          ),
          if (cryptoType == CryptoType.aesOFB)
            TextFormField(
              controller: blockSizeController,
              decoration: const InputDecoration(hintText: "Block Size"),
            ),
        ];
    }
  }

  void _reset() {
    dataController.clear();
    keyController.clear();
    privateKeyController.clear();
    ivController.clear();
    nonceController.clear();
    aadController.clear();
    blockSizeController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: AlertDialog(
        title: const Text("Add Crypto"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                const Text("Crypto Type: "),
                const SizedBox(width: 8),
                DropdownButton<int>(
                  value: selectedCryptoTypeIndex,
                  items: List.generate(CryptoType.values.length, (value) {
                    return DropdownMenuItem(
                      value: value,
                      child: Text(CryptoType.values[value].value),
                    );
                  }),
                  onChanged: (value) {
                    setState(() {
                      if (selectedCryptoTypeIndex == value) return;
                      _reset();
                      selectedCryptoTypeIndex = value ?? 0;
                    });
                  },
                ),
              ],
            ),
            ...inputWidget,
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text("Save"),
          ),
        ],
      ),
    );
  }
}

class APIEncryptionView extends StatefulWidget {
  const APIEncryptionView({super.key});

  @override
  State<APIEncryptionView> createState() => _APIEncryptionViewState();
}

class _APIEncryptionViewState extends State<APIEncryptionView> {
  var currentRequest =
      HttpRequestBuilder.getInstance().selectedDatum?.cryptoData;
  var textTheme = MaterialTheme.textTheme();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        child: Table(
          defaultVerticalAlignment: TableCellVerticalAlignment.middle,
          columnWidths: const {
            0: FixedColumnWidth(40),
            4: FixedColumnWidth(40),
          },
          border: TableBorder.all(
            borderRadius: const BorderRadius.all(Radius.circular(4)),
          ),
          children: [
            TableRow(
              children: [
                Checkbox(
                  value: currentRequest?.selectedAll ?? true,
                  onChanged: (value) {
                    currentRequest?.toggleAllRow();
                    setState(() => currentRequest?.selectedAll = value);
                  },
                ),
                 Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "Key",
                    textAlign: TextAlign.center,
                    style: textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.bold),
                  ),
                ),
                 Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "Value",
                    textAlign: TextAlign.center,
                    style: textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.bold),
                  ),
                ),
                 Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "Description",
                    textAlign: TextAlign.center,
                    style: textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.bold),
                  ),
                ),
                IconButton(
                  splashColor: Colors.transparent,
                  color: Colors.transparent,
                  highlightColor: Colors.transparent,
                  focusColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  onPressed: () =>
                      setState(() => currentRequest?.add(APIRowData())),
                  icon: Icon(MdiIcons.plus, color: Colors.green),
                ),
              ],
            ),
            ...List.generate(currentRequest?.controllers.length ?? 0, (index) {
              var dataRow = currentRequest?.controllers[index];
              return TableRow(
                children: [
                  Checkbox(
                    value: dataRow?.isSelected,
                    onChanged: (value) => setState(
                      () => currentRequest?.toggleRowSelectionAt(index),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      style: textTheme.bodyMedium!.copyWith(fontSize: 12),
                      enableSuggestions: false,
                      maxLines: null,
                      keyboardType: TextInputType.multiline,
                      decoration: const InputDecoration(
                        hintText: "Key",
                        border: InputBorder.none,
                      ),
                      controller: dataRow?.keyController,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: MaterialButton(
                      color: Colors.orange,
                      textColor: Colors.white,
                      onPressed: () {
                        showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (BuildContext context) {
                            return APICryptoSelectionView(
                              dataRow: dataRow ?? APIRowData(),
                            );
                          },
                        );
                      },
                      child: Text(
                        "Add Crypto",
                        style: textTheme.bodyMedium!.copyWith(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      style: textTheme.bodyMedium!.copyWith(fontSize: 12),
                      enableSuggestions: false,
                      maxLines: null,
                      keyboardType: TextInputType.multiline,
                      decoration: const InputDecoration(
                        hintText: "Description",
                        border: InputBorder.none,
                      ),
                      controller: dataRow?.descriptionController,
                    ),
                  ),
                  (dataRow?.allowDeletion ?? false)
                      ? IconButton(
                          splashColor: Colors.transparent,
                          color: Colors.transparent,
                          highlightColor: Colors.transparent,
                          focusColor: Colors.transparent,
                          hoverColor: Colors.transparent,
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () {
                            setState(() {
                              currentRequest?.removeAt(index);
                            });
                          },
                        )
                      : const SizedBox(),
                ],
              );
            }),
          ],
        ),
      ),
    );
  }
}
