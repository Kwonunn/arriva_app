import 'dart:io';
import 'dart:async';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:arriva_app/questions.dart';
import 'package:arriva_app/main.dart';
import 'package:spreadsheet_decoder/spreadsheet_decoder.dart';
import 'package:esys_flutter_share/esys_flutter_share.dart';

class SpreadsheetMaker {
  static Future<String> get _tempPath async {
    // Function to get local temp directory
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  static Future<File> get _emptyLocalSheet async {
    // Function to make file future
    final path = await _tempPath;
    Future<ByteData> data = rootBundle.load('res/emptySheet.xlsx');
    ByteData dataRead = await data;
    final buffer = dataRead.buffer;
    return new File('$path/outputSheet.xlsx').writeAsBytes(
        buffer.asUint8List(dataRead.offsetInBytes, dataRead.lengthInBytes));
  }

  static void sendSpreadsheet() async {
    // Set up a spreadsheed decoder to add stuff to a spreadsheet.
    String sheet = "Sheet1";
    File _sheetFile = await _emptyLocalSheet; // Await file so I don't have to mess with asynchonous programming.
    var bytes = _sheetFile.readAsBytesSync();
    SpreadsheetDecoder decoder =
        SpreadsheetDecoder.decodeBytes(bytes, update: true);

    decoder.insertColumn(sheet, 0);
    decoder.insertColumn(sheet, 1);

    for (int i = 0; i < MyHomePageState.questionAmount; i++) {
      decoder.insertRow(sheet, i);
      decoder.updateCell(sheet, 0, i, questions[i].question);
      decoder.updateCell(sheet, 1, i, questions[i].answer);
    }

    await Share.file('Export afname', 'afname.xlsx', decoder.encode(), 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet',); // Open share dialog to share encoded sheet.
  }
}
