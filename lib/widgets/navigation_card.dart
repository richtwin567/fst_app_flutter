import 'package:flutter/material.dart';

class NavigationCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String route;
  final String additionalDetails;
  final double height;
  final double width;
  const NavigationCard(
      {Key key,
      @required this.icon,
      @required this.title,
      @required this.height,
      @required this.width,
      this.route,
      this.additionalDetails})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    MediaQueryData queryData = MediaQuery.of(context);
    return Card(
        elevation: 2.0,
        shape: RoundedRectangleBorder(
          side: BorderSide.none,
          borderRadius: BorderRadius.circular(24),
        ), 
        child: InkWell(
      onTap: () => Navigator.pushNamed(context, route),
          child:Container(
            height: height,
            width: width,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                      height: queryData.size.shortestSide * 0.1,
                      width: queryData.size.shortestSide * 0.1,
                      child: Center(
                          child: Icon(
                        icon,
                      )),),
                  SizedBox(height: queryData.size.longestSide * 0.02),
                  Text(
                    title,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: queryData.size.shortestSide * 0.05064),
                    textAlign: TextAlign.center,
                  )
                ],
              ),
            )),
      ),
    );
  }
}
