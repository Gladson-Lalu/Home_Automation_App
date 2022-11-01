import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../cubit/bluetooth/bluetooth_cubit.dart';
import '../../../bluetooth/bluetooth_screen.dart';

import 'weather_widget.dart';

class CustomSliverAppBar extends StatelessWidget {
  const CustomSliverAppBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      pinned: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(10),
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
          Row(
            children: [
              IconButton(onPressed: () {
                Navigator.push(
                    context,
                    PageRouteBuilder(
                        pageBuilder: (context, animation,
                                secondaryAnimation) =>
                            const BluetoothScreen(),
                        transitionsBuilder: (context,
                            animation,
                            secondaryAnimation,
                            child) {
                          return FadeTransition(
                              opacity: animation,
                              child: child);
                        }));
              }, icon: BlocBuilder<BluetoothCubit,
                      BluetoothState>(
                  builder: (context, state) {
                if (state is BluetoothConnected) {
                  return Icon(
                    Icons.bluetooth_connected,
                    color: Theme.of(context)
                        .textTheme
                        .labelMedium!
                        .color,
                  );
                } else if (state is BluetoothDisconnected) {
                  return Icon(
                    Icons.bluetooth_disabled,
                    color: Theme.of(context)
                        .textTheme
                        .labelMedium!
                        .color,
                  );
                } else if (state is BluetoothConnecting) {
                  return Icon(
                    Icons.bluetooth_searching,
                    color: Theme.of(context)
                        .textTheme
                        .labelMedium!
                        .color,
                  );
                } else if (state is BluetoothUnavailable) {
                  return Icon(
                    Icons.bluetooth_disabled,
                    color: Theme.of(context)
                        .textTheme
                        .labelMedium!
                        .color!
                        .withOpacity(0.5),
                  );
                } else {
                  return Icon(
                    Icons.bluetooth,
                    color: Theme.of(context)
                        .textTheme
                        .labelMedium!
                        .color,
                  );
                }
              })),
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
                      color: Theme.of(context)
                          .textTheme
                          .labelMedium!
                          .color),
                ),
              ),
            ],
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
