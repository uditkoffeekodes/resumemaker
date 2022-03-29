import 'package:flutter/cupertino.dart';
import 'package:gsheets/gsheets.dart';

import 'fields.dart';

class SheetsApi {

  //   --------------------------------------------------
  static const _credentials = "YOUR GOOGLE SHEET JSON";
  //   --------------------------------------------------

  //   --------------------------------------------------
  static final _spreadSheetId = "YOUR SPREAD SHEET ID";
  //   --------------------------------------------------

  static final _gsheets = GSheets(_credentials);
  static Worksheet _worksheet;

  static Future init() async {
    try {
      final spreadSheet = await _gsheets.spreadsheet(_spreadSheetId);
      _worksheet = await _getWorkSheet(spreadSheet, title: "ResumeMaker");

      final firstRow = Fields.getFields();
      _worksheet.values.insertRow(1, firstRow);
    } catch (e) {
      print("Init Error : $e");
    }
  }

  static Future<Worksheet> _getWorkSheet(Spreadsheet spreadsheet, {@required String title}) async {
    try {
      return await spreadsheet.addWorksheet(title);
    } catch (e) {
      return await spreadsheet.worksheetByTitle(title);
    }
  }

  static Future insert(List<Map<String, dynamic>> rowList) async {
    if(_worksheet == null) return;

    _worksheet.values.map.appendRows(rowList);
  }

  static Future<int> getRowCount() async {
    if(_worksheet == null) 0;

    final lastRow = await _worksheet.values.lastRow();
    return lastRow == null ? 0 : int.tryParse(lastRow.first) ?? 0;
  }

  static Future<List<Field>> getAll() async {
    if(_worksheet == null) return <Field>[];

    final fields = await _worksheet.values.map.allRows();
    return fields == null ? <Field>[] : fields.map(Field.fromJson).toList();
  }

}