import 'package:permission_handler/permission_handler.dart';

// TODO: document @richtwin567
Future<bool> requestPermission(Permission p) async {
  return await p.request().isGranted;
}
