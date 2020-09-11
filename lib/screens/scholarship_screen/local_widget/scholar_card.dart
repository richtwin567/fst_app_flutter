import 'package:flutter/material.dart';
import 'package:fst_app_flutter/models/from_postgres/scholarship/scholarship.dart';
import 'package:fst_app_flutter/screens/scholarship_screen/scholarship_detailsview.dart';

///Widget used by [ScholarshipMobile] to display the elements of the lists from [ScholarshipList]
//TODO: documentation @palmer-matthew

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

  /// Builds the transition for [ScholarshipDetails], Transition:  Slide In from the left
  PageRouteBuilder _buildTransition(){
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => ScholarshipDetailsView(current: scholarship,),
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