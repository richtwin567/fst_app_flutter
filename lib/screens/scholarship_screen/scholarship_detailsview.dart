import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import 'package:fst_app_flutter/models/preferences/theme_model.dart';
import 'package:fst_app_flutter/models/from_postgres/scholarship/scholarship.dart';
import 'package:clipboard/clipboard.dart';

class ScholarshipDetailsView extends StatelessWidget {

  final Scholarship current;
  final Map<String, dynamic> theme = {'isDark': null, 'theme': null};

  ScholarshipDetailsView({this.current});

  Widget _buildAppBar(){
    return AppBar(
        title: Text(
          current.scholarshipName,
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.content_copy), 
            onPressed: (){
              FlutterClipboard.copy(current.toString()).then(( value ) => print('copied'));
            },
            tooltip: "Copy to Clipboard",
          )
        ],
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
          fontSize: 16,
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
      return UnorderedListItem(title, theme['isDark']);
    }else if(content is! String){
      return ListTile(
        title: SelectableText(
          title,
          toolbarOptions: ToolbarOptions(copy: true, selectAll: true,),
        ),
        subtitle: content,
      );
    }

    return ListTile(
      visualDensity: VisualDensity(vertical: -2.0, horizontal: 1.0),
      title: SelectableText(
          title,
          toolbarOptions: ToolbarOptions(copy: true, selectAll: true,),
        ),
      subtitle: SelectableText(
          content,
          toolbarOptions: ToolbarOptions(copy: true, selectAll: true,),
        ),
    );
  }

  Widget buildDivider(){
    return Divider(
      color: theme['isDark'] ? Colors.white30 : Colors.black12,
    );
  }

  Widget buildListingTile(title, content){
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
              secondaryWidgets.add(SizedBox(height: 5));
            }
          }
          secondaryWidgets.add(SizedBox(height:10));
          return ListBody(
            children: [
              buildListTile(title, list[0]+":", false), 
              Padding(
                padding: const EdgeInsets.only(left: 30.0),
                child: Column(
                  children: secondaryWidgets,
                ),
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
          return buildListTile(
            title,
            Padding(
            padding: const EdgeInsets.only(left: 18.0),
            child: ListBody(
              children: [
                buildListTile(list[0], "", true),
                SizedBox(height: 10.0),
                Padding(
                  padding: const EdgeInsets.only(left: 18.0),
                  child: ListBody(
                    children: secondaryWidgets,
                  ),
                ),
                SizedBox(height: 10.0),
                buildListTile(list[2], "", true),
              ],
            ),
          ),false);
        }else if(list.length == 2 && !list[1].contains(";")){
          return ListBody(
            children: [
              buildListTile(title, list[0]+":", false),
              Padding(
                padding: const EdgeInsets.only(left: 30.0),
                child: Column(
                  children: [buildListTile(list[1], "", true), SizedBox(height: 10)],
                ),
              ),
            ],
          );
        }else {
          return buildListTile(title, list[1], false);
        }
      }else if(content.contains(";")){
        List<String> list = content.split(";");
        for(String b in list){
          if(b != ""){
            secondaryWidgets.add(buildListTile(b, "", true));
          }
        }
        return buildListTile(
          title, 
          Padding(
            padding: const EdgeInsets.only(left: 18.0),
            child: ListBody(
              children: secondaryWidgets,
            ),
          ), false);
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
        result.addAll([buildListTile('Number of Awards', current.scholarshipAwards, false), buildDivider()]);
      }

      if(current.scholarshipValue != null){
        result.addAll([buildListTile('Value', current.scholarshipValue, false), buildDivider()]);
      }

      if(current.scholarshipTenure != null){
        result.addAll([buildListTile('Maximum Tenure', current.scholarshipTenure , false), buildDivider()]);
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

    try{

      if(current.scholarshipCriteria != null){
        result.addAll([buildListingTile("Criteria", current.scholarshipCriteria), buildDivider()]);
      }

      if(current.scholarshipMethod != null){
        result.addAll([buildListingTile("Method Of Selection", current.scholarshipMethod), buildDivider()]);
      }

      if(current.scholarshipSpecial != null){
        result.addAll([buildListingTile("Special Requirements", current.scholarshipSpecial), buildDivider()]);
      }

      if(current.scholarshipCondition != null){
        result.addAll([buildListingTile("Condition", current.scholarshipCondition), buildDivider()]);
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
    theme['theme'] = Theme.of(context);
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

class UnorderedListItem extends StatelessWidget {
  UnorderedListItem(this.text, this.isDark);
  final String text;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          margin: const EdgeInsets.only(top: 7, right: 8),
          height: 5.0,
          width: 5.0,
          decoration: new BoxDecoration(
            color: isDark ? Colors.white60 : Colors.black45,
            shape: BoxShape.circle,
          ),
        ),
        Expanded(
          child: SelectableText(
            text,
            style: TextStyle(
              color: isDark ? Colors.white54 : Colors.black45,
            ),
            toolbarOptions: ToolbarOptions(copy: true, selectAll: true,),
          ),
        ),
      ],
    );
  }
}