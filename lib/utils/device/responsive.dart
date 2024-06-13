import 'package:flutter/material.dart';

double getWidth (BuildContext context){
  final width = MediaQuery.sizeOf(context).width;
  return width;
}

double getHeight (BuildContext context){
  final height = MediaQuery.sizeOf(context).height;
  return height;
}