import 'package:flutter/material.dart';

class HourlyForecast extends StatelessWidget{
  final List<dynamic> forecastDay;
  const HourlyForecast({super.key, required this.forecastDay});

  @override
  Widget build(BuildContext context) {
    final currentHour = DateTime.now().hour;
    final hourlyForecast = forecastDay[0]['hour']
    .where((h) => DateTime.parse(h['time']).hour >= currentHour)
    .take(24)
    .toList();

    return Container(
        decoration: BoxDecoration(
            color: Color.fromRGBO(3, 59, 75, 0.7),
            borderRadius: BorderRadius.circular(10)
        ),
        child: SingleChildScrollView(
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
        ),
    );
  
  }
}