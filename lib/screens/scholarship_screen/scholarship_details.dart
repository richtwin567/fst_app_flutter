import 'package:flutter/material.dart';
import 'package:fst_app_flutter/models/scholarship.dart';

class ScholarshipDetails extends StatefulWidget {
  final Scholarship current;

  ScholarshipDetails({this.current});

  @override
  _ScholarshipDetailsState createState() => _ScholarshipDetailsState();
}

class _ScholarshipDetailsState extends State<ScholarshipDetails> {
  final  _scroll = ScrollController();

  void dispose(){
    _scroll.dispose();
    super.dispose();
  }

  Widget _buildAppBar(){
    return AppBar(
        title: Text(widget.current.scholarshipName),
        backgroundColor: Theme.of(context).primaryColor,
        elevation: 0,
      );
  }

  Widget _buildHeader(String text){
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(
        color: Theme.of(context).accentColor,
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      child: Center(
        child: Text(
          text,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 22,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget _setParagraph(String text){
    return SelectableText.rich(
      TextSpan(
        style: TextStyle(
          color: Colors.black,
          fontSize: 15,
        ),
        children: <TextSpan>[
          TextSpan(
            text: text,
          ),
        ],
      ),
      showCursor: true,
      cursorColor: Colors.blue.shade900,
      toolbarOptions: ToolbarOptions(copy: true, selectAll: true,),
    );
  }

  Widget _buildGTTButton(){
    return Center(
      child: FlatButton.icon(
        color: Theme.of(context).primaryColor,
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: Container(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
        child: ListView(
          controller: _scroll,
          children: <Widget>[
            SizedBox(height: 20),
            _buildHeader("Description"),
            SizedBox(height: 20),
            _setParagraph(widget.current.scholarshipDescription),
            SizedBox(height: 20),
            _buildHeader("Details"),
            SizedBox(height: 20),
            _setParagraph(widget.current.scholarshipDetails),
            SizedBox(height: 20),
            _buildGTTButton(),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}