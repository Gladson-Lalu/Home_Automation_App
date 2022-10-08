import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../cubit/theme_mode/theme_mode_cubit.dart';

import 'dashboard_list_tile.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).backgroundColor,
      width: MediaQuery.of(context).size.width * .95,
      elevation: 10,
      child: Column(
        children: [
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(
                  top: 40, left: 26, right: 26, bottom: 20),
              child: Row(
                children: [
                  Text('Home Automation',
                      style: TextStyle(
                          color: Theme.of(context)
                              .textTheme
                              .bodyText1!
                              .color,
                          fontSize: 24,
                          fontWeight: FontWeight.w600)),
                  const Spacer(),
                  //change theme dark and light button
                  InkWell(
                      onTap: () {},
                      borderRadius:
                          BorderRadius.circular(30),
                      splashColor: Theme.of(context)
                          .textTheme
                          .labelMedium!
                          .color!
                          .withOpacity(0.2),
                      child: Padding(
                        padding: const EdgeInsets.only(
                            right: 10),
                        child: IconButton(
                            icon: BlocProvider.of<
                                                ThemeModeCubit>(
                                            context)
                                        .state
                                        .themeMode ==
                                    ThemeMode.light
                                ? Icon(
                                    Icons.nightlight_round,
                                    color: Theme.of(context)
                                        .textTheme
                                        .bodyText1!
                                        .color)
                                : Icon(Icons.wb_sunny,
                                    color: Theme.of(context)
                                        .textTheme
                                        .bodyText1!
                                        .color),
                            onPressed: () {
                              BlocProvider.of<
                                          ThemeModeCubit>(
                                      context)
                                  .toggleThemeMode();
                            }),
                      )),
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Icon(
                      Icons.close,
                      color: Theme.of(context)
                          .textTheme
                          .bodyText1!
                          .color,
                      size: 30,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(
                  horizontal: 26, vertical: 10),
              children: [
                DashboardListTile(
                  title: 'Devices',
                  onTap: () {},
                ),
                const SizedBox(height: 20),
                DashboardListTile(
                  title: 'Scenes',
                  onTap: () {},
                ),
                const SizedBox(height: 20),
                DashboardListTile(
                  title: 'Schedule',
                  onTap: () {},
                ),
                const SizedBox(height: 20),
                DashboardListTile(
                  title: 'Settings',
                  onTap: () {},
                ),
                const SizedBox(height: 20),
                DashboardListTile(
                  title: 'About',
                  onTap: () {},
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
