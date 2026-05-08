import 'package:flutter/material.dart';

import 'barcode.dart';
import 'barcode_conf.dart';
import 'barcode_info.dart';
import 'code.dart';
import 'settings.dart';

class QrbarcodeViewMobile extends StatefulWidget {
  const QrbarcodeViewMobile({super.key});

  @override
  State<QrbarcodeViewMobile> createState() => _QrbarcodeViewMobileState();
}

class _QrbarcodeViewMobileState extends State<QrbarcodeViewMobile> {
  final BarcodeConf conf = BarcodeConf();

  @override
  void initState() {
    conf.addListener(confListener);
    super.initState();
  }

  @override
  void dispose() {
    conf.removeListener(confListener);
    super.dispose();
  }

  void confListener() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Container(
        child: width < 800
            ? ListView(
                children: <Widget>[
                  Settings(conf: conf),
                  BarcodeView(conf: conf),
                  BarcodeInfo(conf: conf),
                  Code(conf: conf),
                ],
              )
            : Row(
                children: [
                  SizedBox(
                    width: 400,
                    child: Column(
                      children: [
                        Settings(conf: conf),
                        Code(conf: conf),
                      ],
                    ),
                  ),
                  const SizedBox(width: 20),
                  Flexible(
                    child: ListView(
                      children: <Widget>[
                        BarcodeView(conf: conf),
                        BarcodeInfo(conf: conf),
                      ],
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
