import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:flutter/material.dart';
import 'package:home_automation/ui/home/widgets/app_bar/custom_sliver_appbar.dart';

import 'widgets/dashboard/custom_dashboard.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      //title: 'Home Automation' and weather widget in flexible space
      body: DoubleBackToCloseApp(
        snackBar: const SnackBar(
          content: Text('Tap back again to leave'),
        ),
        child: CustomScrollView(
          slivers: [
            //sized box for app bar
            const CustomSliverAppBar(),
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
                    Navigator.pushNamed(
                        context, '/settings');
                  },
                ),
              ]),
            )
          ],
        ),
      ),
      drawer: const CustomDashboard(),
    );
  }
}
