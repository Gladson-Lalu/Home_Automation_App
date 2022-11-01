import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../cubit/bluetooth/bluetooth_cubit.dart';

AppBar buildAppBar(BuildContext context) {
  return AppBar(
    centerTitle: true,
    iconTheme: IconThemeData(
        color:
            Theme.of(context).textTheme.bodyText1!.color),
    backgroundColor: Theme.of(context).backgroundColor,
    elevation: 0,
    title: BlocBuilder<BluetoothCubit, BluetoothState>(
        builder: (context, state) {
      if (state is BluetoothConnected) {
        return Text(
            'Connected to ${context.read<BluetoothCubit>().connectedDevice?.name ?? 'Controller'}',
            style: TextStyle(
                color: Theme.of(context)
                    .textTheme
                    .bodyText1!
                    .color,
                fontSize: 16,
                fontWeight: FontWeight.w600));
      } else if (state is BluetoothOff ||
          state is BluetoothError ||
          state is BluetoothInitial) {
        return Text('Bluetooth',
            style: TextStyle(
                color: Theme.of(context)
                    .textTheme
                    .bodyText1!
                    .color,
                fontSize: 16,
                fontWeight: FontWeight.w600));
      } else if (state is BluetoothTurningOff) {
        return Text('Bluetooth Turning Off',
            style: TextStyle(
                color: Theme.of(context)
                    .textTheme
                    .bodyText1!
                    .color,
                fontSize: 16,
                fontWeight: FontWeight.w600));
      } else if (state is BluetoothTurningOn) {
        return Text('Bluetooth Turning On',
            style: TextStyle(
                color: Theme.of(context)
                    .textTheme
                    .bodyText1!
                    .color,
                fontSize: 16,
                fontWeight: FontWeight.w600));
      } else if (state is BluetoothUnavailable) {
        return Text('Bluetooth Unavailable',
            style: TextStyle(
                color: Theme.of(context)
                    .textTheme
                    .bodyText1!
                    .color,
                fontSize: 16,
                fontWeight: FontWeight.w600));
      } else {
        return Text('Connect Device',
            style: TextStyle(
                color: Theme.of(context)
                    .textTheme
                    .bodyText1!
                    .color!
                    .withOpacity(0.8),
                fontSize: 16,
                fontWeight: FontWeight.w400));
      }
    }),
    actions: [
      BlocBuilder<BluetoothCubit, BluetoothState>(
        builder: (context, state) {
          if (state is BluetoothOn ||
              state is BluetoothDisconnected ||
              state is BluetoothError) {
            return StreamBuilder<bool>(
                stream:
                    BlocProvider.of<BluetoothCubit>(context)
                        .isScanning,
                builder: (context, snapshot) {
                  if (snapshot.hasData && snapshot.data!) {
                    return IconButton(
                      onPressed: null,
                      icon: Stack(
                        alignment: Alignment.center,
                        children: [
                          CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor:
                                AlwaysStoppedAnimation<
                                        Color>(
                                    Theme.of(context)
                                        .textTheme
                                        .bodyText1!
                                        .color!
                                        .withOpacity(0.8)),
                          ),
                          Icon(
                            Icons.bluetooth,
                            color: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .color!
                                .withOpacity(0.8),
                          ),
                        ],
                      ),
                    );
                  } else {
                    return IconButton(
                      onPressed: () {
                        BlocProvider.of<BluetoothCubit>(
                                context)
                            .getDevices();
                      },
                      icon: Icon(
                        Icons.bluetooth,
                        color: Theme.of(context)
                            .textTheme
                            .bodyText1!
                            .color!
                            .withOpacity(0.8),
                      ),
                    );
                  }
                });
          } else if (state is BluetoothConnected) {
            return TextButton(
              onPressed: (() {
                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        backgroundColor: Theme.of(context)
                            .backgroundColor,
                        title:
                            const Text('Disconnect Device'),
                        content: Text(
                            'Are you sure you want to disconnect from ${BlocProvider.of<BluetoothCubit>(context).connectedDevice?.name ?? 'Controller'}?',
                            style: TextStyle(
                                color: Theme.of(context)
                                    .textTheme
                                    .bodyText1!
                                    .color)),
                        actions: [
                          TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text('Cancel',
                                  style: TextStyle(
                                      color:
                                          Theme.of(context)
                                              .textTheme
                                              .bodyText1!
                                              .color))),
                          TextButton(
                              onPressed: () {
                                BlocProvider.of<
                                            BluetoothCubit>(
                                        context)
                                    .disconnect();
                                Navigator.pop(context);
                              },
                              child: Text('Disconnect',
                                  style: TextStyle(
                                      color:
                                          Theme.of(context)
                                              .textTheme
                                              .bodyText1!
                                              .color))),
                        ],
                      );
                    });
              }),
              child: Text('Disconnect',
                  style: TextStyle(
                      color: Theme.of(context)
                          .textTheme
                          .bodyText1!
                          .color!
                          .withRed(255))),
            );
          } else {
            return const SizedBox();
          }
        },
      )
    ],
  );
}
