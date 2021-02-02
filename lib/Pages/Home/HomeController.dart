import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HomeController{
  final realController = TextEditingController();
  final dropdownController = TextEditingController();
  List<String> currencies = ["dolar", "real", "euro"];
  String symbol = "\$";
  var dropdownValue = "dolar";
  double changeCurriency = 1;
  double dollar;
  double euro;
  static final url = "https://api.hgbrasil.com/finance?format=json&key=832cb5fb";


  Future<Map> getData() async {
    http.Response response = await http.get(url);
    return jsonDecode(response.body)['results']['currencies'];
  }

  void clearAll() {
    realController.text = "";
    dropdownController.text = "";
  }

  void realChange(String s) {
    if (s.isEmpty) {
      clearAll();
      return;
    }

    double real = double.parse(s);
    dropdownController.text = (real / changeCurriency).toStringAsFixed(2);
  }

  void changeSelector(String s){
    if (s.isEmpty) {
      clearAll();
      return;
    }

    double curriency = double.parse(s);
    switch (dropdownValue) {
      case "dolar":
        realController.text = (curriency * this.dollar).toStringAsFixed(2);
        break;
      case "euro":
        realController.text = (curriency * this.euro).toStringAsFixed(2);
        break;
      default:
    }
  }

  void changeReal(){
    double value = double.parse(dropdownController.text == ""? "1" : dropdownController.text);
    realController.text = (value * changeCurriency).toStringAsFixed(2);
  }
}