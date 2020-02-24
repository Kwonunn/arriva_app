import 'package:flutter/material.dart';
import 'package:arriva_app/questions.dart';

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
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  void _clearFields() {
    // Do nothing for now
    setState(() {
      _counter = 0;
    });
  }

  void _foldAllFields() {
    setState(() {
      for (int i = 0; i < questions.length; i++) {
        questions[i].isExpanded = false;
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
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'Functietest knop.',
                    ),
                    Text(
                      '$_counter',
                      style: Theme.of(context).textTheme.display1,
                    ),
                  ],
                ),
              ),
              // Invul tab
              QuestionList(),
            ],
          ),
          floatingActionButton: FloatingActionButton.extended(
            label: Text('Verzenden'),
            icon: Icon(Icons.mail_outline),
            tooltip: 'Verzenden',
            onPressed: _incrementCounter,
            elevation: 4.0,
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
