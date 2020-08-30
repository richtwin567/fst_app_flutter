import 'package:permission_handler/permission_handler.dart';

Future<bool> requestPermission(Permission p) async {
  return await p.request().isGranted;
}
