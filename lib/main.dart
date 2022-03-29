import 'package:flutter/material.dart';
import 'package:resumemaker/Ui/addresumepage.dart';
import 'package:resumemaker/Ui/resumelist.dart';

import 'GoogleSheet/sheets_api.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SheetsApi.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      home: ResumeList()
    );
  }
}