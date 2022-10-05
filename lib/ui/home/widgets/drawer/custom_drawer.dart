import 'package:flutter/material.dart';

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
