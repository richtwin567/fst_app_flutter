import 'package:flutter/material.dart';
import 'package:fst_app_flutter/utils/open_url.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share/share.dart';
import 'package:fst_app_flutter/models/sharing/vcard.dart';
import 'package:fst_app_flutter/utils/permissions.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:io';

// TODO: document @richtwin567

openWhatsAppChat({@required String phone, String message = ''}) async {
  String formatUrl() {
    if (Platform.isIOS) {
      return 'whatsapp://wa.me/$phone/?text=${Uri.parse(message)}';
    } else {
      return 'whatsapp://send?phone=$phone&text=${Uri.parse(message)}';
    }
  }

  await openUrl(formatUrl());
}

shareContactToWhatsApp(VCard vCard) async {
  try {
    final RegExp filenameCheck = RegExp(r'^([><":?\/\\*|,;\[\]]*)$');
    var filename = (vCard.name.toLowerCase().split(' ')
          ..removeWhere((e) => e == '-' || e == '_'))
        .reduce((value, element) => value + '-' + element)
        .toString();
    if (!filenameCheck.hasMatch(filename)) {
      if (await requestPermission(Permission.storage)) {
        String filepath =
            join((await getTemporaryDirectory()).path, '$filename.vcf');
        File vcf = File(filepath)..createSync();
        vcf.writeAsStringSync(vCard.vcf);
        await Share.shareFiles(
          [filepath],
          mimeTypes: ['text/directory'],
          subject: vCard.name + "'s contact",
          text: vCard.name
        );
      }
    }
  } catch (e) {}
}
