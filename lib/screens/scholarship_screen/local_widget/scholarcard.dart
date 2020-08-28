import 'package:flutter/material.dart';
import 'package:fst_app_flutter/models/from_postgres/scholarship/scholarship.dart';
import 'package:fst_app_flutter/models/preferences/theme_model.dart';
import 'package:fst_app_flutter/screens/scholarship_screen/scholarship_details.dart';
import 'package:provider/provider.dart';

///Widget used by [ScholarshipMobile] to display the elements of the lists from [ScholarshipList]

class ScholarCard extends StatelessWidget {
  final Scholarship scholarship;

  const ScholarCard({this.scholarship});

  @override
  Widget build(BuildContext context) {
    bool isDark = Provider.of<ThemeModel>(context).selectedTheme == ThemeMode.dark;

    return Card(
      margin: EdgeInsets.zero,
      elevation: 0,
      shape: Border(
        bottom: BorderSide(
          color: isDark ? Colors.grey[800] : Theme.of(context).primaryColor,
          width: 1,
        ),
      ),
      child: ListTile(
        contentPadding: EdgeInsets.fromLTRB(10.0,8.0,0,8.0),
        title: Text(scholarship.scholarshipName),
        trailing: Icon(
          Icons.arrow_forward_ios,
          size: 18,
        ),
        onTap: () {
          Navigator.of(context).push(_buildTransition());
        },
      ),
    );
  }

  /// Builds the transition for [ScholarshipDetails], Transition:  Slide In from the left
  PageRouteBuilder _buildTransition(){
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => ScholarshipDetails(current: scholarship),
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