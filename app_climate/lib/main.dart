import 'package:app_climate/app/app.dart';
import 'package:app_climate/features/weather/presentation/providers/weather_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final weatherProvider = WeatherProvider();
  await weatherProvider.iniinitialize();
  runApp(
    ChangeNotifierProvider(
      create: (context) => weatherProvider,
      child: ClimateApp(),
    )
  );
}

