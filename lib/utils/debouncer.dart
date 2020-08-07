import 'dart:async';
import 'package:flutter/material.dart';

class Debouncer{

  final int milliseconds;
  Timer _timer;

  Debouncer({this.milliseconds});

  run(VoidCallback action){
    if(null != _timer){
      _timer.cancel();
    }
    _timer = Timer(Duration(milliseconds: milliseconds),action);
  }

  static runAlone(VoidCallback action, int milliseconds){
    Timer timer = Timer(Duration(milliseconds: milliseconds),action);
    timer.cancel();
  }

  static Future<void> wait(){
    return Future.delayed(Duration(seconds: 2), (){});
  }
}