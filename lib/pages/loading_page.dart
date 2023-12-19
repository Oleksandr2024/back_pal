import 'package:flutter/material.dart';

class LoadingPage extends StatefulWidget {
  const LoadingPage({Key? key}) : super(key: key);

  @override
  _LoadingPageState createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {
  @override
  void initState() {
    super.initState();

    // Simulate loading with a delay
    Future.delayed(Duration(seconds: 2), () {
      // Navigate to Home page after loading
      Navigator.pushReplacementNamed(context, '/home');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Background picture
          Image.asset(
            'assets/BackGroundBack.png',
            fit: BoxFit.cover,
          ),

          const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Customized CircularProgressIndicator
                CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.orange),
                ),
                SizedBox(height: 16),
                Text(
                  'Loading...',
                  style: TextStyle(
                      color: Colors.white,
                    fontSize: 25.0,
                    fontWeight: FontWeight.w500
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}