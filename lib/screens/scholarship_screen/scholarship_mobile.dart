import 'package:flutter/material.dart';
import 'package:scholarship/screens/scholarship_screen/local_widgets/scholarcard.dart';
import 'package:scholarship/models/scholarship.dart';
import 'package:scholarship/services/scholarshipservice.dart';
import 'package:scholarship/utils/debouncer.dart';

class ScholarshipMobile extends StatefulWidget {
  final String orientation;

  ScholarshipMobile({Key key, this.orientation}) : super(key: key);

  @override
  _ScholarshipMobileState createState() => _ScholarshipMobileState(orientation: orientation);
}

class _ScholarshipMobileState extends State<ScholarshipMobile> {
  
  String orientation;
  
  @override
  _ScholarshipMobileState({this.orientation});

  List<Scholarship> viewList = List();
  List<Scholarship> original = List();
  List<Scholarship> current;
  FocusNode textfocus;

  int start;
  bool isPerformingRequest;
  bool isAtEnd;
  bool hasResults;
  bool hasData;
  String currentText;
  Widget currentWidget;

  final _controller = TextEditingController();
  final _scroll = ScrollController();
  final size = 6;
  final _debouncer = Debouncer(milliseconds: 500);
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  void initState() {
    super.initState();

    //Initializing the State Variables
    start = 0;
    textfocus = FocusNode();
    isPerformingRequest = false;
    isAtEnd  = false;
    hasResults = true;
    hasData = false;
    currentText = "";
    currentWidget = Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: CircularProgressIndicator(backgroundColor: Colors.amber,),
      ),
    );

    ScholarshipService.getAllScholarships().then(
      (lst){

        original = lst;

        if(original.length <= size){
          viewList = original.getRange(start, original.length).toList();
          start += (original.length - start);
        }else{
          viewList = original.getRange(start, start+size).toList();
          start += size;
        }
        setState((){ 
          hasData = true;
          current = viewList;
        });
      },
      onError: (error){
        setState(() => currentWidget = Center(
          child: Text(
            "No Scholarships to Show",
            style: TextStyle(
              color: Colors.grey.shade400,
              fontSize: 18,
            ),
          ),
        ));
      },
      );

    //Adding a Listener to detect when the Scroll Controller is at the max scroll length 
    //So more data can be retrieved
    _scroll.addListener(() {
      if(_scroll.position.pixels == _scroll.position.maxScrollExtent){
        _getMoreData();
      }
    });
    
  }

  void _getMoreData() async{
    if (!isPerformingRequest) {
      setState(() => isPerformingRequest = true);
      List<Scholarship> newEntries;
      if((original.length - start) == 0){
        newEntries = [];
      }else if((original.length - start) < size){
        newEntries = original.getRange(start, original.length).toList();
        start += (original.length - start);
      }else {
        newEntries = original.getRange(start, start+size).toList();
        start += size;
      }
      if (newEntries.isEmpty){
        isAtEnd = true;
      }
      await Debouncer.wait();
      setState(() {
        viewList.addAll(newEntries);
        isPerformingRequest = false;
      });
    }
  }

  void dispose() {
    textfocus.dispose();
    _controller.dispose();
    _scroll.dispose();
    super.dispose();
  }

  Widget _buildLoading(){
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: Visibility(
          visible: isPerformingRequest ? true : false,
          child: CircularProgressIndicator(backgroundColor: Colors.amber,),
        ),
      ),
    );
  }

  Widget _buildAppBar(){
    return AppBar(
      automaticallyImplyLeading: true,
      backgroundColor: Colors.blue.shade900,
      title: Text(
        "Scholarships",
        style: TextStyle(
          //fontFamily: "Monsterrat",
          color: Colors.white,
        ),
      ),
      actions: <Widget>[
        IconButton(
          icon: Icon(
            Icons.public,
            color: Colors.white,
          ),
          onPressed: (){
            try{
              ScholarshipService.launchURL();
            }catch(e){
              Scaffold.of(context).showSnackBar(SnackBar(content: Text(e), duration: Duration(seconds: 2,),));
            }
          },
        ),
        IconButton(
          icon: Icon(
            Icons.file_download,
            color: Colors.white,
          ),
          onPressed: (){},
        ),
      ],
    );
  }

  Widget _buildEnd(){
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[ 
          Text(
            "End of the List", 
            style: TextStyle(
              color: Colors.grey.shade400, 
              fontSize: 18
            ),
          ),
          SizedBox(height: 20),
          Center(
            child: FlatButton.icon(
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
              color: Colors.blue.shade900,
              onPressed: (){
                _scroll.animateTo(0, duration: Duration(seconds: 2), curve: Curves.easeOut);
              },  
            ),
          ), 
        ],
      ),
    );
  }

  Widget _buildTextField(){
    return TextField(
      focusNode: textfocus,
      controller: _controller,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderSide: const BorderSide(
            width: 0,
            style: BorderStyle.none,
          ),
          borderRadius: BorderRadius.all(const Radius.circular(70)),
        ),
        contentPadding: EdgeInsets.symmetric(
          vertical: 2,
          horizontal: 15,
        ),
        hintText: "Search",
        suffixIcon: Icon(
          Icons.search,
        ),
        fillColor: Colors.grey.shade200,
        filled: true,
      ),
      onChanged: (query){
        _debouncer.run((){
          setState((){ 
            currentText = query;
            current = original.where((p) => p.scholarshipName.toLowerCase().contains(query.toLowerCase())).toList();
            if(current.isEmpty){
              hasResults = false;
              current = [Scholarship(name:"No Search Results")];
            }else{
              hasResults = true;
            }
          });
        });
      },

      onSubmitted: (query){
        _debouncer.run((){
          setState((){ 
            currentText = query;
            current = original.where((p) => p.scholarshipName.toLowerCase().contains(query.toLowerCase())).toList();
            if(current.isEmpty){
              hasResults = false;
              current = [Scholarship(name:"No Search Results")];
            }else{
              hasResults = true;
            }
          });
        });
      },
    );
  }

  Widget _buildNoResults(int index){
    return Center(
      child: Text(
        current[index].scholarshipName, 
        style: TextStyle(
          color: Colors.grey.shade400, 
          fontSize: 18,
        ),
      ),
    );
  }

  Widget _buildCard(int index){
    return ScholarCard(scholarship: current[index]);
  }

  Widget _buildTempList(){
    if(!textfocus.hasFocus && currentText == ""){
      setState((){
        current = viewList;
      });
    }
    return ListView.builder(
      controller: _scroll,
      itemCount: (current == viewList) ? current.length + 1 : current.length,
      itemBuilder: (BuildContext context, int index) {
        if(current == viewList){
          if(index == current.length){
            return isAtEnd ? _buildEnd() : _buildLoading();
          }
        }
        return !hasResults ? _buildNoResults(index) : _buildCard(index);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ()  => textfocus.unfocus(),
      child: Scaffold(
        key: _scaffoldKey,
        appBar: _buildAppBar(),
        body: Container(
          padding: orientation == "Potrait" ? const EdgeInsets.fromLTRB(20,20,20,0) : const EdgeInsets.fromLTRB(20,10,20,0),
          child: Column(
            children: <Widget>[
              _buildTextField(),
              SizedBox(
                height: 10,
              ),
              Container(
                child: Expanded(
                  child: hasData ? _buildTempList() : currentWidget,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}