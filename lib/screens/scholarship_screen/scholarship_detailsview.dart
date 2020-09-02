import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import 'package:fst_app_flutter/models/preferences/theme_model.dart';
import 'package:fst_app_flutter/models/from_postgres/scholarship/scholarship.dart';

class ScholarshipDetailsView extends StatelessWidget {

  final Scholarship current;
  final Map<String, bool> theme = {'isDark': null};
  final Map<String, ThemeData> t = {'theme': null};

  ScholarshipDetailsView({this.current});

  Widget _buildAppBar(){
    return AppBar(
        title: Text(
          current.scholarshipName,
        ),
        bottom: TabBar(
          indicatorColor: Colors.white,
          tabs: [
            _buildTab('Description'),
            _buildTab('Details'),
          ],
        ),
      );
  }

  Tab _buildTab(String text){
    return Tab(
      child: Text(
        text,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
      ),
    );
  }

  Widget _buildPage(String zone){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: ListView(
        physics: AlwaysScrollableScrollPhysics(),
        children: zone == "Description" ? buildDescriptionContent() : buildDetailContent(),
      ),
    );
  }

  Widget buildListTile(String title, content, bool inList){
    
    if(content == "" && inList){
      return ListTile(
        // leading: Container(
        //   height: 5.0,
        //   width: 5.0,
        //   decoration: new BoxDecoration(
        //     color: Colors.grey.shade900,
        //     shape: BoxShape.circle,
        //   ),
        // ),
        title: Text(
          "\u2022  " + title,
        ),
      );
    }else if(content is! String){
      return ListTile(
      title: Text(title),
      subtitle: content,
      contentPadding: const EdgeInsets.symmetric(vertical: 10),
    );
    }

    return ListTile(
      title: Text(title),
      subtitle: Text(content),
      contentPadding: const EdgeInsets.symmetric(vertical: 10),
    );
  }

  Widget buildListingTile(title, content){
    List<Widget> primaryWidget = List.empty(growable: true);
    List<Widget> secondaryWidgets = List.empty(growable: true);
    List<String> secondary;

    try {
      if(content.contains(":")){
        List<String> list = content.split(":");
        if(list[1].contains(";") && list.length == 2){
          secondary = list[1].split(";");
          for(String b in secondary){
            if(b != ""){
              secondaryWidgets.add(buildListTile(b, "", true));
            }
          }
          return ListBody(
            children: [
              buildListTile(title, list[0], false), 
              Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: secondaryWidgets,
                ),
              ),
              SizedBox(
                height: 20,
              ),
            ],
          );
        }else if(list[1].contains(";") && list.length == 3){
          secondary = list[1].split(";");
          for(String b in secondary){
            if(b != ""){
              secondaryWidgets.add(buildListTile(b, "", true));
            }
          }
          primaryWidget.add(buildListTile(title, "", false));
          primaryWidget.add(
            buildListTile(
              list[0], 
              Padding(
                padding: const EdgeInsets.only(left: 18.0),
                child: ListBody(
                  children: secondaryWidgets,
                ),
              ),
              false));
          primaryWidget.add(buildListTile(list[2], "", false));
          return ListBody(
            children: primaryWidget,
          );
        }else{
          return buildListTile(title, list[1], false);
        }
      }else if(content.contains(";")){
        List<String> list = content.split(";");
        for(String b in list){
          if(b != ""){
            secondaryWidgets.add(buildListTile(b, "", true));
          }
        }
        return ListBody(
          children: [
            buildListTile(title, "", false), 
            Padding(
              padding: const EdgeInsets.only(left: 18.0),
              child: ListBody(
                children: secondaryWidgets,
              ),
            ),
            SizedBox(
              height: 20,
            ),
          ],
        );
      }else{
        return buildListTile(title, content, false);
      }
    } on Exception catch (e) {
      print(e);
      return Center(child: Text(title));
    }

  }

  List<Widget> buildDescriptionContent(){
    List<Widget> result = List.empty(growable: true);
    try{
      
      if(current.scholarshipAwards != null){
        result.add(buildListTile('Number of Awards', current.scholarshipAwards, false));
      }

      if(current.scholarshipValue != null){
        result.add(buildListTile('Value', current.scholarshipValue, false));
      }

      if(current.scholarshipTenure != null){
        result.add(buildListTile('Maximum Tenure', current.scholarshipTenure , false));
      }

      if(current.scholarshipEligibility != null){
        result.add(buildListingTile("Eligibility", current.scholarshipEligibility));
      }

    }on Exception catch(e){
      print(e);
      result = <Widget>[Center(child: Text("Something went wrong")),];
    }
    return result;
  }

  List<Widget> buildDetailContent(){
    List<Widget> result = List.empty(growable: true);
    //details, criteria, method, special, condition,
    try{

      if(current.scholarshipCriteria != null){
        result.add(buildListingTile("Criteria", current.scholarshipCriteria));
      }

      if(current.scholarshipMethod != null){
        result.add(buildListingTile("Method Of Selection", current.scholarshipMethod));
      }

      if(current.scholarshipSpecial != null){
        result.add(buildListingTile("Special Requirements", current.scholarshipSpecial));
      }

      if(current.scholarshipCondition != null){
        result.add(buildListingTile("Condition", current.scholarshipCondition));
      }
      
      if(current.scholarshipDetails != null){
        result.add(buildListingTile("Additional Details", current.scholarshipDetails));
      }
      
    }on Exception catch(e){
      print(e);
      result = <Widget>[Center(child: Text("Something went wrong")),];
    }
    return result;
  }

  
  @override
  Widget build(BuildContext context) {
    ThemeModel themeModel = Provider.of<ThemeModel>(context, listen: false,);
    t['theme'] = Theme.of(context);
    theme['isDark'] = themeModel.selectedTheme == ThemeMode.dark ||
        (themeModel.selectedTheme == ThemeMode.system && SchedulerBinding.instance.window.platformBrightness == Brightness.dark);
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: _buildAppBar(),
          body: TabBarView(
            children: [
                _buildPage('Description'),
                _buildPage('Details'),
            ],
          ),
        ),
      );
  }
}