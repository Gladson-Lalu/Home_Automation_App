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
    return FutureBuilder<List<BluetoothDeviceModel>>(
      future: BlocProvider.of<BluetoothCubit>(context)
          .getDevices(),
      builder: (context, snapshot) {
        if (snapshot.hasData &&
            snapshot.data != null &&
            snapshot.data!.isNotEmpty) {
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              return Container(
                margin: const EdgeInsets.symmetric(
                    horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  color: snapshot.data![index].isConnectable
                      ? Theme.of(context)
                          .cardColor
                          .withAlpha(60)
                      : Theme.of(context)
                          .cardColor
                          .withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      spreadRadius: 1,
                      blurRadius: 10,
                      offset: const Offset(0, 1),
                    ),
                  ],
                ),
                child: ListTile(
                  enabled:
                      snapshot.data![index].isConnectable,
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
                ),
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
                        .getDevices();
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
