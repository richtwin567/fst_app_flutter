import 'package:flutter/material.dart';
import 'package:fst_app_flutter/widgets/app_drawer/app_drawer.dart';

class AppDrawerMobileLayout extends StatelessWidget {
  const AppDrawerMobileLayout({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MediaQueryData queryData = MediaQuery.of(context);

    return OrientationBuilder(
      builder: (context, orientation) => Container(
          width: orientation == Orientation.portrait
              ? 250
              : queryData.size.width * 0.2,
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            boxShadow: [
              BoxShadow(
                blurRadius: 16,
                color: Colors.black12,
              )
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: AppDrawer.getDrawerOptions(),
          )),
    );
  }
}
