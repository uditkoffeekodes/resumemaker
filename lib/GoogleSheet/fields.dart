import 'dart:convert';

class Fields {
  static final String id = "Id";
  static final String name = "Name";
  static final String email = "Email";
  static final String number = "Number";
  static final String dob = "Dob";
  static final String address = "Address";
  static final String exptitle = "Experience title";
  static final String expdesc = "Experience Description";
  static final String startDate = "Start Date";
  static final String endDate = "End Date";
  static final String degree = "Degree";
  static final String grade = "Grade";
  static final String year = "Year";

  static List<String> getFields() => [
    id, name, email, number,dob,
    address, exptitle, expdesc, startDate, endDate,
    degree, grade, year
  ];
}

class Field {
  final String id;
  final String name;
  final String email;
  final String number;
  final String dob;
  final String address;
  final String exptitle;
  final String expdesc;
  final String startDate;
  final String endDate;
  final String degree;
  final String grade;
  final String year;

  const Field({
    this.id,
    this.name,
    this.email,
    this.number,
    this.dob,
    this.address,
    this.exptitle,
    this.expdesc,
    this.startDate,
    this.endDate,
    this.degree,
    this.grade,
    this.year,
  });

  static Field fromJson(Map<String, dynamic> json) => Field(
    id: json[Fields.id],
    name: json[Fields.name],
    email: json[Fields.email],
    number: json[Fields.number],
    dob: json[Fields.dob],
    address: json[Fields.address],
    exptitle: json[Fields.exptitle],
    expdesc: json[Fields.expdesc],
    startDate: json[Fields.startDate],
    endDate: json[Fields.endDate],
    degree: json[Fields.degree],
    grade: json[Fields.grade],
    year: json[Fields.year]
  );

  Map<String, dynamic> toJson() => {
    Fields.id : id,
    Fields.name : name,
    Fields.email : email,
    Fields.number : number,
    Fields.dob : dob,
    Fields.address : address,
    Fields.exptitle : exptitle,
    Fields.expdesc : expdesc,
    Fields.startDate : startDate,
    Fields.endDate : endDate,
    Fields.degree : degree,
    Fields.grade : grade,
    Fields.year : year,
  };

}