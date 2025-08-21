import 'package:flutter/material.dart';
import 'package:app_climate/features/weather/presentation/widgets/location_header.dart';
import 'package:app_climate/features/weather/presentation/widgets/current_weather.dart';
import 'package:app_climate/features/weather/presentation/widgets/hourly_forecast.dart';
import 'package:app_climate/features/weather/presentation/widgets/three_day_forecast.dart';
import 'package:app_climate/features/weather/presentation/widgets/search_bar.dart';

class WeatherDisplay extends StatelessWidget {
  final Map<String, dynamic> data;

  const WeatherDisplay({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final current = data['current'];
    final location = data['location'];
    final forecast = data["forecast"]["forecastday"];

    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        height: screenHeight,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color.fromRGBO(15, 32, 39, 1), Color.fromRGBO(32, 58, 67, 1), Color.fromRGBO(44, 83, 100, 1)],
          )
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                LocationHeader(location: location),
                CurrentWeather(current: current, forecast: forecast),
                const Divider(height: 32, thickness: 1),
                Text(
                  'Hourly forecast',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
                ),
                HourlyForecast(forecastDay: forecast),
                const Divider(height: 32, thickness: 1),
                Text(
                  '3-day forecast',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
                ),
                ThreeDayForecast(forecastDay: forecast),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
