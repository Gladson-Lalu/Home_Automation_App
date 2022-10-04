import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'widgets/weather_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      //title: 'Home Automation' and weather widget in flexible space
      body: CustomScrollView(
        slivers: [
          //sized box for app bar

          SliverAppBar(
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(30),
              ),
            ),
            backgroundColor: Theme.of(context).cardColor,
            title: Row(
              mainAxisAlignment:
                  MainAxisAlignment.spaceBetween,
              children: [
                Text('Welcome Home!',
                    style: GoogleFonts.niconne(
                        color: Theme.of(context)
                            .textTheme
                            .labelMedium!
                            .color,
                        fontSize: 30,
                        fontWeight: FontWeight.w500)),
                Icon(Icons.settings,
                    color: Theme.of(context).primaryColor),
              ],
            ),
            flexibleSpace: const FlexibleSpaceBar(
              background: WeatherWidget(),
            ),
            expandedHeight: 400,
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              ListTile(
                title: Text('Settings',
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 22,
                        color: Theme.of(context)
                            .textTheme
                            .bodyText1!
                            .color)),
                trailing: const Icon(Icons.settings),
                onTap: () {
                  Navigator.pushNamed(context, '/settings');
                },
              ),
            ]),
          )
        ],
      ),
    );
  }
}
