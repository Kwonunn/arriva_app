import 'dart:io';
import 'dart:async';
import 'package:path_provider/path_provider.dart';
import 'package:arriva_app/questions.dart';
import 'package:arriva_app/main.dart';
import 'package:spreadsheet_decoder/spreadsheet_decoder.dart';
import 'package:flutter_share/flutter_share.dart';

class SpreadsheetMaker {
  static Future<String> get _tempPath async {
    // Function to get local temp directory
    final directory = await getTemporaryDirectory();
    return directory.path;
  }

  static Future<File> get _localFile async {
    // Function to make file future
    final path = await _tempPath;
    return File('$path/outputSheet.xlsx');
  }

  static void createSpreadsheet() async {
    // Set up a spreadsheed decoder to add stuff to a spreadsheet.
    String sheet = "Sheet1";
    File _sheetFile = await _localFile; // Await file so I don't have to mess with asynchonous programming.
    var bytes = _sheetFile.readAsBytesSync();
    SpreadsheetDecoder decoder = SpreadsheetDecoder.decodeBytes(bytes);
    
    // Clear sheet
    decoder.removeColumn(sheet, 0);
    decoder.removeColumn(sheet, 1);
    decoder.removeColumn(sheet, 2);

    for (int i = 0; i < MyHomePageState.questionAmount; i++) {
      decoder.updateCell(sheet, 0, i, questions[i].question);
      decoder.updateCell(sheet, 1, i, questions[i].answer);
    }
  }

  static void shareSpreadsheet() async {
    final path = await _tempPath;
    FlutterShare.shareFile(title: "Exporteer afnamelijst", filePath: '$path/outputSheet.xlsx', text: "");
  }
}
