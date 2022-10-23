import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../cubit/bluetooth/bluetooth_cubit.dart';
import '../../../domain/model/bluetooth_device.dart';

class BluetoothDeviceListBuilder extends StatelessWidget {
  const BluetoothDeviceListBuilder({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<BluetoothDeviceModel>>(
      stream:
          BlocProvider.of<BluetoothCubit>(context).devices,
      builder: (context, snapshot) {
        if (snapshot.hasData &&
            snapshot.data != null &&
            snapshot.data!.isNotEmpty) {
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              return ListTile(
                onTap: () {
                  BlocProvider.of<BluetoothCubit>(context)
                      .connectToDevice(
                          snapshot.data![index]);
                },
                title: Text(
                  snapshot.data![index].name,
                  style: TextStyle(
                      color: Theme.of(context)
                          .textTheme
                          .bodyText1!
                          .color),
                ),
                subtitle: Text(
                    snapshot.data![index].address,
                    style: TextStyle(
                        color: Theme.of(context)
                            .textTheme
                            .bodyText1!
                            .color)),
              );
            },
          );
        } else {
          return Center(
            child: Wrap(
              alignment: WrapAlignment.center,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                Text('No device found',
                    style: TextStyle(
                      fontSize: 20,
                      color: Theme.of(context)
                          .textTheme
                          .bodyText1!
                          .color,
                    )),
                const SizedBox(height: 10),
                const Text(
                    'Make sure your device is on and discoverable'),
                const SizedBox(height: 40),
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(
                            Theme.of(context).cardColor),
                  ),
                  onPressed: () {
                    BlocProvider.of<BluetoothCubit>(context)
                        .startScanning();
                  },
                  child: Text(
                    'Scan again',
                    style: TextStyle(
                      color: Theme.of(context)
                          .textTheme
                          .subtitle2!
                          .color,
                    ),
                  ),
                ),
              ],
            ),
          );
        }
      },
    );
  }
}
