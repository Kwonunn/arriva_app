import 'package:flutter/material.dart';
// import 'package:arriva_app/main.dart';

class QuestionList extends StatefulWidget {
  QuestionList({Key key}) : super(key: key);
  
  QuestionListState createState() => QuestionListState();
}

class QuestionListState extends State<QuestionList> {
  
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Form(
            child: Container(
                padding: EdgeInsets.all(5),
                child: ExpansionPanelList(
                  expansionCallback: (int index, bool isExpanded) {
                    setState(() {
                      questions[index].isExpanded = !isExpanded;
                    });
                  },
                  children: questions.map<ExpansionPanel>((QuestionBox item) {
                    return ExpansionPanel(
                      canTapOnHeader: true,
                      headerBuilder: (BuildContext context, bool isExpanded) {
                        return ListTile(
                          contentPadding:
                              EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                          title: item.headerValue,
                          subtitle: item.headerSub,
                        );
                      },
                      body: ListTile(
                        title: item.expandedBox,
                      ),
                      isExpanded: item.isExpanded,
                    );
                  }).toList(),
                ))));
  }
}

class QuestionBox {
  QuestionBox(String headerText, String headerSub, String expandedText) {
    // Assemble the variables for a single box of title, text and questions.
    this.headerValue = Text(headerText);
    this.headerSub = Text(headerSub);
    this.expandedBox = Column(
      children: <Widget>[
        Container(
          padding: EdgeInsets.all(5),
          child: Column(
            children: <Widget>[
              Text("Vraag 1"),
              TextFormField()
            ],
          ),
        ),
        Container(
            padding: EdgeInsets.all(5),
            child: Column(
              children: <Widget>[
                Text("Vraag 2"),
                TextFormField(),
              ],
            ))
      ],
    );
    this.isExpanded = false;
  }

  Text headerValue;
  Text headerSub;
  Widget expandedBox;
  bool isExpanded;
}

final List<QuestionBox> questions = [
  QuestionBox("Title 1", "Subtitle 1",
      "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nam porttitor ligula in eleifend mattis. In hac habitasse platea dictumst. Donec ullamcorper purus tempor sem iaculis ullamcorper nec at magna. Curabitur tempor diam blandit massa laoreet auctor. Aenean a sem blandit, mattis ex vel, sagittis eros. Nulla a magna laoreet velit pretium tincidunt. Nullam id varius quam. Pellentesque semper dui lorem, in malesuada diam venenatis molestie."),
];

// QuestionBox("Header 2", "Subtitle 2",
//     "Nulla facilisi. Nam sed erat vel lorem suscipit finibus. Aliquam tincidunt vulputate justo, sed faucibus nisi gravida vel. Donec in ultricies risus. Nam ut nunc mauris. Nullam viverra maximus leo, vitae elementum turpis tristique eu. Nam velit arcu, consequat in risus eu, varius tincidunt enim. Phasellus tempus augue ut sapien tincidunt, ac venenatis leo maximus. Maecenas maximus nec ante et sagittis. Duis ac condimentum magna, nec lobortis ipsum. Sed rutrum aliquam leo vitae luctus. Aliquam eget semper turpis, eget dapibus dolor. Sed pellentesque mi id commodo vehicula. Nulla eu rhoncus sem, at tempus justo. Vestibulum massa odio, fringilla vitae aliquam non, sollicitudin vel turpis."),
// QuestionBox("Header 3", "Subtitle 3",
//     "Fusce interdum est sapien, eget molestie libero convallis non. Etiam imperdiet facilisis condimentum. Aenean pretium augue tortor, eget commodo quam dictum non. Aenean dapibus orci non dui ornare ornare. Praesent pulvinar ut mauris quis gravida. Nullam mattis viverra justo, eget posuere velit imperdiet sed. Donec bibendum id nulla eu rutrum. Duis feugiat, neque ut ultrices pellentesque, lectus dui mollis purus, et aliquet erat velit eget enim. Nulla nunc enim, convallis et dolor non, faucibus maximus erat. Curabitur sed pharetra libero. Proin at metus ligula. Integer eget lorem tortor. Pellentesque sodales felis turpis, vel imperdiet nibh commodo at."),
// QuestionBox("Foo", "Bar makes a return",
//     "Mauris at enim consectetur, ultricies lorem sit amet, porttitor lectus. Nam cursus consectetur egestas. Nunc aliquet urna sit amet lacus porta facilisis vitae ac velit. Phasellus sollicitudin, lacus non posuere imperdiet, elit leo auctor ligula, in aliquet massa nisi dictum lectus. Vivamus auctor dapibus commodo. Curabitur in accumsan orci. Vivamus turpis risus, accumsan vel porta a, fermentum ac quam. Pellentesque posuere nisi vitae libero maximus tempor. Nunc consectetur ipsum tellus, et ultricies sapien dignissim non. Aenean ornare ex sed ornare venenatis. Duis blandit nisl nec arcu blandit efficitur. Praesent sit amet neque vitae sem cursus malesuada. Cras eget pretium ipsum."),
