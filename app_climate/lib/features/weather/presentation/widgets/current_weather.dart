import 'package:flutter/material.dart';

class CurrentWeather extends StatelessWidget {
  final Map<String, dynamic> current;
  final List<dynamic> forecast;
  
  const CurrentWeather({super.key, required this.current, required this.forecast});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          children: [ 
            SizedBox(
              width: double.infinity,
              height: 50,
              child: Text(
                '${current['temp_c'].round()}°',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.white),
              ),
            ),
            Positioned(
              left: 45,
              child: Image.network(
                'https:${current['condition']['icon']}',  
                width: 50,
                height: 50,
              ),
            ),
            Positioned(
              right: 0,
              bottom: 18,
              child: SizedBox(
                child: Text(
                  '${current['condition']['text']}',
                  softWrap: true,
                  style: TextStyle(fontSize: 15, color: Colors.white, ),
                ),
              ),
            ),
            Positioned(
              right: 0,
              bottom: 0,
              child: Text(
                'Feels like ${current['feelslike_c']}°',
                style: TextStyle(fontSize: 13, color: Colors.grey),
              ),
            ),
            Positioned(
              left: 0,
              bottom: 0,
              child: Text(
                'High ${forecast[0]["day"]["maxtemp_c"]}° / Low ${forecast[0]["day"]["mintemp_c"]}°',
                style: TextStyle(fontSize: 10, color: Colors.grey),
              ),
            ),
          ],
        ),
      ]
    );
  }
}
