import 'package:flutter/material.dart';
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
        backgroundColor: isDark ? Colors.grey.shade800 : Theme.of(context).primaryColor,
        elevation: 0,
      );
  }

  Widget _buildHeader(String text){
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(
        color: isDark ? Colors.grey.shade800 : Theme.of(context).primaryColor,
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      child: Center(
        child: Text(
          text,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 22,
            color: Colors.white,
            fontFamily: "Monsterrat",
          ),
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
          fontFamily: "Monsterrat",
          color: isDark ? Colors.white : Colors.black,
        ),
        children: <TextSpan>[
          TextSpan(
            text: text,
          ),
        ],
      ),
      showCursor: true,
      cursorColor: Theme.of(context).accentColor,
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
            fontFamily: "Monsterrat",
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
    isDark = Provider.of<ThemeModel>(context).selectedTheme == ThemeMode.dark;
    final mq = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: _buildAppBar(),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20,),
        child: ListView(
          controller: _scroll,
          children: <Widget>[
            _buildSizedBox(mq*.035),
            _buildHeader("Description"),
            _buildSizedBox(mq*.035),
            _setParagraph(widget.current.scholarshipDescription),
            _buildSizedBox(mq*.035),
            _buildHeader("Details"),
            _buildSizedBox(mq*.035),
            _setParagraph(widget.current.scholarshipDetails),
            _buildSizedBox(mq*.035),
            _buildGTTButton(),
            _buildSizedBox(mq*.035),
          ],
        ),
      ),
    );
  }
}