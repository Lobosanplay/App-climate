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

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'App climate',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(title: 'App climate'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {


  @override
  Widget build(BuildContext context) {
    final weatherProvider = Provider.of<WeatherProvider>(context);

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment(0.8, 1),
            colors: <Color>[
              Color.fromRGBO(0, 0, 70, 1),
              Color.fromRGBO(28, 181, 224, 1)
            ],
          ),
        ),
        child: weatherProvider.isLoading
            ? CircularProgressIndicator()
            : weatherProvider.errorMessage != null
                ? Text(weatherProvider.errorMessage!)
                : WeatherDisplay(data: weatherProvider.weatherData!),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => weatherProvider.fetchWeather(),
        child: Icon(Icons.refresh),
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
    
    return SingleChildScrollView(
      padding: EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            location['name'],
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          Text(
            '${current['temp_c']}°C',
            style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.network(
                'https:${current['condition']['icon']}',
                width: 64,
                height: 64,
              ),
              SizedBox(width: 10),
              Text(
                current['condition']['text'],
                style: TextStyle(fontSize: 20),
              ),
            ],
          ),
          SizedBox(height: 30),
          Wrap(
            spacing: 20,
            runSpacing: 20,
            children: [
              _buildWeatherInfo('Humedad', '${current['humidity']}%'),
              _buildWeatherInfo('Viento', '${current['wind_kph']} km/h'),
              _buildWeatherInfo('Sensación', '${current['feelslike_c']}°C'),
              _buildWeatherInfo('Presión', '${current['pressure_mb']} hPa'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildWeatherInfo(String label, String value) {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.blue[50],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Text(label, style: TextStyle(color: Colors.blue[800])),
          Text(value, style: TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
