import 'package:flutter/material.dart';
// import 'package:back_pal/services/notification_service.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/LogoBack2cover2.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 300.0), //was 300

            // Stack to position the Divider above the text
            const Stack(
              children: [
                // Some text
                Padding(
                  padding: EdgeInsets.fromLTRB(60.0, 30.0, 30.0, 10.0),
                  child: Text(
                    'BackPal: Your Back Deserves the Best!',
                    style: TextStyle(
                      fontSize: 30.0,
                      color: Color(0xFFEFEFEF),
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Positioned(
                  top: 0, // Adjust the top position as needed
                  left: 10,
                  right: 10,
                  child: Divider(
                    height: 1,

                    color: Color(0xFF002D75),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20.0),
            const Text(
              'Let\'s take care of your back!',
              style: TextStyle(
                fontSize: 18.0,
                color: Color(0xFFEFEFEF),
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.w500,
                letterSpacing: 1.0,
              ),
            ),
            const SizedBox(height: 7.0),
            ElevatedButton(
              onPressed: () {
                //run notifications
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.pinkAccent[700],
                foregroundColor: Colors.white,
                textStyle: const TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Montserrat',
                ),
              ),
              child: const Text(
                  'Start',
                style: TextStyle(
                  letterSpacing: 1.5,
                ),
              ),
            ),
            SizedBox(height: 130.0),
            // Upgrade to Pro button
            ElevatedButton(
              onPressed: () {
                // Navigate to Pro Features page
                Navigator.pushNamed(context, '/pro');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF4AFF2F),
                foregroundColor: Colors.pink[400],
                textStyle: const TextStyle(
                  fontSize: 19.0,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Montserrat',
                ),
              ),
              child: const Text('Upgrade to Pro!'),
            ),
            SizedBox(height: 20.0),

            // Navigation menu row
            Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  onPressed: () {
                    // Navigate to About page
                    Navigator.pushNamed(context, '/about');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.pinkAccent[700],
                    foregroundColor: Colors.white,
                    textStyle: const TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Montserrat',
                      letterSpacing: 1.5,
                    ),
                  ),
                  child: const Text('About'),
                ),

                ElevatedButton(
                  onPressed: () {
                    // Navigate to Settings page
                    Navigator.pushNamed(context, '/settings');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.pinkAccent[700],
                    foregroundColor: Colors.white,
                    textStyle: const TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Montserrat',
                      letterSpacing: 1.5,
                    ),
                  ),
                  child: const Text('Settings'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}



// import 'package:flutter/material.dart';
//
// class HomePage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Color(0xFF303132), // Set background color
//       body: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           // Logo image
//           Image.asset('assets/LogoBack2.jpg', width: 400),
//           SizedBox(height: 50.0),
//
//           // Some text
//           Padding(
//             padding: const EdgeInsets.fromLTRB(50.0, 10.0, 30.0, 10.0),
//             child: Text(
//               'BackPal: Your Back Deserves the Best!',
//               style: TextStyle(
//                 fontSize: 30.0,
//                 color: Color(0xFFEBCD9F),
//                 fontWeight: FontWeight.w500,
//                 //textAlign: TextAlign.center, // Align text to center
//               ),
//             ),
//           ),
//           SizedBox(height: 50.0),
//
//           // Upgrade to Pro button
//           ElevatedButton(
//             onPressed: () {
//               // Navigate to Pro Features page
//               Navigator.pushNamed(context, '/pro');
//             },
//             style: ElevatedButton.styleFrom(
//               primary: Colors.orangeAccent[700], // Button background color
//               onPrimary: Colors.white, // Button font color
//             ),
//             child: Text('Upgrade to Pro'),
//           ),
//           SizedBox(height: 50.0),
//
//           // Navigation menu row
//           Spacer(), // Push the row to the bottom
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceAround,
//             children: [
//               // About button
//               ElevatedButton(
//                 onPressed: () {
//                   // Navigate to About page
//                   Navigator.pushNamed(context, '/about');
//                 },
//                 style: ElevatedButton.styleFrom(
//                   primary: Colors.green, // Button background color
//                   onPrimary: Colors.white, // Button font color
//                 ),
//                 child: Text('About'),
//               ),
//
//               // Settings button
//               ElevatedButton(
//                 onPressed: () {
//                   // Navigate to Settings page
//                   Navigator.pushNamed(context, '/settings');
//                 },
//                 style: ElevatedButton.styleFrom(
//                   primary: Colors.blue, // Button background color
//                   onPrimary: Colors.white, // Button font color
//                 ),
//                 child: Text('Settings'),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }