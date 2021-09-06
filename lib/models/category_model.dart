import 'package:flutter/material.dart';

class CategoryModel {

  String label;
  String value;
  Color startColor, endColor;


  CategoryModel({this.label, this.value,this.startColor, this.endColor});

}

List<CategoryModel> categoryList = [
  CategoryModel(label: "Movies",value : "movie", startColor : Color(0xFFE040FB), endColor: Color(0xFF6A1B9A)),
  CategoryModel(label: "Tv shows",value : "tv", startColor : Color(0xFFFFFF00), endColor: Color(0xFFF9A825)),
  CategoryModel(label: "Clebs",value : "people", startColor : Color(0xFFE040FB), endColor: Color(0xFF6A1B9A)),
  CategoryModel(label: "Settings",value : "settings", startColor : Color(0xFFFFFF00), endColor: Color(0xFFF9A825)),

];
