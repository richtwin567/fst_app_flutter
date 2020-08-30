import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:fst_app_flutter/screens/scholarship_screen/local_widget/scholarcard.dart';
import 'package:fst_app_flutter/models/preferences/theme_model.dart';
import 'package:fst_app_flutter/utils/debouncer.dart';
import 'package:fst_app_flutter/utils/open_url.dart';
import 'package:fst_app_flutter/models/from_postgres/scholarship/scholarship.dart';
import 'package:fst_app_flutter/models/scholarshiplist.dart';
import 'package:fst_app_flutter/services/scholarshipservice.dart';
import 'package:provider/provider.dart';

class ScholarshipMobile extends StatefulWidget {

  ScholarshipMobile({Key key}) : super(key: key);

  @override
  _ScholarshipMobileState createState() => _ScholarshipMobileState();
}

class _ScholarshipMobileState extends State<ScholarshipMobile> {
  
  FocusNode textfocus;
  ScholarshipList symbol;
  int start;
  String currentText;
  bool isDark;

  final _controller = TextEditingController();
  final _scroll = ScrollController();
  final _debouncer = Debouncer(milliseconds: 500);
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  
  void initState() {
    super.initState();

    //Initializing the State Variables
    textfocus = FocusNode();
    currentText = "";

    //Adding a Listener to detect when the Scroll Controller is at the max scroll length 
    //So more data can be retrieved
    _scroll.addListener(() {
      if(_scroll.position.pixels == _scroll.position.maxScrollExtent){
        symbol.getMoreData();
      }
    });
    
  }

  void dispose() {
    textfocus.dispose();
    _controller.dispose();
    _scroll.dispose();
    super.dispose();
  }

  Widget _buildAppBar(){

    return AppBar(
      backgroundColor: isDark ? Colors.grey[900] : Theme.of(context).primaryColor,
      centerTitle: false,
      title: Text(
        "Scholarships",
        style: TextStyle(
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
              openUrl(ScholarshipService.url);
            }catch(e){
            }
          },
        ),
      ],
    );
  }

  Widget _buildTextField(){
    return TextField(
      focusNode: textfocus,
      controller: _controller,
      style: TextStyle(
        color: Colors.grey.shade600,
      ),
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
        hintStyle: TextStyle(color: Colors.grey.shade600,),
        suffixIcon: Icon(
          Icons.search,
          color: Colors.grey.shade600,
        ),
        fillColor: Colors.grey.shade200,
        filled: true,
      ),
      onChanged: (query){
        _debouncer.run((){
          currentText = query;
          symbol.search(query);
        });
      },

      onSubmitted: (query){
        _debouncer.run((){
          currentText = query;
          symbol.search(query);
        });
      },
    );
  }

  Widget _buildTempList(List<Scholarship> lst){
    
    Widget _buildCard(int index){
      return ScholarCard(scholarship: lst[index]);
    }

    Widget _buildNoResults(){
      return Center(
        child: Text(
          "No Search Results", 
          style: TextStyle(
            color: Colors.grey.shade400, 
            fontSize: 18,
            fontFamily: "Monsterrat",
          ),
        ),
      );
    }

    Widget _buildLoading(){
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Visibility(
            visible: symbol.processRequests,
            child: CircularProgressIndicator(backgroundColor: Colors.amber,),
          ),
        ),
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
                color: isDark ? Colors.white : Colors.grey.shade400, 
                fontSize: 18,
                fontFamily: "Monsterrat",
              ),
            ),
            SizedBox(height: 10),
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
                    fontFamily: "Monsterrat",
                  ),
                ),
                color: isDark ? Colors.grey.shade800 : Theme.of(context).primaryColor,
                onPressed: (){
                  _scroll.animateTo(0, duration: Duration(seconds: 2), curve: Curves.easeOut);
                },  
              ),
            ), 
          ],
        ),
      );
    }

    return ListView.builder(
      controller: _scroll,
      itemCount: symbol.isViewList ? lst.length+1 : lst.length,
      itemBuilder: (BuildContext context, int index) {
        if(symbol.isViewList){
          if(index == lst.length){
            return symbol.atEnd ? _buildEnd() : _buildLoading();
          }
        }
        return symbol.doesHaveResults ? _buildCard(index) :_buildNoResults();
      },
    );
  }

  FutureBuilder _buildBuilder(){
    return FutureBuilder(
      future: ScholarshipService.getAllScholarships(),
      builder: (context, snapshot){
        switch(snapshot.connectionState){
          case ConnectionState.waiting:
            return Center(child: CircularProgressIndicator(backgroundColor: Colors.amber,),);
          break;
          case ConnectionState.active:
            return Center(child: CircularProgressIndicator(backgroundColor: Colors.amber,),);
          break;
          case ConnectionState.none:
            return Container(child: Center(child: Text("Nothing happened"),),);
          break;
          case ConnectionState.done:
            if(!snapshot.hasData || snapshot.hasError){
              return Center(
                child: Text(
                  "An Error Occurred",
                  style: TextStyle(
                    color: Colors.grey.shade400,
                    fontSize: 18,
                  ),
                ),
              );
            }else{
              return ChangeNotifierProvider(
                create: (context){
                  symbol = snapshot.data as ScholarshipList;
                  return symbol;
                },
                child: Consumer<ScholarshipList>(
                  builder: (context, lst, child){
                    return Scrollbar(
                      controller: _scroll,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 10.0),
                        child: _buildTempList(lst.scholarList),
                      ),
                    );
                  },
                ),
              );
            }
          break;
          default:
            return Container(color: Colors.blue,);
        }
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    ThemeModel themeModel = Provider.of<ThemeModel>(context, listen: false,);
    isDark = themeModel.selectedTheme == ThemeMode.dark ||
        (themeModel.selectedTheme == ThemeMode.system && SchedulerBinding.instance.window.platformBrightness == Brightness.dark);
    return GestureDetector(
      onTap: (){
        textfocus.unfocus();
        if(currentText == "" && !textfocus.hasFocus){
          symbol.switchList();
        }
      },
      child: Scaffold(
        key: _scaffoldKey,
        appBar: _buildAppBar(),
        body: RefreshIndicator(
          child: Stack(
            children: [
              ListView(
                physics: AlwaysScrollableScrollPhysics(),
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(20,20,20,0),
                child: Column(
                  children: <Widget>[
                    _buildTextField(),
                    SizedBox(
                      height: 10,
                    ),
                    Expanded(
                      child: _buildBuilder(),
                    ),
                  ],
                ),
              ),
            ],
          ),
          onRefresh: refresh,
        ), 
      ),
    );
  }

  Future<void> refresh(){
    return Future(() => setState((){}));
  }
}