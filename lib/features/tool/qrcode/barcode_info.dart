/*
 * Copyright (C) 2020, David PHAM-VAN <dev.nfet.net@gmail.com>
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

import 'package:flutter/material.dart';
import 'package:sengthaite_blog/constants/theme.dart';

import 'barcode_conf.dart';

class BarcodeInfo extends StatelessWidget {
  const BarcodeInfo({
    super.key,
    required this.conf,
  });

  final BarcodeConf conf;

  @override
  Widget build(BuildContext context) {
    var textTheme = MaterialTheme.textTheme();
    final bc = conf.barcode;

    final charset = StringBuffer();
    for (var c in bc.charSet) {
      if (c > 0x20) {
        charset.write('${String.fromCharCode(c)} ');
      } else {
        charset.write('0x${c.toRadixString(16)} ');
      }
    }

    return Center(
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: '${bc.name}\n',
                  style: textTheme.bodyMedium!.copyWith(
                      fontWeight: FontWeight.bold, fontSize: 30),
                ),
                 TextSpan(
                  text: '\nDescription:\n',
                  style: textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                TextSpan(
                  text: '${conf.desc}\n',
                ),
                 TextSpan(
                  text: '\nAccepted data:\n',
                  style: textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                TextSpan(
                  text: '$charset\n\n',
                ),
                TextSpan(
                  text: 'Minimum length: ${bc.minLength}\n',
                  style: textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.bold),
                ),
                // if (bc.maxLength < Barcode.infiniteMaxLength)
                TextSpan(
                  text: 'Maximum length: ${bc.maxLength}\n',
                  style: textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.bold),
                ),
              ],
            ),
            // textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
