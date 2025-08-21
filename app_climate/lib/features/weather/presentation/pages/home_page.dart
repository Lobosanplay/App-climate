import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:app_climate/features/weather/presentation/providers/weather_provider.dart';
import 'package:app_climate/features/weather/presentation/widgets/search_bar.dart';
import 'package:app_climate/features/weather/presentation/widgets/weather_display.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final weatherProvider = Provider.of<WeatherProvider>(context);

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color.fromRGBO(15, 32, 39, 1),
              Color.fromRGBO(32, 58, 67, 1),
              Color.fromRGBO(44, 83, 100, 1)
            ],
          )
        ),
        child: Column(
          children: [
            const SearchBarApp(), // Barra de búsqueda arriba
            Expanded(
              child: weatherProvider.isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : weatherProvider.errorMessage != null
                      ? Center(
                          child: Text(
                            weatherProvider.errorMessage!,
                            style: TextStyle(color: Colors.white),
                          ),
                        )
                      : WeatherDisplay(data: weatherProvider.weatherData!),
            ),
          ],
        ),
      ),
    );
  }
}
