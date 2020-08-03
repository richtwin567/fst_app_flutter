import 'package:flutter/material.dart';

class ContactViewModel extends ChangeNotifier {
  String title='title';

  void initialise() {
    title = 'works';
    notifyListeners();
  }
}
