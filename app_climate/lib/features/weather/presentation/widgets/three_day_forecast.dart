import 'package:flutter/material.dart';
import "package:intl/intl.dart";

class ThreeDayForecast extends StatelessWidget{

  final List<dynamic> forecastDay;
  
  const ThreeDayForecast({super.key, required this.forecastDay});

  @override
  Widget build(BuildContext context) {
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
}