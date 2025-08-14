import 'package:app_climate/providers/weatherapi_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import "package:intl/intl.dart";
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
      body: Container(
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
                _buildLocationHeader(location),
                SizedBox(height: 16),
                _buildCurrentWeather(current, forecast),
                Divider(height: 32, thickness: 1),
                Text(
                  'Hourly forecast',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                _buildHourlyForecast(forecast),
                Divider(height: 32, thickness: 1),
                Text(
                  '3-day forecast',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                _build3DayForecast(forecast),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

  Widget _buildLocationHeader(Map<String, dynamic> location) {
    return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [ 
              Center(
                child: Text(
                  location['name'],
                  style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Now',
              style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
              ),
            ],
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
        Text(
          '${forecast[0]["day"]["condition"]["text"]}',
          style: TextStyle(fontSize: 20),
        ),
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
        SizedBox(height: 8),
        Text(
          '${current['feelslike_c']}°',
          style: TextStyle(fontSize: 16, color: Colors.grey),
        ),

      ],
    );
  }

  Widget _buildHourlyForecast(List<dynamic> forecastDay) {

    final currentHour = DateTime.now().hour;
    final hourlyForecast = forecastDay[0]['hour']
    .where((h) => DateTime.parse(h['time']).hour >= currentHour)
    .take(6)
    .toList();

    return Container(
        decoration: BoxDecoration(
            color: Color.fromRGBO(3, 59, 75, 0.7),
            borderRadius: BorderRadius.circular(10)
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
          SizedBox(
            height: 100,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: hourlyForecast.length,
              separatorBuilder: (context, index) => SizedBox(width: 20),
              itemBuilder: (context, index) {
                final hour = hourlyForecast[index];
                final time  = DateTime.parse(hour['time']);
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '${hour["temp_c"].round()}°C',
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                    SizedBox(height: 8),
                    Text(
                      index == 0 ? 'Now' : '${time.hour}:00',
                      style: TextStyle(fontSize: 14, color: Colors.white),
                    ),
                    SizedBox(height: 4),
                    Image.network(
                        'https:${hour['condition']['icon']}',
                        width: 32,
                        height: 32,
                    )
                  ],
                );
              },
            ),
          ),
        ],
        ),
    );
  
  }
  Widget _build3DayForecast(List<dynamic> forecastDay) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Column(
        children: forecastDay.map((day) {
          final date = DateTime.parse(day['date']);
          final formattedDate = DateFormat('EEE, MMM d').format(date);
          final isToday = day == forecastDay.first;
          
          return Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Color.fromRGBO(3, 59, 75, 0.7),
                  borderRadius: BorderRadius.circular(10)
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0) ,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Text(
                            isToday ? 'Today' : formattedDate,
                            style: TextStyle(color: Colors.white)
                            ),
                          SizedBox(width: 8),
                          Image.network(
                            'https:${day['day']['condition']['icon']}',
                            width: 24,
                            height: 24,
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            '${day['day']['maxtemp_c'].round()}°',
                            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
                          ),
                          Text(
                            ' / ',
                            style: TextStyle(color: Colors.white)
                            ),
                          Text(
                            '${day['day']['mintemp_c'].round()}°',
                            style: TextStyle(color: Colors.white),
                            ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 8),
            ],
          );
        }).toList(),
      ),
    ],
  );
}
