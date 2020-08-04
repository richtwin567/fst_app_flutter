import 'package:flutter/material.dart';
import 'package:fst_app_flutter/widgets/app_drawer/app_drawer.dart';

class HomeTablet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var children = [
      Expanded(
        child: Container(
          child: Expanded(
            child: Center(
              child: Text("To Be Added"),
            ),
          ),
        ),
      ),
      AppDrawer(),
    ];
    var orientation = MediaQuery.of(context).orientation;
    return Scaffold(
      body: orientation == Orientation.portrait
          ? Column(
              children: children,
            )
          : Row(
              children: children.reversed.toList(),
            ),
    );
  }
}
