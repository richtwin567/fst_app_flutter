import 'package:flutter/material.dart';
import 'package:fst_app_flutter/screens/scholarship_screen/local_widget/scholar_card.dart';
import 'package:fst_app_flutter/models/preferences/theme_model.dart';
import 'package:fst_app_flutter/utils/debouncer.dart';
import 'package:fst_app_flutter/utils/open_url.dart';
import 'package:fst_app_flutter/models/from_postgres/scholarship/scholarship.dart';
import 'package:fst_app_flutter/models/scholarship_list.dart';
import 'package:fst_app_flutter/services/scholarship_service.dart';
import 'package:provider/provider.dart';

class ScholarshipMobile extends StatefulWidget {
  ScholarshipMobile({Key key}) : super(key: key);

  @override
  _ScholarshipMobileState createState() => _ScholarshipMobileState();
}

class _ScholarshipMobileState extends State<ScholarshipMobile> {
  FocusNode textfocus;
  ScholarshipList symbol;
  String currentText;
  bool isDark;
  bool isSearching; // signifies if the screen is in searching mode and controls which appbar is shown.

  final _controller = TextEditingController();
  final _scroll = ScrollController();
  final _debouncer = Debouncer(milliseconds: 500);

  void initState() {
    super.initState();

    //Initializing the State Variables
    textfocus = FocusNode();
    currentText = "";
    isSearching = false;
  }

  void dispose() {
    textfocus.dispose();
    _controller.dispose();
    _scroll.dispose();
    super.dispose();
  }

  Widget _buildAppBar() {
    Widget buildSearchBar() {
      return AppBar(
        centerTitle: false,
          leading: IconButton(
            icon: Icon(Icons.clear),
            onPressed: () {
              setState(() {
                _controller.clear();
                isSearching = false;
              });
            },
            tooltip: "Stop Searching",
          ),
          title: Theme(
            data: Theme.of(context).copyWith(
              primaryColor: Colors.white,
            ),
            child: _buildTextField(),
          ),
          actions: [
            IconButton(
              padding: const EdgeInsets.all(5.0),
              icon: Icon(Icons.cancel),
              color: Colors.white,
              onPressed: () {
                _controller.clear();
                _debouncer.run(() {
                  currentText = _controller.text;
                  symbol.search(_controller.text);
                });
              },
              tooltip: "Clear Text",
            ),
          ]);
    }

    Widget buildRegularAppBar() {
      return AppBar(
        centerTitle: false,
        title: Text(
          "Scholarships",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        actions: <Widget>[
          IconButton(
            padding: const EdgeInsets.all(5.0),
            icon: Icon(Icons.search),
            color: Colors.white,
            onPressed: () {
              setState(() {
                isSearching = true;
              });
            },
          ),
          IconButton(
            icon: Icon(
              Icons.public,
              color: Colors.white,
            ),
            onPressed: () {
              try {
                openUrl(ScholarshipService.url);
              } catch (e) {}
            },
          ),
        ],
      );
    }

    return isSearching ? buildSearchBar() : buildRegularAppBar();
  }

  Widget _buildTextField() {
    return TextField(
      autofocus: true,
      focusNode: textfocus,
      controller: _controller,
      style: TextStyle(
        color: Colors.white70,
      ),
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderSide: const BorderSide(
            width: 0,
            style: BorderStyle.none,
          ),
        ),
        hintText: "Search",
        hintStyle: TextStyle(
          color: Colors.white24,
        ),
        prefixIcon: Icon(
          Icons.search,
        ),
      ),
      onChanged: (query) {
        _debouncer.run(() {
          currentText = query;
          symbol.search(query);
        });
      },
      onSubmitted: (query) {
        _debouncer.run(() {
          currentText = query;
          symbol.search(query);
        });
      },
    );
  }

  Widget _buildTempList(List<Scholarship> lst) {
    Widget _buildCard(int index) {
      return ScholarCard(scholarship: lst[index]);
    }

    Widget _buildNoResults() {
      return Center(
        child: Text(
          "No Search Results",
          style: TextStyle(
            color: Colors.grey.shade400,
            fontSize: 18,
          ),
        ),
      );
    }

    Widget _buildEnd() {
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
                  ),
                ),
                color: isDark
                    ? Colors.grey.shade800
                    : Theme.of(context).primaryColor,
                onPressed: () {
                  _scroll.animateTo(0,
                      duration: Duration(seconds: 2), curve: Curves.easeOut);
                },
              ),
            ),
          ],
        ),
      );
    }

    return symbol.doesHaveResults
        ? ListView.builder(
            physics: AlwaysScrollableScrollPhysics(),
            controller: _scroll,
            itemCount: symbol.isSearching ? lst.length : lst.length + 1,
            itemBuilder: (BuildContext context, int index) {
              if (index == lst.length) {
                return _buildEnd();
              }
              return _buildCard(index);
            },
          )
        : _buildNoResults();
  }

  FutureBuilder _buildBuilder() {
    Widget buildProgress() {
      return Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Colors.amber),
        ),
      );
    }

    return FutureBuilder(
        future: ScholarshipService.getAllScholarships(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return buildProgress();
              break;
            case ConnectionState.active:
              return buildProgress();
              break;
            case ConnectionState.none:
              return Container(
                child: Center(
                  child: Text("Nothing happened"),
                ),
              );
              break;
            case ConnectionState.done:
              if (!snapshot.hasData || snapshot.hasError) {
                return Center(
                  child: Text(
                    "An Error Occurred",
                    style: TextStyle(
                      color: Colors.grey.shade400,
                      fontSize: 18,
                    ),
                  ),
                );
              } else {
                return ChangeNotifierProvider(
                  create: (context) {
                    symbol = snapshot.data as ScholarshipList;
                    return symbol;
                  },
                  child: Consumer<ScholarshipList>(
                    builder: (context, lst, child) {
                      return Padding(
                        padding: const EdgeInsets.only(
                          left: 10,
                        ),
                        child: Scrollbar(
                          controller: _scroll,
                          child: Padding(
                            padding: const EdgeInsets.only(right: 10.0),
                            child: _buildTempList(lst.scholarList),
                          ),
                        ),
                      );
                    },
                  ),
                );
              }
              break;
            default:
              return Container(
                color: Colors.blue,
              );
          }
        });
  }

  @override
  Widget build(BuildContext context) {
    isDark = Provider.of<ThemeModel>(context,listen: false,).isDark;
    return GestureDetector(
      onTap: () {
        textfocus.unfocus();
      },
      child: Scaffold(
        appBar: _buildAppBar(),
        body: RefreshIndicator(
          onRefresh: refresh,
          child: Stack(
            children: [
              ListView(
                physics: AlwaysScrollableScrollPhysics(),
              ),
              _buildBuilder(),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> refresh() {
    return Future(() => setState(() {}));
  }
}
