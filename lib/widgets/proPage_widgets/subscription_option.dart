import 'package:flutter/material.dart';

class SubscriptionOption extends StatefulWidget {
  final bool isActive;
  final String bannerText;
  final String subscriptionText;
  final String oldPrice;
  final String newPrice;
  final VoidCallback onTap;

  SubscriptionOption({
    required this.isActive,
    required this.bannerText,
    required this.subscriptionText,
    required this.oldPrice,
    required this.newPrice,
    required this.onTap,
  });

  @override
  _SubscriptionOptionState createState() => _SubscriptionOptionState();
}

class _SubscriptionOptionState extends State<SubscriptionOption> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        width: 250.0,
        margin: EdgeInsets.symmetric(vertical: 10.0),
        decoration: BoxDecoration(
          color: widget.isActive ? Colors.deepPurple[900] : Colors.grey[800],
          border: widget.isActive
              ? Border.all(
            width: 1.0,
            color: Colors.white,
          )
              : null,
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Stack(
          children: [
            // Banner
            Positioned(
              left: 10.0,
              top: 10.0,
              child: Container(
                width: 45.0,
                height: 25.0,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(5.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Center(
                    child: Text(
                      widget.bannerText,
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Montserrat',
                      ),
                    ),
                  ),
                ),
              ),
            ),
            // Text
            Center(
              child: Text(
                widget.subscriptionText,
                style: TextStyle(
                  fontSize: 18.0,
                  fontFamily: 'Montserrat',
                  color: Colors.white,
                ),
              ),
            ),
            // Old Price
            Positioned(
              bottom: 10.0,
              left: 10.0,
              child: Text(
                widget.oldPrice,
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.white,
                  fontFamily: 'Montserrat',
                  decoration: TextDecoration.lineThrough,
                  decorationColor: Colors.white,
                ),
              ),
            ),
            // New Price
            Positioned(
              bottom: 10.0,
              right: 10.0,
              child: Text(
                widget.newPrice,
                style: TextStyle(
                  fontSize: 16.0,
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            // Mark
            if (widget.isActive)
              Positioned(
                top: 5.0,
                right: 5.0,
                child: Icon(
                  Icons.check,
                  color: Colors.white,
                ),
              ),
          ],
        ),
      ),
    );
  }
}





// import 'package:flutter/material.dart';
//
// class SubscriptionOption extends StatefulWidget {
//   bool isActive;
//   VoidCallback onTap;
//
//   SubscriptionOption({required this.isActive, required this.onTap});
//
//   @override
//   _SubscriptionOptionState createState() => _SubscriptionOptionState();
// }
//
// class _SubscriptionOptionState extends State<SubscriptionOption> {
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: widget.onTap,
//       child: Container(
//         width: 250.0,
//         margin: EdgeInsets.symmetric(vertical: 10.0),
//         decoration: BoxDecoration(
//           color: widget.isActive ? Colors.deepPurple[900] : Colors.grey[800],
//           border: widget.isActive
//               ? Border.all(
//             width: 1.0,
//             color: Colors.white,
//           )
//               : null,
//           borderRadius: BorderRadius.circular(10.0),
//         ),
//         child: Stack(
//           children: [
//             // Banner
//             Positioned(
//               left: 10.0,
//               top: 10.0,
//               child: Container(
//                 width: 45.0,
//                 height: 25.0,
//                 decoration: BoxDecoration(
//                   color: Colors.blue,
//                   borderRadius: BorderRadius.circular(5.0),
//                 ),
//                 child: Padding(
//                   padding: const EdgeInsets.all(2.0),
//                   child: Center(
//                     child: Text(
//                       widget.isActive ? "-75%" : "-89%",
//                       style: TextStyle(
//                         color: Colors.white,
//                         fontFamily: 'Montserrat',
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//             // Text
//             Center(
//               child: Text(
//                 widget.isActive
//                     ? "One month subscription"
//                     : "One year subscription",
//                 style: TextStyle(
//                   fontSize: 18.0,
//                   fontFamily: 'Montserrat',
//                   color: Colors.white,
//                 ),
//               ),
//             ),
//             // Old Price
//             Positioned(
//               bottom: 10.0,
//               left: 10.0,
//               child: Text(
//                 widget.isActive ? "4 USD" : "48 USD",
//                 style: TextStyle(
//                   fontSize: 16.0,
//                   color: Colors.white,
//                   fontFamily: 'Montserrat',
//                   decoration: TextDecoration.lineThrough,
//                   decorationColor: Colors.white,
//                 ),
//               ),
//             ),
//             // New Price
//             Positioned(
//               bottom: 10.0,
//               right: 10.0,
//               child: Text(
//                 widget.isActive ? "only 0.99 US\$" : "only 4.99 US\$",
//                 style: TextStyle(
//                   fontSize: 16.0,
//                   fontFamily: 'Montserrat',
//                   fontWeight: FontWeight.bold,
//                   color: Colors.white,
//                 ),
//               ),
//             ),
//             // Mark
//             if (widget.isActive)
//               Positioned(
//                 top: 5.0,
//                 right: 5.0,
//                 child: Icon(
//                   Icons.check,
//                   color: Colors.white,
//                 ),
//               ),
//           ],
//         ),
//       ),
//     );
//   }
// }


