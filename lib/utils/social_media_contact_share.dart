import 'package:flutter/material.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:fst_app_flutter/models/sharing/vcard.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:io';

openWhatsAppChat({@required String phone, String message = ''}) async {
  String formatUrl() {
    if (Platform.isIOS) {
      return 'whatsapp://wa.me/$phone/?text=${Uri.parse(message)}';
    } else {
      return 'whatsapp://send?phone=$phone&text=${Uri.parse(message)}';
    }
  }

  if (await canLaunch(formatUrl())) {
    try {
      await launch((formatUrl()));
    } catch (e) {}
  }
}

shareContactToWhatsApp(VCard vCard) async {
  try {
    String filepath = '${Directory.systemTemp.parent.path}/cache/temp.vcf';
    File vcf = File(filepath)..createSync();
    vcf.writeAsStringSync(vCard.vcf);
    await FlutterShare.shareFile(
      title: 'Share contact',
      text: 'Share contact',
      chooserTitle: 'Share contact with',
      filePath: filepath,
    );
  } catch (e) {
    //print(e);
  }
}
