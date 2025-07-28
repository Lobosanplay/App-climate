import 'package:app_climate/providers/weatherapi_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final weatherProvider = WeatherProvider();
  await weatherProvider.iniinitialize();
  runApp(
    ChangeNotifierProvider(
      create: (context) => weatherProvider,
      child: climate(),
    )
  );
}

class climate extends StatelessWidget {
  const climate({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'App climate',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(),
    );
  }
}

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

class WeatherDisplay extends StatelessWidget {
  final Map<String, dynamic> data;
  
  const WeatherDisplay({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final current = data['current'];
    final location = data['location'];
    final forecast = data["forecast"]["forecastday"];

    return Scaffold(
      body: _buildBody(current, forecast, location),
    );
  }

  Widget _buildLocactionHeader(Map<String, dynamic> location) {
    return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [ 
              Text(
                location['name'],
                style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(
                'Now',
              style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
              ),
            ],
      );
  }

  Widget _buildBody(Map<String, dynamic> current, List<dynamic> forecast, Map<String, dynamic> location) {
    return Container(
      color: Colors.lightBlueAccent,
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            _buildLocactionHeader(location),
            _buildCurrentWeather(current, forecast),
            SizedBox(height: 20),
            _buildForecast(forecast.first)
          ],
        ),
        ),
    );
  }

  Widget _buildCurrentWeather(Map<String, dynamic> current, List<dynamic> forecast,) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '${current['temp_c']}°C',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        Text(
          'High ${forecast[0]["day"]["maxtemp_c"]}° / Low ${forecast[0]["day"]["mintemp_c"]}°',
          style: TextStyle(fontSize: 16),
        ),
        SizedBox(height: 10),
        Row(
          children: [
            Image.network(
              'https:${current['condition']['icon']}',
              width: 64,
              height: 64,
            ),
            SizedBox(height: 10),
            Text(
                current['condition']['text'],
                style: TextStyle(fontSize: 20),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildForecast(Map<String, dynamic> forecastDay) {
    return Container(
      width: 100,
      height: 100,
      color: Colors.transparent,
      child: Column(
        children: [
          Image.network(
            'https:${forecastDay["day"]["condition"]["icon"]}',
            width: 64,
            height: 64,
          ),
          Text(forecastDay["date"]),
        ],
      ),
    );
  }
}
