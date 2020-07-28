import 'package:flutter/material.dart';
import 'package:fst_app_flutter/models/home_view_model.dart';
import 'package:fst_app_flutter/widgets/app_drawer/app_drawer.dart';
import 'package:fst_app_flutter/widgets/base_data_model_widget.dart';

class HomeTablet extends BaseModelWidget<HomeViewModel> {
  @override
  Widget build(BuildContext context, HomeViewModel model) {
    var children = [
      Expanded(
        child: Container(),
      ),
      AppDrawer()
    ];
    var orientation = MediaQuery.of(context).orientation;
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          model.updateTitle();
        },
      ),
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
