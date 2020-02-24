import 'package:flutter/material.dart';

class QuestionList extends StatefulWidget {
  QuestionList({Key key}) : super(key: key);

  QuestionListState createState() => QuestionListState();
}

class QuestionListState extends State<QuestionList> {
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Container(
            child: ExpansionPanelList(
      expansionCallback: (int index, bool isExpanded) {
        setState(() {
          questions[index].isExpanded = !isExpanded;
        });
      },
      children: questions.map<ExpansionPanel>((QuestionBox item) {
        return ExpansionPanel(
          headerBuilder: (BuildContext context, bool isExpanded) {
            return ListTile(
              title: item.headerValue,
            );
          },
          body: ListTile(
            title: item.expandedValue,
          ),
          isExpanded: item.isExpanded,
        );
      }).toList(),
    )));
  }
}

class QuestionBox {
  QuestionBox(String headerText, String expandedText) {
    this.headerValue = Text(headerText);
    this.expandedValue = Text(expandedText);
    this.isExpanded = false;
  }

  Widget expandedValue;
  Text headerValue;
  bool isExpanded;
}

final List<QuestionBox> questions = [
  QuestionBox("Title 1", "Body 1"),
  QuestionBox("Header 2", "Body 2"),
  QuestionBox("Header 3", "Body 3"),
  QuestionBox("Foo", "Bar"),
];
