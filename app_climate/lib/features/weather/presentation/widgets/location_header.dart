import 'package:flutter/material.dart';

class LocationHeader extends StatelessWidget {
  final Map<String, dynamic> location;
  
  const LocationHeader({super.key, required this.location});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [ 
        Center(
          child: Text(
            location['name'],
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.white),
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
}
