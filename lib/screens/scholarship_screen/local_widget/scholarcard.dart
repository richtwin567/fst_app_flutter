import 'package:flutter/material.dart';
import 'package:fst_app_flutter/models/scholarship.dart';
import 'package:fst_app_flutter/screens/scholarship_screen/scholarship_details.dart';

class ScholarCard extends StatelessWidget {
  final Scholarship scholarship;

  const ScholarCard({this.scholarship});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: ListTile(
          title: Text(scholarship.scholarshipName),
          trailing: Icon(
            Icons.arrow_forward_ios,
            size: 18,
          ),
          onTap: () {
            Navigator.of(context).push(_buildTransition());
          },
        ),
      ),
    );
  }

  PageRouteBuilder _buildTransition(){
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => ScholarshipView(current: scholarship),
      transitionDuration: Duration(milliseconds: 500,),
      transitionsBuilder: (context, animation, secondaryAnimation, child){
        animation = CurvedAnimation(
          curve: Curves.easeOut, 
          parent: animation,
        );
        return SlideTransition(
          position: Tween(
            begin: Offset(1.0,0.0), 
            end: Offset(0.0, 0.0)
          ).animate(animation),
          child: child,
        );
      },
    );
  }
}