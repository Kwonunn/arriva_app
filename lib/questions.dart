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
      list.add(Text(questions[i].question,
          textAlign: TextAlign.left,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)));
      if (questions[i].isValue) {
        list.add(Row(
          children: <Widget>[
            Expanded(
              child: TextFormField(
                controller: questions[i].textController,
                decoration: InputDecoration(border: OutlineInputBorder()),
                onSaved: (String value) {
                  questions.update(questions[i].id, (e) {
                    e.answer = value;
                    return e;
                  });
                },
              ),
            )
          ],
        ));
      } else {
        list.add(Row(
          children: <Widget>[
            Expanded(
              child: TextFormField(
                controller: questions[i].textController,
                decoration: InputDecoration(border: OutlineInputBorder()),
                onSaved: (String value) {
                  questions.update(questions[i].id, (e) {
                    e.answer = value;
                    return e;
                  });
                },
              ),
            ),
            IconButton(
              icon: Icon(Icons.check_box),
              onPressed: () {
                questions[i].textController.value = new TextEditingValue(text: "Goed");
              },
            ),
          ],
        ));
      }
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
  Question(int id, String question, [bool isValue = false]) {
    this.id = id;
    this.question = question;
    this.isValue = isValue;
  }

  int id;
  String question = "";
  bool isValue = true;
  String answer = "";
  TextEditingController textController = new TextEditingController();
}

class Category {
  Category(int id, List<int> questions, String name, [String subtitle]) {
    this.id = id;
    this.questions = questions;
    this.name = name;
    if (subtitle != null) {
      this.subtitle = subtitle;
    }
  }

  int id;
  List<int> questions;
  String name = "";
  String subtitle = "";
  bool isExpanded = false;
}

final List<Category> categories = [
  Category(
      0,
      List.generate(6, (i) {
        return i + 0;
      }),
      "Algemeen"),
  // Category(
  //     0,
  //     List.generate(3, (i) {
  //       return i + 6;
  //     }),
  //     "Visueel"),
  // Category(
  //     0,
  //     List.generate(6, (i) {
  //       return i + 9;
  //     }),
  //     "Kwaliteit"),
  // Category(
  //     0,
  //     List.generate(13, (i) {
  //       return i + 15;
  //     }),
  //     "Signalen"),
  // Category(
  //     0,
  //     List.generate(16, (i) {
  //       return i + 28;
  //     }),
  //     "Communicatie"),
  // Category(
  //     0,
  //     List.generate(8, (i) {
  //       return i + 44;
  //     }),
  //     "Kassasystemen"),
  // Category(
  //     0,
  //     List.generate(3, (i) {
  //       return i + 52;
  //     }),
  //     "Visueel"),
  // Category(
  //     0,
  //     List.generate(23, (i) {
  //       return i + 55;
  //     }),
  //     "Apparaten"),
  // Category(
  //     0,
  //     List.generate(4, (i) {
  //       return i + 78;
  //     }),
  //     "Info"),
  // Category(
  //     0,
  //     List.generate(1, (i) {
  //       return i + 82;
  //     }),
  //     "Pilotfish"),
  // Category(
  //     0,
  //     List.generate(1, (i) {
  //       return i + 83;
  //     }),
  //     "Op te pakken"),
];

HashMap<int, Question> fillHashMap(HashMap<int, Question> emptyMap) {
  List<Question> toFill = [
    Question(0, "Ingebouwd door:"),
    Question(1, "Afname door:"),
    Question(2, "Datum afname:"),
    Question(3, "Albatros Revisie:"),
    Question(4, "Busnummer:"),
    Question(5, "Kenteken:"),
    Question(6, "Geplaatste apparatuur recht en netjes gemonteerd"),
    Question(7, "Afwerking van gaten/doorvoer en geplaatste beugels/sokkels"),
    Question(8, "Kabels netjes gebundeld"),
    Question(9, "Juiste tangen gebruikt (BNC/AMP/Diafragma etc)"),
    Question(10, "Correct gebruik gemaakt van kleinmateriaal"),
    Question(11, "Montage d.m.v. bouten i.p.v. parkers waar mogelijk"),
    Question(12, "Geen zichtbaar koper buiten de hulzen/fastons/pennetjes"),
    Question(13, "Albatrosbehuizing goed sluitend (Indien verwerkt)"),
    Question(14,
        "Bekabeling niet onder te krappe hoek (bv BC810 RJ45 & Harnaskabel)"),
    Question(15, "X1-stekker nameten: B+"),
    Question(16, "X1-stekker nameten: D30"),
    Question(17, "X1-stekker nameten: D15"),
    Question(18, "X1-stekker nameten: D+"),
    Question(19, "X1-stekker nameten: 12V"),
    Question(20, "X1-stekker nameten: Reset test"),
    Question(21, "Back-up accu's test"),
    Question(22, "Andere signalen: Deursignaal"),
    Question(23, "Andere signalen: Tachograafsignaal (4 pulsen p/m)"),
    Question(24, "Gegevens touchscreen aanwezig: GPRS"),
    Question(25, "Gegevens touchscreen aanwezig: GPS"),
    Question(26, "Gegevens touchscreen aanwezig: GSM"),
    Question(27, "Test naloop: Lijnfilm op naloop"),
    Question(28, "GSM: Bus koppelen ASL"),
    Question(29, "GSM: Test noodoproep"),
    Question(30, "TransVu: Nood/Attentiesignalen"),
    Question(31, "TransVu: Geluidsopname"),
    Question(32, "Software TransVu: Busnummer"),
    Question(33, "Software TransVu: Opname-instellingen"),
    Question(34, "Software TransVu: Camera-instellingen"),
    Question(35, "Camera's: Werking"),
    Question(36, "Camera's: Afstelling"),
    Question(37, "Camera's: Volgorde"),
    Question(38, "Motorola: Zenden/Ontvangen"),
    Question(39, "Motorola: Sprietantenne afstellen (128mm)"),
    Question(40, "Omroep: Tekst + Afstelling"),
    Question(41, "GPS Signaal: Aardvark.cmd geplaatst"),
    Question(42, "GPS Signaal: GPS Reset uitgevoerd"),
    Question(43, "Sync groen bij download"),
    Question(44, "DC800: Voeding"),
    Question(45, "DC800: Werking + Pin/QR"),
    Question(46, "DC Lite: Voeding"),
    Question(47, "DC Lite: Werking + Pin/QR/Printer"),
    Question(48, "VX820: Trekontlasting correct"),
    Question(49, "VX820: Hoek van de kabel"),
    Question(50, "VX680: Werking Brodit houder"),
    Question(51, "VX680: Werking pin"),
    Question(52, "Stickers: Camerabewaking"),
    Question(53, "Stickers: Huisregels"),
    Question(54, "Bus schoon"),
    Question(55, "Validators: Alles groen"),
    Question(56, "Validators: Programmering"),
    Question(57, "Validators: Checkin"),
    Question(58, "AHM: Werking"),
    Question(59, "AHM: Rood kruis bij uitschakelen D30"),
    Question(60, "Hotspot: Busnummer"),
    Question(61, "Hotspot: Landingpage"),
    Question(62, "Hotspot: Werkend"),
    Question(63, "Boordcomputer bijgelopen: Busnummer in BC "),
    Question(64, "Boordcomputer bijgelopen: Versie"),
    Question(65, "KAR: Ack bij test"),
    Question(66, "VETAG: Code in scherm"),
    Question(67, "VETAG: Code op tester"),
    Question(68, "PPF+: Geprogrammerd"),
    Question(69, "PPF+: KM-stand bus"),
    Question(70, "Infotainment: Plaatjes van provincie"),
    Question(71, "Infotainment: Slave werkend"),
    Question(72, "Halteomroep: TTS"),
    Question(73, "Afstelling geluidsniveau DB's (Limburg)"),
    Question(74, "Ecobox: Juist geprogrammeerd"),
    Question(75, "Lijnfilm: Adressen"),
    Question(76, "Lijnfilm: Juiste software"),
    Question(77, "Lijnfilm: Werking Auto/Man"),
    Question(78, "TMS Pin"),
    Question(79, "TFT"),
    Question(80, "Tanktag"),
    Question(81, "Sim Hotspot"),
    Question(82, "Pilotfish checker uitgevoerd/succesvol"),
    Question(83,
        "Hieronder aan te geven de punten die de busbouwer voor oplevering van de bus dient op te pakken en hier wederzijds akkoord te tekenen"),
  ];

  MyHomePageState.questionAmount = toFill.length;

  for (Question entry in toFill) {
    emptyMap.update(entry.id, (e) => entry, ifAbsent: () => entry);
  }

  return emptyMap;
}

HashMap<int, Question> questions = fillHashMap(HashMap<int, Question>());
