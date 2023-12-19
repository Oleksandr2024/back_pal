import 'package:flutter/material.dart';
import 'package:back_pal/widgets/proPage_widgets/advantages_section.dart';
import 'package:back_pal/widgets/proPage_widgets/subscription_option.dart';
import 'package:back_pal/services/language_service.dart';

class ProFeaturesPage extends StatefulWidget {
  @override
  _ProFeaturesPageState createState() => _ProFeaturesPageState();
}

class _ProFeaturesPageState extends State<ProFeaturesPage> {
  bool isOption1Active = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[800],
        title: Text(
          LanguageService.getTranslation('app_pro_title') ?? 'Explore Pro Features',
          style: const TextStyle(
            fontSize: 26.0,
            fontFamily: 'Montserrat',
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Container(
        color: Colors.grey[850],
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              AdvantagesSection(),
              SizedBox(height: 30.0),
              Expanded(
                child: SubscriptionOption(
                  isActive: isOption1Active,
                  bannerText: '-75%',
                  subscriptionText: LanguageService.getTranslation('app_pro_oneMonth') ?? 'One month subscription',
                  oldPrice: '4 USD',
                  newPrice: (LanguageService.getTranslation('app_pro_only') ?? 'only') + ' 0.99 US\$',
                  onTap: () {
                    setState(() {
                      isOption1Active = !isOption1Active;
                    });
                  },
                ),
              ),
              SizedBox(height: 10.0),
              Expanded(
                child: SubscriptionOption(
                  isActive: !isOption1Active,
                  bannerText: '-89%',
                  subscriptionText: LanguageService.getTranslation('app_pro_oneYear') ?? 'One year subscription',
                  oldPrice: '48 USD',
                  newPrice: (LanguageService.getTranslation('app_pro_only') ?? 'only') + ' 4.99 US\$',
                  onTap: () {
                    setState(() {
                      isOption1Active = !isOption1Active;
                    });
                  },
                ),
              ),
              SizedBox(height: 30.0),
            ],
          ),
        ),
      ),
    );
  }
}

//
// import 'package:flutter/material.dart';
// import 'package:back_pal/widgets/proPage_widgets/advantages_section.dart';
// import 'package:back_pal/widgets/proPage_widgets/subscription_option.dart';
// import 'package:back_pal/services/language_service.dart';
//
// class ProFeaturesPage extends StatefulWidget {
//   @override
//   _ProFeaturesPageState createState() => _ProFeaturesPageState();
// }
//
// class _ProFeaturesPageState extends State<ProFeaturesPage> {
//   bool isOption1Active = true;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.grey[800],
//         title: Text(
//           //'Explore Pro Features',
//           LanguageService.getTranslation('app_pro_title') ?? 'Explore Pro Features',
//           style: const TextStyle(
//             fontSize: 26.0,
//             fontFamily: 'Montserrat',
//             color: Colors.white,
//           ),
//         ),
//         centerTitle: true,
//         iconTheme: IconThemeData(color: Colors.white),
//       ),
//       body: Container(
//         color: Colors.grey[850],
//         child: Padding(
//           padding: const EdgeInsets.all(10.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               AdvantagesSection(),
//               SizedBox(height: 30.0),
//               Expanded(
//                 child: SubscriptionOption(
//                   isActive: isOption1Active,
//                   bannerText: '-75%',
//                   subscriptionText: 'One month subscription',
//                   oldPrice: '4 USD',
//                   newPrice: 'only 0.99 US\$',
//                   onTap: () {
//                     setState(() {
//                       isOption1Active = !isOption1Active;
//                     });
//                   },
//                 ),
//               ),
//               SizedBox(height: 10.0),
//               Expanded(
//                 child: SubscriptionOption(
//                   isActive: !isOption1Active,
//                   bannerText: '-89%',
//                   subscriptionText: 'One year subscription',
//                   oldPrice: '48 USD',
//                   newPrice: 'only 4.99 US\$',
//                   onTap: () {
//                     setState(() {
//                       isOption1Active = !isOption1Active;
//                     });
//                   },
//                 ),
//               ),
//               SizedBox(height: 30.0),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
