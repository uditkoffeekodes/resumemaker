import 'package:basic_utils/basic_utils.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:resumemaker/Values/components.dart';

import '../GoogleSheet/fields.dart';
import '../GoogleSheet/sheets_api.dart';

class AddResumePage extends StatefulWidget {
  @override
  State<AddResumePage> createState() => _AddResumePageState();
}

class _AddResumePageState extends State<AddResumePage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController numController = TextEditingController();
  TextEditingController addressController = new TextEditingController();
  TextEditingController expTitleController = new TextEditingController();
  TextEditingController expDescController = new TextEditingController();
  TextEditingController educationController = new TextEditingController();
  TextEditingController dobController = new TextEditingController();
  TextEditingController startDateController = new TextEditingController();
  TextEditingController endDateController = new TextEditingController();

  bool isLoading = false;

  DateTime _selectedDate = DateTime.now();

  Color yearColor = Colors.grey;
  Color gradeColor = Colors.grey;

  String _selectedYear;
  String _selectedGrade;

  List<String> _years = [
    '1990', '1991', '1992', '1993', '1994',
    '1995', '1996', '1997', '1998', '1999',
    '2000', '2001', '2002', '2003', '2004',
    '2005', '2006', '2007', '2008', '2009',
    '2010', '2011', '2012', '2013', '2014',
    '2015', '2016', '2017', '2018', '2019',
    '2020', '2022'
  ];
  List<String> _grade = [
    "A+","B+","C+","D+"
  ];

  final formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          /*floatingActionButton: FloatingActionButton(
            onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => SheetsList()));
            },
            child: Icon(Icons.arrow_forward_ios_rounded),
          ),*/
          appBar: AppBar(
              centerTitle: true,
              title: Text(
                "Add Resume",
                style: textStyleBold.copyWith(
                  fontSize: 20,
                  color: Colors.white
                ),
              )
          ),
          body: NotificationListener<OverscrollIndicatorNotification>(
            onNotification: (OverscrollIndicatorNotification overscroll) {
              overscroll.disallowGlow();
            },
            child: SingleChildScrollView(
              child: GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () {
                  FocusManager.instance.primaryFocus.unfocus();
                },
                child: Form(
                  key: formkey,
                  child: Padding(
                    padding: EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Name:",
                          style: textStyle.copyWith(
                            fontWeight: FontWeight.bold
                          ),
                        ),
                        SizedBox(height: 5),
                        TextFormField(
                          controller: nameController,
                          keyboardType: TextInputType.name,
                          decoration: fieldStyle.copyWith(
                            hintStyle: textStyle,
                            hintText: "Enter name",
                            border: OutlineInputBorder()
                          ),
                          validator: (value) {
                            if(value.isEmpty) {
                              return "Enter Name";
                            }
                          },
                        ),
                        SizedBox(height: 10),
                        Text(
                          "Email:",
                          style: textStyle.copyWith(
                              fontWeight: FontWeight.bold
                          ),
                        ),
                        SizedBox(height: 5),
                        TextFormField(
                            controller: emailController,
                            keyboardType: TextInputType.emailAddress,
                            decoration: fieldStyle.copyWith(
                              hintStyle: textStyle,
                              hintText: "Enter email",
                              border: OutlineInputBorder()
                            ),
                            validator: (value) {
                              if(value.isEmpty)
                              {
                                return "Please enter email";
                              }
                              if(!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]").hasMatch(value)){
                                return 'Please a valid Email';
                              }
                              return null;
                            }
                        ),
                        SizedBox(height: 10),
                        Text(
                          "Mobile Number:",
                          style: textStyle.copyWith(
                              fontWeight: FontWeight.bold
                          ),
                        ),
                        SizedBox(height: 5),
                        TextFormField(
                          controller: numController,
                          keyboardType: TextInputType.number,
                          decoration: fieldStyle.copyWith(
                            hintStyle: textStyle,
                            hintText: "Enter mobile number",
                            border: OutlineInputBorder()
                          ),
                          validator: (value) {
                            if(value.isEmpty)
                            {
                              return "Please enter number";
                            }
                            if(value.length != 10){
                              return 'Please a valid number';
                            }
                            return null;
                          }
                        ),
                        SizedBox(height: 10),
                        Text(
                          "Date of birth:",
                          style: textStyle.copyWith(
                              fontWeight: FontWeight.bold
                          ),
                        ),
                        SizedBox(height: 5),
                        TextFormField(
                          readOnly: true,
                          style: textStyle,
                          keyboardType: TextInputType.number,
                          controller: dobController,
                          focusNode: AlwaysDisabledFocusNode(),
                          onTap: () async {
                            FocusScope.of(context).unfocus();
                            DateTime newSelectedDate = await _selecttDate(context);
                            if (newSelectedDate != null) {
                              setState(() {
                                _selectedDate = newSelectedDate;
                                initializeDateFormatting('es');
                                dobController
                                  ..text = DateFormat("dd-MMM-yyyy").format(_selectedDate);
                              });
                            }
                          },
                          validator: (value) {
                            if(value.isEmpty)
                            {
                              return "Please select date of birth";
                            }
                            return null;
                          },
                          decoration: fieldStyle.copyWith(
                            hintStyle: textStyle,
                            hintText: "Select date of birth",
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.grey,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          "Address:",
                          style: textStyle.copyWith(
                              fontWeight: FontWeight.bold
                          ),
                        ),
                        SizedBox(height: 5),
                        TextFormField(
                            controller: addressController,
                            keyboardType: TextInputType.multiline,
                            maxLines: 2,
                            decoration: fieldStyle.copyWith(
                              hintStyle: textStyle,
                              hintText: "Enter address",
                              border: OutlineInputBorder()
                            ),
                            validator: (value) {
                              if(value.isEmpty)
                              {
                                return "Please enter address";
                              }
                              return null;
                            }
                        ),
                        SizedBox(height: 10),
                        Text(
                          "Work Experience:",
                          style: textStyle.copyWith(
                              fontWeight: FontWeight.bold
                          ),
                        ),
                        SizedBox(height: 5),
                        TextFormField(
                            controller: expTitleController,
                            decoration: fieldStyle.copyWith(
                                hintStyle: textStyle,
                                hintText: "Enter title",
                                border: OutlineInputBorder()
                            ),
                            validator: (value) {
                              if(value.isEmpty)
                              {
                                return "Please enter title";
                              }
                              return null;
                            }
                        ),
                        SizedBox(height: 5),
                        TextFormField(
                            controller: expDescController,
                            keyboardType: TextInputType.multiline,
                            maxLines: 2,
                            decoration: fieldStyle.copyWith(
                              hintStyle: textStyle,
                              hintText: "Enter description",
                              border: OutlineInputBorder()
                            ),
                            validator: (value) {
                              if(value.isEmpty)
                              {
                                return "Please enter description";
                              }
                              return null;
                            }
                        ),
                        SizedBox(height: 5),
                        Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                readOnly: true,
                                style: textStyle,
                                keyboardType: TextInputType.number,
                                controller: startDateController,
                                focusNode: AlwaysDisabledFocusNode(),
                                onTap: () async {
                                  FocusScope.of(context).unfocus();
                                  DateTime newSelectedDate = await _selecttDate(context);
                                  if (newSelectedDate != null) {
                                    setState(() {
                                      _selectedDate = newSelectedDate;
                                      initializeDateFormatting('es');
                                      startDateController
                                        ..text = DateFormat("dd-MMM-yyyy").format(_selectedDate);
                                    });
                                  }
                                },
                                validator: (value) {
                                  if(value.isEmpty)
                                  {
                                    return "Please select start date";
                                  }
                                  return null;
                                },
                                decoration: fieldStyle.copyWith(
                                  hintStyle: textStyle,
                                  hintText: "Start date",
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.grey,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: 10),
                            Expanded(
                              child: TextFormField(
                                readOnly: true,
                                style: textStyle,
                                keyboardType: TextInputType.number,
                                controller: endDateController,
                                focusNode: AlwaysDisabledFocusNode(),
                                onTap: () async {
                                  FocusScope.of(context).unfocus();
                                  DateTime newSelectedDate = await _selecttDate(context);
                                  if (newSelectedDate != null) {
                                    setState(() {
                                      _selectedDate = newSelectedDate;
                                      initializeDateFormatting('es');
                                      endDateController
                                        ..text = DateFormat("dd-MMM-yyyy").format(_selectedDate);
                                    });
                                  }
                                },
                                validator: (value) {
                                  if(value.isEmpty)
                                  {
                                    return "Please select end date";
                                  }
                                  return null;
                                },
                                decoration: fieldStyle.copyWith(
                                  hintStyle: textStyle,
                                  hintText: "End date",
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.grey,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        Text(
                          "Education:",
                          style: textStyle.copyWith(
                              fontWeight: FontWeight.bold
                          ),
                        ),
                        SizedBox(height: 5),
                        TextFormField(
                            controller: educationController,
                            decoration: fieldStyle.copyWith(
                                hintStyle: textStyle,
                                hintText: "Enter Degree",
                                border: OutlineInputBorder()
                            ),
                            validator: (value) {
                              if(value.isEmpty)
                              {
                                return "Please enter degree";
                              }
                              return null;
                            }
                        ),
                        SizedBox(height: 5),
                        Row(
                          children: [
                            Expanded(
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: gradeColor
                                  ),
                                  borderRadius: BorderRadius.circular(4)
                                ),
                                child: DropdownButton(
                                  isExpanded: true,
                                  underline: SizedBox(),
                                  hint: Text('Select Grade'),
                                  value: _selectedGrade,
                                  style: textStyle.copyWith(
                                    color: Colors.black
                                  ),
                                  onChanged: (newValue) {
                                    setState(() {
                                      _selectedGrade = newValue;
                                    });
                                  },
                                  items: _grade.map((value) {
                                    return DropdownMenuItem(
                                      child: Text(value),
                                      value: value,
                                    );
                                  }).toList(),
                                ),
                              ),
                            ),
                            SizedBox(width: 10),
                            Expanded(
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: yearColor
                                    ),
                                    borderRadius: BorderRadius.circular(4)
                                ),
                                child: DropdownButton(
                                  isExpanded: true,
                                  underline: SizedBox(),
                                  hint: Text('Select Year'),
                                  value: _selectedYear,
                                  style: textStyle.copyWith(
                                      color: Colors.black
                                  ),
                                  onChanged: (newValue) {
                                    setState(() {
                                      _selectedYear = newValue;
                                    });
                                  },
                                  items: _years.map((value) {
                                    return DropdownMenuItem(
                                      child: Text(value),
                                      value: value,
                                    );
                                  }).toList(),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        isLoading == true
                            ?
                        Center(child: CircularProgressIndicator())
                            :
                        SizedBox(
                          height: 60,
                          width: MediaQuery.of(context).size.width,
                          child: ElevatedButton(
                              onPressed: () async {
                                if(_selectedGrade != null) {
                                  setState(() {
                                    gradeColor = Colors.grey;
                                  });
                                } else {
                                  setState(() {
                                    gradeColor = Colors.red;
                                  });
                                }
                                if(_selectedYear != null) {
                                  setState(() {
                                    yearColor = Colors.grey;
                                  });
                                } else {
                                  setState(() {
                                    yearColor = Colors.red;
                                  });
                                }
                                if(formkey.currentState.validate() && _selectedYear != null) {
                                  setState(() {
                                    isLoading = true;
                                  });

                                  final id = await SheetsApi.getRowCount() + 1;

                                  final field = Field(
                                    id: id.toString(),
                                    // name: nameController.text,
                                    name: StringUtils.capitalize(nameController.text),
                                    email: emailController.text,
                                    number: numController.text,
                                    dob: dobController.text,
                                    address: addressController.text,
                                    exptitle: StringUtils.capitalize(expTitleController.text),
                                    expdesc: StringUtils.capitalize(expDescController.text),
                                    startDate: startDateController.text,
                                    endDate: endDateController.text,
                                    degree: StringUtils.capitalize(educationController.text),
                                    grade: _selectedGrade,
                                    year: _selectedYear
                                  );
                                  await SheetsApi.insert([field.toJson()]);
                                  FocusScope.of(context).unfocus();
                                  nameController.clear();
                                  emailController.clear();
                                  numController.clear();
                                  dobController.clear();
                                  addressController.clear();
                                  expTitleController.clear();
                                  expDescController.clear();
                                  startDateController.clear();
                                  endDateController.clear();
                                  educationController.clear();
                                  setState(() {
                                    _selectedGrade = null;
                                    _selectedYear = null;
                                  });

                                  setState(() {
                                    isLoading = false;
                                  });
                                }
                                /*else {
                                  final snackBar =
                                  SnackBar(
                                    duration: Duration(seconds: 2),
                                    backgroundColor: Colors.red,
                                    behavior: SnackBarBehavior.floating,
                                    content: Text("All fields must be selected",style:textStyle.copyWith(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
                                  );

                                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                }*/
                                /*if(formkey.currentState.validate()) {

                                  setState(() {
                                    isLoading = true;
                                  });

                                  final id = await SheetsApi.getRowCount() + 1;

                                  final field = Field(
                                      id: id,
                                      // name: nameController.text,
                                      name: StringUtils.capitalize("${nameController.text}"),
                                      email: emailController.text,
                                      number: int.parse(numController.text)
                                  );
                                  await SheetsApi.insert([field.toJson()]);
                                  FocusScope.of(context).unfocus();
                                  nameController.clear();
                                  emailController.clear();
                                  numController.clear();

                                  setState(() {
                                    isLoading = false;
                                  });

                                }*/
                              },
                              child: Text(
                                "Submit",
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold
                                ),
                              )
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        )
    );
  }

  _selecttDate(BuildContext context) async {
    DateTime newSelectedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        // firstDate: DateTime.now().subtract(Duration(days: 10)),
        firstDate: DateTime(1990),
        lastDate: DateTime.now(),
        builder: (BuildContext context, Widget child) {
          return Theme(
            data: ThemeData.dark().copyWith(
              colorScheme: ColorScheme.light(
                primary: Color(0xFF0048D9),
                onPrimary: Colors.white,
                surface: Color(0xFF0048D9),
                onSurface: Colors.black,
              ),
              dialogBackgroundColor: Colors.white,
            ),
            child: child,
          );
        }
    );
    return newSelectedDate;
  }

}

class AlwaysDisabledFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}