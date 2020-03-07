import 'package:flutter/material.dart';
import 'package:arriva_app/questions.dart';
import 'package:arriva_app/sendForm.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Arriva App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.indigo[400],
        primarySwatch: Colors.indigo,
      ),
      home: MyHomePage(title: 'Arriva Afname'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  MyHomePageState createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> {
  static final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  static final int questionAmount = 3;

  void sendForm() {
    setState(() {
      if (formKey.currentState.validate()) {
        formKey.currentState.save();
        SpreadsheetMaker.createSpreadsheet();
        SpreadsheetMaker.shareSpreadsheet();
      }
    });
  }

  void _clearFields() {
    formKey.currentState.reset();
  }

  void _foldAllFields() {
    setState(() {
      for (int i = 0; i < categories.length; i++) {
        categories[i].isExpanded = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
              title: Text(widget.title),
              bottom: TabBar(tabs: [
                Tab(icon: Icon(Icons.home)),
                Tab(icon: Icon(Icons.list)),
              ])),
          body: TabBarView(
            children: <Widget>[
              // Home tab
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Image.asset("images/arriva_logo.png"),
                    Container(
                        margin: EdgeInsets.all(20),
                        child: Text(questions[0].answer)),
                  ],
                ),
              ),
              // Invul tab
              QuestionList()
            ],
          ),
          floatingActionButton: FloatingActionButton.extended(
            label: Text('Verzenden'),
            icon: Icon(Icons.mail_outline),
            tooltip: 'Verzenden',
            onPressed: sendForm,
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          bottomNavigationBar: BottomAppBar(
            child: new Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.clear),
                  onPressed: _clearFields,
                ),
                IconButton(
                  icon: Icon(Icons.keyboard_arrow_up),
                  onPressed: _foldAllFields,
                ),
              ],
            ),
          ),
        ));
  }
}

