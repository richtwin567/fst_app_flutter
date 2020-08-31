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
    return ListView(
      children: zone == "Description" ? parse(current.description) : parse(current.details),
    );
  }

  List<Widget> parse(String content){

    List<String> catergory_split = content.split('@');
    String titleContent;
    String title;
    String singleLine;
    List<String> list;
    List<Widget> result = List.empty(growable: true);
    try {
      for (String a in catergory_split){
        List<String> titleSplit = a.split(":");
        title = titleSplit[0];
        titleContent = titleSplit[1];
        if(titleContent.contains("=")){
          list = titleContent.split("=");
          singleLine = list[0];
          List<String> listing = list[1].split(";");
          List<Widget> listing_widget = List.empty(growable: true);
          for(String b in listing){
            listing_widget.add(ListTile(
              leading: Icon(Icons.stop),
              title: Text(
                b,
                style: TextStyle(
                  fontSize: 13,
                ),
              ),
            ));
          }
          result.add(ListBody(
            children: [
              ListTile(
                title: Text(title), 
                subtitle: Text(singleLine),
              ), 
              Padding(
                padding: const EdgeInsets.only(left: 18.0),
                child: ListBody(
                  children: listing_widget,
                ),
              ),
              SizedBox(
                height: 20,
              ),
            ],
          ));
        }else{
          result.add(ListTile(title: Text(title), subtitle: Text(titleContent),));
        }
      }
    } on Exception catch (e) {
      print(e);
      result = <Widget>[Text('Something went wrong'),];
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