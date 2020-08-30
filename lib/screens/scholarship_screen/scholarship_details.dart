import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import 'package:fst_app_flutter/models/preferences/theme_model.dart';
import 'package:fst_app_flutter/models/from_postgres/scholarship/scholarship.dart';

///Widget used to display the details of the [Scholarship] from a [ScholarCard]
class ScholarshipDetails extends StatefulWidget {
  final Scholarship current;

  ScholarshipDetails({this.current});

  @override
  _ScholarshipDetailsState createState() => _ScholarshipDetailsState();
}

class _ScholarshipDetailsState extends State<ScholarshipDetails> {
  final  _scroll = ScrollController();
  bool isDark; //Boolean to represent if the current Theme Mode is Dark Mode

  void dispose(){
    _scroll.dispose();
    super.dispose();
  }

  /// Builds the [AppBar] Widget for the screen
  /// The colour of the widget will depend on what the [ThemeMode] is
  Widget _buildAppBar(){
    return AppBar(
        title: Text(widget.current.scholarshipName),
        backgroundColor: isDark ? Colors.grey[900] : Theme.of(context).primaryColor,
      );
  }


  //returns a Card Widget which used to dispaly the header and content
  Widget _buildCard(String text, String content){
    return Card(
      color: isDark ? ElevationOverlay.applyOverlay(context, Colors.grey[900], 0) : Colors.grey[50],
      elevation: 3,
      shape: isDark ? null: RoundedRectangleBorder(
        side: BorderSide(
          color: Theme.of(context).primaryColor,
          width: 2,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: <Widget>[
            _buildHeader(text),
            Divider(
              color: isDark ? Colors.white60 : Theme.of(context).primaryColor,
              thickness: 2,
            ),
            _setParagraph(content),
          ]
        ),
      ),
    );
  }

  Widget _buildHeader(String text){
    return Align(
        child: Text(
          text,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 22,
            color: isDark ? Colors.white : Theme.of(context).primaryColor,
          ),
        ),
      );
  }

  //returns a Widget which will build the text containing the details of the scholarhship.
  //The text is selectable and it can be copied. The color of the characters will also depend on 
  /// the current [ThemeMode] selected. The text given to the function will be the one displayed.
  Widget _setParagraph(String text){
    return SelectableText.rich(
      TextSpan(
        style: TextStyle(
          fontSize: 15,
          color: isDark ? Colors.white70 : Colors.black87,
        ),
        children: <TextSpan>[
          TextSpan(
            text: text,
          ),
        ],
      ),
      cursorColor: Theme.of(context).primaryColorDark,
      toolbarOptions: ToolbarOptions(copy: true, selectAll: true,),
    );
  }

  ///returns a Widget that when built will be a [FlatButton] with the primary color being dependent on the 
  ///the current [ThemeMode] selected. [onPressed] the scroll position will return to the original position.
  Widget _buildGTTButton(){
    return Center(
      child: FlatButton.icon(
        color: isDark ? Colors.grey.shade800 : Theme.of(context).primaryColor,
        onPressed: (){
          _scroll.animateTo(0, duration: Duration(milliseconds: 100,), curve: Curves.easeOut);
        }, 
        icon: Icon(
          Icons.arrow_drop_up, 
          color: Colors.white,
        ),
        label: Text(
          "Go to Top",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  SizedBox _buildSizedBox(double hght){
    return SizedBox(height: hght);
  }

  @override
  Widget build(BuildContext context) {
    ThemeModel themeModel = Provider.of<ThemeModel>(context, listen: false,);
    isDark = themeModel.selectedTheme == ThemeMode.dark ||
        (themeModel.selectedTheme == ThemeMode.system && SchedulerBinding.instance.window.platformBrightness == Brightness.dark);
    final mq = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: _buildAppBar(),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: ListView(
          controller: _scroll,
          children: <Widget>[
            _buildSizedBox(mq*.025),
            _buildCard("Description", widget.current.scholarshipDescription),
            _buildSizedBox(mq*.025),
            _buildCard("Details", widget.current.scholarshipDetails),
            _buildSizedBox(mq*.025),
            _buildGTTButton(),
            _buildSizedBox(mq*.015),
          ],
        ),
      ),
    );
  }
}
