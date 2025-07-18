import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart' ;



class ClimaProviders extends ChangeNotifier{
  bool isloading = false;

  Future main() async {
  await dotenv.load(fileName: ".env");
  //...runapp
  }

  final apiKey = dotenv.env['SECRET_KEY'];

  Future<void> FetchRecipes() async {
    isloading = true;
    notifyListeners();

    final url = Uri.parse("https://api.openweathermap.org/data/3.0/onecall?lat=10.4266746&lon=-75.5443419&exclude=hourly,daily&appid=$apiKey");

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
            final data = jsonDecode(response.body);
            return data;
      } else {
        print("Error ${response.statusCode}");
      }
    } catch (e) {
      print("Error in request");
    } finally {
      isloading = false;
      notifyListeners();
    }
  }
}
