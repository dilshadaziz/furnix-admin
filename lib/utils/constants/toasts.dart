import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:furnix_admin/utils/constants/colors.dart';

void toast (String message) {
    Fluttertoast.showToast(webPosition: "right", msg: message,toastLength: Toast.LENGTH_SHORT,gravity: ToastGravity.TOP,timeInSecForIosWeb: 4,textColor: Colors.white,fontSize: 16.0,backgroundColor: FColors.primaryColor);
}