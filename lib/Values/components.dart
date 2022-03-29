import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'appColors.dart';

var textStyle = TextStyle(
    fontSize: 16,
    color: Appcolors.black,
    fontFamily: "Montserrat-Regular"
);

var textStyleBold = TextStyle(
    fontSize: 16,
    color: Appcolors.black,
    fontFamily: "Montserrat-Bold"
);

var fieldStyle = InputDecoration(
  // filled: true,
  isDense: true,
  hintStyle: TextStyle(
    color: Colors.black,
    fontSize: 16
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(
      color: Colors.grey,
    ),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(
      color: Colors.blue,
    ),
  ),
  errorBorder: OutlineInputBorder(
    borderSide: BorderSide(
      color: Colors.red,
    ),
  ),
  focusedErrorBorder: OutlineInputBorder(
    borderSide: BorderSide(
      color: Colors.red,
    ),
  ),
);