import 'package:flutter/material.dart';
import 'package:resumemaker/Ui/addresumepage.dart';
import 'package:resumemaker/Ui/resumedetailpage.dart';
import 'package:resumemaker/Values/components.dart';

import '../GoogleSheet/fields.dart';
import '../GoogleSheet/sheets_api.dart';

class ResumeList extends StatefulWidget {
  @override
  State<ResumeList> createState() => _ResumeListState();
}

class _ResumeListState extends State<ResumeList> {
  List<Field> fields = [];
  bool isLoading = false;

  Future getFields() async {

    setState(() {
      isLoading = true;
    });

    final fields = await SheetsApi.getAll();

    setState(() {
      this.fields = fields;
      isLoading = false;
    });

  }

  @override
  void initState() {
    super.initState();
    getFields();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            "Resume List",
            style: textStyleBold.copyWith(
              fontSize: 20,
              color: Colors.white
            ),
          ),
          actions: [
            InkWell(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => AddResumePage()));
              },
              child: Icon(Icons.add_circle)
            ),
            SizedBox(width: 10)
          ],
        ),
        body:
        isLoading == true
            ?
        Center(child: CircularProgressIndicator())
            :
        NotificationListener<OverscrollIndicatorNotification>(
          onNotification: (OverscrollIndicatorNotification overscroll) {
            overscroll.disallowGlow();
          },
          child: Padding(
            padding: EdgeInsets.all(20),
            child: ListView.builder(
                shrinkWrap: true,
                itemCount: fields.length,
                itemBuilder: (BuildContext context,int index){
                  return Padding(
                    padding: EdgeInsets.only(bottom: 10),
                    child: InkWell(
                      onTap: () {
                        print(fields[index].id);
                        print(fields[index].dob);
                        Navigator.push(context, MaterialPageRoute(builder: (context) {
                          return ResumeDetailPage(
                            id: fields[index].id,
                            name: fields[index].name,
                            email: fields[index].email,
                            number: fields[index].number,
                            dob: fields[index].dob,
                            address: fields[index].address,
                            exptitle: fields[index].exptitle,
                            expdesc: fields[index].expdesc,
                            startDate: fields[index].startDate,
                            endDate: fields[index].endDate,
                            degree: fields[index].degree,
                            grade: fields[index].grade,
                            year: fields[index].year
                          );
                        }));
                      },
                      child: Card(
                          elevation: 5,
                          child: Padding(
                            padding: EdgeInsets.all(10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Id: ${fields[index].id}",
                                  style: textStyle
                                ),
                                SizedBox(height: 10),
                                Text(
                                  "Name: ${fields[index].name}",
                                  style: textStyle
                                ),
                                SizedBox(height: 10),
                                Text(
                                  "Email: ${fields[index].email}",
                                  style: textStyle
                                ),
                                SizedBox(height: 10),
                                Text(
                                  "Number: ${fields[index].number}",
                                  style: textStyle
                                )
                              ],
                            ),
                          )
                      ),
                    ),
                  );
                }
            ),
          ),
        ),
      ),
    );
  }
}
