import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //SliverAppBar with title and wheather widget
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            title: Text('Home Automation'),
            actions: [
              Container(
                margin: const EdgeInsets.all(8),
                child: Row(
                  children: [
                    Icon(Icons.wb_sunny),
                    Text('32°'),
                  ],
                ),
              ),
            ],
          ),
          //SliverList with all the widgets
          SliverList(
            delegate: SliverChildListDelegate(
              [
                //Lighting widget
                Container(
                  margin: const EdgeInsets.all(8),
                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Lighting',
                        style: Theme.of(context)
                            .textTheme
                            .headline6,
                      ),
                      const SizedBox(height: 8),
                      Container(
                        height: 100,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: [
                            Container(
                              width: 100,
                              margin: const EdgeInsets.only(
                                  right: 8),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    BorderRadius.circular(
                                        8),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey
                                        .withOpacity(0.5),
                                    spreadRadius: 1,
                                    blurRadius: 7,
                                    offset:
                                        const Offset(0, 3),
                                  ),
                                ],
                              ),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment
                                        .center,
                                children: [
                                  Icon(Icons
                                      .lightbulb_outline),
                                  const SizedBox(height: 8),
                                  Text('Living Room'),
                                ],
                              ),
                            ),
                            Container(
                              width: 100,
                              margin: const EdgeInsets.only(
                                  right: 8),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    BorderRadius.circular(
                                        8),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey
                                        .withOpacity(0.5),
                                    spreadRadius: 1,
                                    blurRadius: 7,
                                    offset:
                                        const Offset(0, 3),
                                  ),
                                ],
                              ),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment
                                        .center,
                                children: [
                                  Icon(Icons
                                      .lightbulb_outline),
                                  const SizedBox(height: 8),
                                  Text('Bedroom'),
                                ],
                              ),
                            ),
                            Container(
                              width: 100,
                              margin: const EdgeInsets.only(
                                  right: 8),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    BorderRadius.circular(
                                        8),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey,
                                    spreadRadius: 1,
                                    blurRadius: 7,
                                    offset:
                                        const Offset(0, 3),
                                  ),
                                ],
                              ),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment
                                        .center,
                                children: [
                                  Icon(Icons
                                      .lightbulb_outline),
                                  const SizedBox(height: 8),
                                  Text('Kitchen'),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                //Security widget

                //Appliances widget

                //Temperature widget

                //Humidity widget

                //Air Quality widget

                //Energy widget
              ],
            ),
          ),
        ],
      ),
    );
  }
}
