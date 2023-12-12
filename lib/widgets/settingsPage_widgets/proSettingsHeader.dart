import 'package:flutter/material.dart';

class ProSettingsHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Align(
      alignment: Alignment.center,
      child: Text(
        'Pro settings',
        style: TextStyle(
          fontSize: 24.0,
          fontFamily: 'Montserrat',
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}