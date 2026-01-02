import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'barcode_conf.dart';
import 'barcode_error.dart';
import 'download.dart';

class BarcodeView extends StatelessWidget {
  const BarcodeView({
    super.key,
    required this.conf,
  });

  final BarcodeConf conf;

  @override
  Widget build(BuildContext context) {
    try {
      conf.barcode.verify(conf.normalizedData);
    } on BarcodeException catch (error) {
      return BarcodeError(message: error.message);
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Center(
        child: Card(
          child: Column(
            children: [
              BarcodeWidget(
                barcode: conf.barcode,
                data: conf.normalizedData,
                width: conf.width,
                height: conf.height,
                style: GoogleFonts.sourceCodePro(
                  textStyle: TextStyle(
                    fontSize: conf.fontSize,
                    color: Colors.black,
                  ),
                ),
                margin: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 20,
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                ),
              ),
              Download(conf: conf),
            ],
          ),
        ),
      ),
    );
  }
}
