import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:app_climate/features/weather/presentation/providers/weather_provider.dart';
import 'package:app_climate/features/weather/presentation/widgets/weather_display.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    final weatherProvider = Provider.of<WeatherProvider>(context);

    return Scaffold(
      body: Container(
        child: weatherProvider.isLoading
            ? CircularProgressIndicator() 
            : weatherProvider.errorMessage != null
                ? Text(weatherProvider.errorMessage!)
                : WeatherDisplay(data: weatherProvider.weatherData!),
      ),
    );
  }
}
