import 'package:flutter/material.dart';
import 'package:expandable/expandable.dart';

class QuestionFields extends StatelessWidget {
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        ExpandablePanel(
          header: Container(
            child: Text("Header 1"),
            alignment: Alignment.bottomCenter,
          ),
          expanded: Text("Expanded text"),
        ),
      ],
    );
  }
}
