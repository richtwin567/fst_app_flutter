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
    return InkWell(
      borderRadius: BorderRadius.circular(24),
      onTap: (() {
        Navigator.pushNamed(context,route);
      }),
      child: Card(
        elevation: 10.0,
        shape: RoundedRectangleBorder(
          side: BorderSide(color: Colors.white70, width: 1),
          borderRadius: BorderRadius.circular(24),
        ),
        child: Container(
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
                        color: Colors.white,
                      )),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: Colors.blue[900])),
                  SizedBox(height: queryData.size.longestSide * 0.02),
                  Text(
                    title,
                    style: TextStyle(
                        color: Colors.blue[900],
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
