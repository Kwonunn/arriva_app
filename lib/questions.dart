import 'package:flutter/material.dart';
import 'package:expandable/expandable.dart';

class QuestionFields extends StatelessWidget {
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.all(3),
      itemCount: questions.length,
      itemBuilder: (BuildContext context, int index) {
        return questionBuilder(index);
      },
      separatorBuilder: (BuildContext context, int index) => const Divider(),
    );
  }
}

ExpandablePanel questionBuilder(int index) {
  return ExpandablePanel(
    header: questions[index].header,
    expanded: questions[index].body,
  );
}

class QuestionBox {
  QuestionBox(String header, String body) {
    // Constructor
    this.header = Text(header);
    this.body = Text(body);
  }
  Text header;
  Text body;
}

final List<QuestionBox> questions = [
  QuestionBox("Title 1", "Body 1"),
  QuestionBox("Header 2", "Body 2"),
  QuestionBox("Header 3", "Body 3"),
  QuestionBox("Foo", "Bar"),
];
