import 'package:flutter/material.dart';
import 'package:arriva_app/main.dart';
import 'dart:collection';

class QuestionList extends StatefulWidget {
  QuestionList({Key key}) : super(key: key);

  QuestionListState createState() => QuestionListState();
}

Widget _getQuestionsForCategory(Category category) {
  if (category.questions.length == 0) {
    return new Container();
  } else {
    List<Widget> list = new List<Widget>();
    for (int i in category.questions) {
      list.add(Text(questions[i].question, textAlign: TextAlign.left, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)));
      list.add(TextFormField(
        decoration: InputDecoration(border: OutlineInputBorder()),
        onSaved: (String value) {
          questions.update(questions[i].id, (e) {
            e.answer = value;
            return e;
          });
        },
      ));
      list.add(Divider(
        color: Color(0xFF000000),
        thickness: 2,
      ));
    }
    return new Container(
      child: Column(
        
        children: list,
      ),
      padding: EdgeInsets.all(8),
      color: Color(0xFFE0E0FF),
    );
  }
}

class QuestionListState extends State<QuestionList> {
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Form(
            key: MyHomePageState.formKey,
            child: Container(
                padding: EdgeInsets.all(5),
                child: ExpansionPanelList(
                  expansionCallback: (int index, bool isExpanded) {
                    setState(() {
                      categories[index].isExpanded = !isExpanded;
                    });
                  },
                  children: categories.map<ExpansionPanel>((Category category) {
                    return ExpansionPanel(
                      canTapOnHeader: true,
                      headerBuilder: (BuildContext context, bool isExpanded) {
                        return ListTile(
                          contentPadding:
                              EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                          title: Text(category.name),
                          subtitle: Text(category.subtitle),
                        );
                      },
                      body: _getQuestionsForCategory(category),
                      isExpanded: category.isExpanded,
                    );
                  }).toList(),
                ))));
  }
}

class Question {
  Question(int id, String question, [bool isValue = true]) {
    this.id = id;
    this.question = question;
    this.isValue = isValue;
  }

  void setAnswer(String newAnswer) {
    this.answer = newAnswer;
  }

  int id;
  String question = "";
  bool isValue = true;
  String answer = "";
}

class Category {
  Category(int id, List<int> questions, String name, String subtitle) {
    this.id = id;
    this.questions = questions;
    this.name = name;
    this.subtitle = subtitle;
  }

  int id;
  List<int> questions;
  String name = "";
  String subtitle = "";
  bool isExpanded = false;
}

final List<Category> categories = [
  Category(0, [0, 1, 2], "Algemeen", "Algemene vragen over de bus"),
  Category(1, [], "Niet algemeen", "iets anders dus"),
];

HashMap<int, Question> fillHashMap(HashMap<int, Question> emptyMap) {
  List<Question> toFill = [
    Question(0, "Is de bus groen?"),
    Question(1, "Oh ja, open vragen. Welke kleur is de bus?"),
    Question(2, "Welke vorm zijn de wielen?")
  ];

  for (Question entry in toFill) {
    emptyMap.update(entry.id, (e) => entry, ifAbsent: () => entry);
  }

  return emptyMap;
}

HashMap<int, Question> questions = fillHashMap(HashMap<int, Question>());
