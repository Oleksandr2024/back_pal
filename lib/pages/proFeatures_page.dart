import 'package:flutter/material.dart';
import 'package:back_pal/widgets/proPage_widgets/advantages_section.dart';
import 'package:back_pal/widgets/proPage_widgets/subscription_option.dart';

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
          'Explore Pro Features',
          style: TextStyle(
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
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              AdvantagesSection(),
              SizedBox(height: 40.0),
              Expanded(
              // final bool isActive;
              // final String bannerText;
              // final String subscriptionText;
              // final String oldPrice;
              // final String newPrice;
              // final VoidCallback onTap;
                child: SubscriptionOption(
                  isActive: isOption1Active,
                  bannerText: '-75%',
                  subscriptionText: 'One month subscription',
                  oldPrice: '4 USD',
                  newPrice: 'only 0.99 US\$',
                  onTap: () {
                    setState(() {
                      isOption1Active = !isOption1Active;
                    });
                  },
                ),
              ),
              SizedBox(height: 20.0),
              Expanded(
                child: SubscriptionOption(
                  isActive: !isOption1Active,
                  bannerText: '-89%',
                  subscriptionText: 'One year subscription',
                  oldPrice: '48 USD',
                  newPrice: 'only 4.99 US\$',
                  onTap: () {
                    setState(() {
                      isOption1Active = !isOption1Active;
                    });
                  },
                ),
              ),
              SizedBox(height: 40.0),
            ],
          ),
        ),
      ),
    );
  }
}
