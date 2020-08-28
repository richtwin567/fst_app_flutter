import 'package:permission_handler/permission_handler.dart';

bool requestPermission(Permission p) {
  bool granted = false;
  p.request().isGranted.then((value) {
    granted = value;
  });
  return granted;
}
