import 'package:flutter/material.dart';

/// Notifies the contact screen of changes.
class ContactViewModel extends ChangeNotifier {
  void initialise() {
    notifyListeners();
  }
}
