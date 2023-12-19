// import 'package:flutter/material.dart';
// import 'package:back_pal/services/language_service.dart';
// import 'package:back_pal/main.dart';
//
// class LanguageSelectionPage extends StatefulWidget {
//   @override
//   _LanguageSelectionPageState createState() => _LanguageSelectionPageState();
// }
//
// class _LanguageSelectionPageState extends State<LanguageSelectionPage> {
//   String selectedLanguage = 'English'; // Default language
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         //title: Text(translations['select_language'] ?? 'Select Language'), //Undefined name 'translations'.
//         title: Text(LanguageService.getTranslation('select_language') ?? 'Select Language'),
//
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             //Text(translations['select_language'] ?? 'Select your preferred language:'), //Undefined name 'translations'.
//             Text(LanguageService.getTranslation('select_language') ?? 'Select Language'),
//
//             SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: () async {
//                 await LanguageService.loadTranslations(Locale('en', 'US'));
//                 MyApp.setLocale(context, Locale('en', 'US'));
//               },
//               child: Text(LanguageService.getTranslation('english') ?? 'English'),
//             ),
//
//             ElevatedButton(
//               onPressed: () async {
//                 await LanguageService.loadTranslations(Locale('ua', 'UA'));
//                 MyApp.setLocale(context, Locale('ua', 'UA'));
//               },
//               child: Text(LanguageService.getTranslation('ukrainian') ?? 'Українська'),
//             ),
//             // Add more language buttons as needed
//           ],
//         ),
//       ),
//     );
//   }
// }