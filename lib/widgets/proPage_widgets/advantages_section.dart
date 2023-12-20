import 'package:flutter/material.dart';
import 'package:back_pal/services/language_service.dart';

class AdvantagesSection extends StatelessWidget {
  AdvantagesSection({Key? key}) : super(key: key);

  // Retrieve translated strings dynamically
  List<String> getTranslatedAdvantages() {
    return [
      LanguageService.getTranslation('app_pro_adv1') ?? 'Disable ads',
      //LanguageService.getTranslation('app_pro_adv2') ?? 'Configure own settings',
      LanguageService.getTranslation('app_pro_adv3') ?? 'You can select your country',
      LanguageService.getTranslation('app_pro_adv4') ?? 'You can disable notifications on National Days and Holidays',
      LanguageService.getTranslation('app_pro_adv5') ?? 'Get further app improvements after BackPal updates',
    ];
  }

  @override
  Widget build(BuildContext context) {
    List<String> translatedAdvantages = getTranslatedAdvantages();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          LanguageService.getTranslation('app_pro_header') ?? 'Advantages of Pro Version',
          style: const TextStyle(
            fontSize: 20.0,
            fontFamily: 'Montserrat',
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 10.0),
        // Unordered List
        ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(), // Prevents the ListView from scrolling separately
          itemCount: translatedAdvantages.length,
          itemBuilder: (context, index) {
            return ListTile(
              contentPadding: EdgeInsets.fromLTRB(15, 0, 15, 0),
              leading: const Icon(
                Icons.fiber_manual_record,
                color: Colors.white,
                size: 10.0,
              ),
              title: Text(
                translatedAdvantages[index],
                style: const TextStyle(
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


// import 'package:flutter/material.dart';
// import 'package:back_pal/services/language_service.dart';
//
//
// class AdvantagesSection extends StatelessWidget {
//   final List<String> advantages = [
//     'Disable ads',
//     'Configure own settings',
//     'You can select your country',
//     'You can disable notifications on National Days and Holidays',
//     'Get further app improvements after BackPal updates',
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.center,
//       children: [
//         Text(
//           //'Advantages of Pro Version',
//           LanguageService.getTranslation('app_pro_header') ?? 'Advantages of Pro Version',
//           style: TextStyle(
//             fontSize: 20.0,
//             fontFamily: 'Montserrat',
//             fontWeight: FontWeight.bold,
//             color: Colors.white,
//           ),
//         ),
//         SizedBox(height: 1.0),
//         // Unordered List
//         ListView.builder(
//           shrinkWrap: true,
//           itemCount: advantages.length,
//           itemBuilder: (context, index) {
//             return ListTile(
//               contentPadding: EdgeInsets.fromLTRB(15, 0, 15, 0),
//               leading: Icon(
//                 Icons.fiber_manual_record,
//                 color: Colors.white,
//                 size: 10.0,
//               ),
//               title: Text(
//                 advantages[index],
//                 style: TextStyle(
//                   fontSize: 16.0,
//                   fontFamily: 'Montserrat',
//                   color: Colors.white,
//                 ),
//               ),
//             );
//           },
//         ),
//       ],
//     );
//   }
// }