import 'package:flutter/material.dart';
import 'package:resumemaker/Values/appColors.dart';
import 'package:resumemaker/Values/components.dart';

class ResumeDetailPage extends StatefulWidget {
  ResumeDetailPage({
    Key key,
    @required this.id,
    @required this.name,
    @required this.email,
    @required this.number,
    @required this.dob,
    @required this.address,
    @required this.exptitle,
    @required this.expdesc,
    @required this.startDate,
    @required this.endDate,
    @required this.degree,
    @required this.grade,
    @required this.year,
  }) : super(key: key);

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

  @override
  State<ResumeDetailPage> createState() => _ResumeDetailPageState();
}

class _ResumeDetailPageState extends State<ResumeDetailPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            "Resume",
            style: textStyleBold.copyWith(
                fontSize: 20,
                color: Colors.white
            ),
          )
        ),
        body: Padding(
          padding: EdgeInsets.all(20),
          child: Row(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width / 1.8,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 20),
                    Text(
                      "Your Name",
                      style: textStyleBold,
                    ),
                    SizedBox(height: 5),
                    Text(
                      // "Senior Product Designer",
                      "${widget.name}",
                      style: textStyle,
                    ),
                    SizedBox(height: 20),
                    Text(
                      "Experience",
                      style: textStyle.copyWith(
                        fontSize: 13,
                        color: Appcolors.gray1
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      "${widget.exptitle}",
                      style: textStyleBold.copyWith(
                        fontSize: 14
                      ),
                    ),
                    SizedBox(height: 2),
                    Text(
                      "${widget.expdesc}",
                      style: textStyle.copyWith(
                        fontSize: 14,
                      ),
                    ),
                    SizedBox(height: 5),
                    Row(
                      children: [
                        Text(
                          "${widget.startDate} - ",
                          style: textStyle.copyWith(
                            fontSize: 14,
                          ),
                        ),
                        Text(
                          "${widget.endDate}",
                          style: textStyle.copyWith(
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    Text(
                      "Education",
                      style: textStyle.copyWith(
                        fontSize: 14,
                        color: Appcolors.gray1
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      "${widget.degree}",
                      style: textStyleBold,
                    ),
                    SizedBox(height: 2),
                    Text(
                      "${widget.grade}",
                      style: textStyle,
                    ),
                    SizedBox(height: 2),
                    Text(
                      "${widget.year}",
                      style: textStyle,
                    ),
                  ],
                ),
              ),
              SizedBox(width: 5),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 20),
                    CircleAvatar(
                      radius: 30,
                      backgroundImage: AssetImage("assets/images/person5.png"),
                      backgroundColor: Colors.transparent,
                    ),
                    SizedBox(height: 10),
                    Text(
                      "${widget.dob}",
                      style: textStyle.copyWith(
                        fontSize: 14
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      "${widget.email}",
                      style: textStyle.copyWith(
                        fontSize: 13
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      "${widget.number}",
                      style: textStyle.copyWith(
                        fontSize: 14
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      "${widget.address}",
                      style: textStyle.copyWith(
                          fontSize: 14
                      ),
                    ),
                    SizedBox(height: 20),
                    Text(
                      "Languages",
                      style: textStyleBold.copyWith(
                          fontSize: 13
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      "Hindi",
                      style: textStyle.copyWith(
                          fontSize: 14
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      "English",
                      style: textStyle.copyWith(
                          fontSize: 14
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      "Marathi",
                      style: textStyle.copyWith(
                          fontSize: 14
                      ),
                    ),
                    SizedBox(height: 20),
                    Text(
                      "Other Skills",
                      style: textStyleBold.copyWith(
                          fontSize: 13
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      "HTML",
                      style: textStyle.copyWith(
                          fontSize: 14
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      "Flutter",
                      style: textStyle.copyWith(
                          fontSize: 14
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      "CSS",
                      style: textStyle.copyWith(
                          fontSize: 14
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      "jQuery",
                      style: textStyle.copyWith(
                          fontSize: 14
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
