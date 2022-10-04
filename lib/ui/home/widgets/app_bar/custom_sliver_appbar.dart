import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import 'weather_widget.dart';

class CustomSliverAppBar extends StatelessWidget {
  const CustomSliverAppBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      automaticallyImplyLeading: false,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(30),
        ),
      ),
      backgroundColor: Theme.of(context).cardColor,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('Welcome Home!',
              style: GoogleFonts.niconne(
                  color: Theme.of(context)
                      .textTheme
                      .labelMedium!
                      .color,
                  fontSize: 30,
                  fontWeight: FontWeight.w500)),
          InkWell(
            borderRadius: BorderRadius.circular(30),
            splashColor: Theme.of(context)
                .textTheme
                .labelMedium!
                .color!
                .withOpacity(0.2),
            onTap: () {
              Scaffold.of(context).openDrawer();
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SvgPicture.asset(
                  'assets/icons/menuAlt1.svg',
                  width: 30,
                  height: 30,
                  color: Theme.of(context).primaryColor),
            ),
          ),
        ],
      ),
      flexibleSpace: const FlexibleSpaceBar(
        background: WeatherWidget(),
      ),
      expandedHeight:
          MediaQuery.of(context).size.height * 0.45,
    );
  }
}
