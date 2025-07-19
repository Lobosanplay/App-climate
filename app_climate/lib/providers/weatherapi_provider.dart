import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart' ;



class WeatherProvider extends ChangeNotifier{
  bool _isLoading = false;
  Map<String, dynamic>? _weatherData = {};
  String? _errorMessage;

  bool get isLoading => _isLoading;
  Map<String, dynamic>? get weatherData => _weatherData;
  String? get errorMessage => _errorMessage;


  Future<void> iniinitialize() async {
  await dotenv.load(fileName: ".env");
  }

  Future<void> fetchWeather({String location = "Colombia"}) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    final apiKey = dotenv.env["SECRET_KEY"] ?? "";
    if (apiKey.isEmpty) {
      _errorMessage = 'API key not configured';
      _isLoading = false;
      notifyListeners();
      return;
    }

    final url = Uri.parse(
      "https://api.weatherapi.com/v1/current.json?key=$apiKey &q=$location&aqi=yes"
    );

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
            _weatherData  = jsonDecode(response.body);
      } else {
        _errorMessage = "Error: ${response.statusCode} - ${response.reasonPhrase}";
      }
    } catch (e) {
      _errorMessage = 'Failed to fetch weather data: ${e.toString()}';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
