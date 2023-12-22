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

  void _showProPurchaseDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('BackPal Pro'),
          content: Text(
            LanguageService.getTranslation('app_pro_temporaryNotification') ?? 'Pro purchases are temporarily unavailable.',
          style: TextStyle(
            fontSize: 20.0,
          ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text(
                  'OK',
              style: TextStyle(
                fontSize: 22.0,
              ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

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
              SizedBox(height: 20.0),
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
              SizedBox(height: 20.0),
              // ElevatedButton(
              //   onPressed: () => _showProPurchaseDialog(context),
              //   style: ElevatedButton.styleFrom(
              //     backgroundColor: Color(0xFF4AFF2F),
              //     foregroundColor: Colors.pink[400],
              //     textStyle: const TextStyle(
              //       fontSize: 19.0,
              //       fontWeight: FontWeight.bold,
              //       fontFamily: 'Montserrat',
              //     ),
              //   ),
              //   child: Text(
              //     // 'Upgrade to Pro!' app_pro_buy
              //     LanguageService.getTranslation('app_pro_buy') ?? 'Buy!',
              //   ),
              //
              // ),
              ElevatedButton(
                onPressed: () => _showProPurchaseDialog(context),
                style: ElevatedButton.styleFrom(
                  primary: Colors.red[700], // Change the background color to red
                  onPrimary: Colors.white, // Change the text color to white
                  textStyle: const TextStyle(
                    fontSize: 19.0,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Montserrat',
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0), // Add a slight corner radius
                  ),
                  elevation: 0, // Remove shadow if any
                ),
                child: Text(
                  LanguageService.getTranslation('app_pro_buy') ?? 'Buy!',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
