import 'package:flutter/material.dart';

class AdvantagesSection extends StatelessWidget {
  final List<String> advantages = [
    'Disable ads',
    'Configure own settings',
    'You can select your country',
    'You can disable notifications on National Days and Holidays',
    'Get further app improvements after BackPal updates',
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Text(
          'Advantages of Pro Version',
          style: TextStyle(
            fontSize: 20.0,
            fontFamily: 'Montserrat',
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        SizedBox(height: 1.0),
        // Unordered List
        ListView.builder(
          shrinkWrap: true,
          itemCount: advantages.length,
          itemBuilder: (context, index) {
            return ListTile(
              contentPadding: EdgeInsets.fromLTRB(15, 0, 15, 0),
              leading: Icon(
                Icons.fiber_manual_record,
                color: Colors.white,
                size: 10.0,
              ),
              title: Text(
                advantages[index],
                style: TextStyle(
                  fontSize: 16.0,
                  fontFamily: 'Montserrat',
                  color: Colors.white,
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}