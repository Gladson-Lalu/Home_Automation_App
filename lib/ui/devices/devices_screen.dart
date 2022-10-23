import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/model/device.dart';
import 'widgets/build_edit_device_dialog.dart';

import '../../cubit/electronic_devices/devices/devices_electronic_devices_cubit.dart';

class DevicesScreen extends StatefulWidget {
  const DevicesScreen({super.key});

  @override
  State<DevicesScreen> createState() =>
      _DevicesScreenState();
}

class _DevicesScreenState extends State<DevicesScreen> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<DevicesElectronicDevicesCubit>(context)
        .getAllDevices();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).backgroundColor,
        iconTheme: IconThemeData(
            color: Theme.of(context)
                .textTheme
                .bodyText1!
                .color),
        centerTitle: true,
        title: Text('Devices',
            style: TextStyle(
                color: Theme.of(context)
                    .textTheme
                    .bodyText1!
                    .color,
                fontSize: 20,
                fontWeight: FontWeight.w600)),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(
            horizontal: 26, vertical: 10),
        child: BlocConsumer<DevicesElectronicDevicesCubit,
            DevicesElectronicDevicesState>(
          listener: (context, state) {
            if (state is DevicesElectronicDevicesError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                ),
              );
            }
          },
          builder: ((context, state) {
            if (state is DevicesElectronicDevicesLoaded) {
              final List<List<ElectronicDevice>>
                  sampleDevices = state.devices;
              return ListView.builder(
                itemBuilder: ((context, roomIndex) {
                  return Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 20),
                        child: Text(
                            sampleDevices[roomIndex][0]
                                .room,
                            style: TextStyle(
                                color: Theme.of(context)
                                    .textTheme
                                    .bodyText1!
                                    .color,
                                fontSize: 20,
                                fontWeight:
                                    FontWeight.w600)),
                      ),
                      ListView.builder(
                        itemBuilder: ((context, index) {
                          final ElectronicDevice device =
                              sampleDevices[roomIndex]
                                  [index];
                          return Container(
                            padding:
                                const EdgeInsets.symmetric(
                                    vertical: 5),
                            margin: const EdgeInsets.only(
                                bottom: 20),
                            decoration: BoxDecoration(
                                color: Theme.of(context)
                                    .primaryColor,
                                borderRadius:
                                    BorderRadius.circular(
                                        10),
                                boxShadow: [
                                  BoxShadow(
                                      color: !device
                                              .isConnected
                                          ? Colors.red
                                              .withOpacity(
                                                  0.5)
                                          : device.state
                                              ? Theme.of(
                                                      context)
                                                  .focusColor
                                                  .withOpacity(
                                                      0.4)
                                              : Theme.of(
                                                      context)
                                                  .shadowColor
                                                  .withOpacity(
                                                      0.4),
                                      blurRadius: 5,
                                      spreadRadius: 0.1)
                                ]),
                            child: ListTile(
                              leading: Image.asset(
                                  'assets/icons/device/${device.icon}.png',
                                  width: 40,
                                  height: 40,
                                  color: device.state
                                      ? Theme.of(context)
                                          .focusColor
                                          .withOpacity(0.8)
                                      : Theme.of(context)
                                          .shadowColor
                                          .withOpacity(
                                              0.8)),
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.circular(
                                          10)),
                              tileColor: Theme.of(context)
                                  .primaryColor,
                              title: Text(device.name,
                                  style: TextStyle(
                                      color:
                                          Theme.of(context)
                                              .textTheme
                                              .bodyText1!
                                              .color,
                                      fontSize: 16,
                                      fontWeight:
                                          FontWeight.w400)),
                              trailing: SizedBox(
                                child: Wrap(
                                  direction:
                                      Axis.horizontal,
                                  runSpacing: 1,
                                  alignment:
                                      WrapAlignment.end,
                                  spacing: 1,
                                  children: [
                                    IconButton(
                                      icon: Icon(
                                          device.state
                                              ? Icons
                                                  .toggle_on_outlined
                                              : Icons
                                                  .toggle_off_outlined,
                                          color: sampleDevices[
                                                          roomIndex]
                                                      [
                                                      index]
                                                  .state
                                              ? Theme.of(
                                                      context)
                                                  .focusColor
                                                  .withOpacity(
                                                      0.8)
                                              : Theme.of(
                                                      context)
                                                  .shadowColor
                                                  .withOpacity(
                                                      0.8),
                                          size: 30),
                                      onPressed: () {
                                        (device.isConnected)
                                            ? BlocProvider.of<
                                                        DevicesElectronicDevicesCubit>(
                                                    context)
                                                .changeDeviceState(
                                                    device
                                                        .id,
                                                    !device
                                                        .state)
                                            : ScaffoldMessenger.of(
                                                    context)
                                                .showSnackBar(
                                                const SnackBar(
                                                  duration: Duration(
                                                      milliseconds:
                                                          500),
                                                  content: Text(
                                                      'Device is not connected'),
                                                ),
                                              );
                                      },
                                    ),
                                    //edit button
                                    IconButton(
                                      onPressed: () {
                                        buildDialogBox(
                                            context,
                                            getRoomNames(
                                                sampleDevices),
                                            sampleDevices[
                                                    roomIndex]
                                                [index]);
                                      },
                                      icon: Icon(Icons.edit,
                                          color: Theme.of(
                                                  context)
                                              .focusColor,
                                          size: 24),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          );
                        }),
                        itemCount:
                            sampleDevices[roomIndex].length,
                        shrinkWrap: true,
                        physics:
                            const NeverScrollableScrollPhysics(),
                      )
                    ],
                  );
                }),
                itemCount: sampleDevices.length,
                shrinkWrap: true,
                physics:
                    const NeverScrollableScrollPhysics(),
              );
            } else if (state
                is DevicesElectronicDevicesInitial) {
              return const Center(
                child: Text('No devices found'),
              );
            } else if (state
                is DevicesElectronicDevicesLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return const Center(
                child: Text('Something went wrong'),
              );
            }
          }),
        ),
      ),
    );
  }

  List<String> getRoomNames(
      List<List<ElectronicDevice>> sampleDevices) {
    List<String> roomNames = [];
    for (var e in sampleDevices) {
      roomNames.add(e[0].room);
    }
    return roomNames;
  }
}
