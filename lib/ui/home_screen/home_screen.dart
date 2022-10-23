import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubit/electronic_devices/home/home_electronic_devices_cubit.dart';
import '../../cubit/voice/voice_cubit.dart';
import '../../domain/model/device.dart';
import '../home/widgets/app_bar/custom_sliver_appbar.dart';
import 'widgets/drawer/custom_drawer.dart';
import 'widgets/modal_bottom_sheet/modal_bottom_sheet.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late int selectedRoomIndex;
  @override
  void initState() {
    super.initState();
    BlocProvider.of<HomeElectronicDevicesCubit>(context)
        .getConnectedDevices();
    selectedRoomIndex = 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonAnimator:
          FloatingActionButtonAnimator.scaling,
      floatingActionButtonLocation:
          FloatingActionButtonLocation.centerDocked,
      //voice assistant button at bottom center
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 10),
        //voice assistant button
        child: FloatingActionButton(
          elevation: 10,
          onPressed: () {
            BlocProvider.of<VoiceCubit>(context)
                .startListening();
            //show voice assistant in bottom sheet

            showModalBottomSheet(
                isDismissible: false,
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20))),
                backgroundColor:
                    Theme.of(context).backgroundColor,
                context: context,
                builder: (ctx) {
                  return const VoiceBottomSheet();
                });
          },
          backgroundColor:
              Theme.of(context).backgroundColor,
          child: Icon(Icons.mic,
              color: Theme.of(context).focusColor),
        ),
      ),
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
            //sized box
            const SliverToBoxAdapter(
              child: SizedBox(height: 30),
            ),
            BlocConsumer<HomeElectronicDevicesCubit,
                HomeElectronicDevicesState>(
              listener: (context, state) {
                if (state is HomeElectronicDevicesError) {
                  ScaffoldMessenger.of(context)
                      .showSnackBar(
                    SnackBar(
                      content: Text(state.message),
                    ),
                  );
                }
              },
              builder: (context, state) {
                if (state is HomeElectronicDevicesLoaded) {
                  return buildRoomHeader(state.roomDevices);
                } else {
                  return const SliverToBoxAdapter();
                }
              },
            ),
            const SliverToBoxAdapter(
              child: SizedBox(height: 30),
            ),
            //smart devices
            BlocBuilder<HomeElectronicDevicesCubit,
                HomeElectronicDevicesState>(
              builder: (context, state) {
                if (state is HomeElectronicDevicesLoaded) {
                  return SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Text(
                        'Smart Devices',
                        style: Theme.of(context)
                            .textTheme
                            .headline6,
                      ),
                    ),
                  );
                } else {
                  return const SliverToBoxAdapter();
                }
              },
            ),
            //list of devices
            BlocBuilder<HomeElectronicDevicesCubit,
                HomeElectronicDevicesState>(
              builder: (context, state) {
                if (state is HomeElectronicDevicesLoaded) {
                  return SliverPadding(
                    padding: EdgeInsets.symmetric(
                        horizontal: MediaQuery.of(context)
                                .size
                                .width *
                            0.03,
                        vertical: 10),
                    sliver:
                        buildGridList(state.roomDevices),
                  );
                } else if (state
                    is HomeElectronicDevicesInitial) {
                  return SliverToBoxAdapter(
                    child: Center(
                      child: Text(
                        'No devices found',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 20,
                          color: Theme.of(context)
                              .textTheme
                              .bodyText1!
                              .color,
                        ),
                      ),
                    ),
                  );
                } else {
                  return const SliverToBoxAdapter(
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                }
              },
            ),
            //Sized box
            const SliverToBoxAdapter(
              child: SizedBox(height: 20),
            ),
          ],
        ),
      ),
      drawer: const CustomDrawer(),
    );
  }

  SliverGrid buildGridList(
      List<List<ElectronicDevice>> devices) {
    return SliverGrid(
      gridDelegate:
          const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 20,
        crossAxisSpacing: 20,
        childAspectRatio: 1.3,
      ),
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          return buildDeviceCard(
              context, devices[selectedRoomIndex][index]);
        },
        childCount: devices[selectedRoomIndex].length,
      ),
    );
  }

  SliverToBoxAdapter buildRoomHeader(
    List<List<ElectronicDevice>> roomDevices,
  ) {
    return SliverToBoxAdapter(
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.03,
        child: ListView.builder(
          padding:
              const EdgeInsets.symmetric(horizontal: 10),
          scrollDirection: Axis.horizontal,
          itemCount: roomDevices.length,
          itemBuilder: (context, index) {
            return InkWell(
              splashColor: Colors.transparent,
              onTap: () {
                setState(() {
                  selectedRoomIndex = index;
                });
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 150),
                margin: const EdgeInsets.symmetric(
                    horizontal: 5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: selectedRoomIndex == index
                        ? Theme.of(context).focusColor
                        : Theme.of(context).backgroundColor,
                    width: 2,
                  ),
                ),
                padding: const EdgeInsets.symmetric(
                    horizontal: 10, vertical: 0),
                child: Center(
                  child: Text(roomDevices[index][0].room,
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1!
                          .copyWith(
                              fontSize: 15,
                              fontWeight: FontWeight.w500)),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget buildDeviceCard(
      BuildContext context, ElectronicDevice device) {
    return Container(
      padding: const EdgeInsets.only(
          left: 15, right: 0, top: 20, bottom: 5),
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        borderRadius:
            const BorderRadius.all(Radius.circular(16)),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context)
                .shadowColor
                .withOpacity(0.4),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment:
                MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(
                'assets/icons/device/${device.icon}.png',
                height: 52,
                width: 52,
                color: Theme.of(context).focusColor,
                fit: BoxFit.cover,
              ),
              Switch(
                inactiveTrackColor: Colors.grey,
                inactiveThumbColor: Colors.white,
                value: device.state,
                onChanged: (value) {
                  BlocProvider.of<
                              HomeElectronicDevicesCubit>(
                          context)
                      .changeState(device.id, value);
                },
                activeColor: Theme.of(context).focusColor,
              ),
            ],
          ),
          const SizedBox(height: 20),
          Text(
            device.name,
            style: TextStyle(
              color: Theme.of(context)
                  .textTheme
                  .bodyText1!
                  .color,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 5),
        ],
      ),
    );
  }
}
