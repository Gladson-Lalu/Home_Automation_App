import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../cubit/bluetooth/bluetooth_cubit.dart';
import 'widgets/app_bar.dart';
import 'widgets/devices_list_view.dart';
import 'package:system_settings/system_settings.dart';

class BluetoothScreen extends StatelessWidget {
  const BluetoothScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const Duration duration = Duration(milliseconds: 500);
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: buildAppBar(context),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        color: Theme.of(context).backgroundColor,
        child: BlocConsumer<BluetoothCubit, BluetoothState>(
          listener: (context, state) {
            if (state is BluetoothError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.message)),
              );
            } else if (state is BluetoothConnecting) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                    content: Text('Connecting...'),
                    duration: duration),
              );
            } else if (state is BluetoothConnected) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                    content: Text('Connected'),
                    duration: duration),
              );
            } else if (state is BluetoothTurningOn) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                    content: Text('Turning on...'),
                    duration: duration),
              );
            } else if (state is BluetoothTurningOff) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                    content: Text('Turning off...'),
                    duration: duration),
              );
            } else if (state is BluetoothDisconnecting) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                    content: Text('Disconnecting...'),
                    duration: duration),
              );
            } else if (state is BluetoothDisconnected) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                    content: Text('Disconnected'),
                    duration: duration),
              );
            }
          },
          builder: (context, state) {
            if (state is BluetoothTurningOn ||
                state is BluetoothTurningOff) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is BluetoothOff) {
              return Center(
                child: Column(
                  mainAxisAlignment:
                      MainAxisAlignment.center,
                  crossAxisAlignment:
                      CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/icons/bluetooth_off.png',
                      width: 180,
                      height: 180,
                      fit: BoxFit.cover,
                      color: Theme.of(context)
                          .textTheme
                          .bodyText1!
                          .color!
                          .withOpacity(0.9),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      'Bluetooth is off',
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(
                          Theme.of(context).cardColor,
                        )),
                        onPressed: SystemSettings.bluetooth,
                        child: Text('Turn on Bluetooth',
                            style: TextStyle(
                                color: Theme.of(context)
                                    .textTheme
                                    .subtitle2!
                                    .color))),
                  ],
                ),
              );
            } else if (state is BluetoothUnavailable) {
              return Center(
                child: Column(
                  mainAxisAlignment:
                      MainAxisAlignment.center,
                  crossAxisAlignment:
                      CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/icons/bluetooth_unavailable.png',
                      width: 200,
                      height: 200,
                      fit: BoxFit.cover,
                      color: Theme.of(context)
                          .colorScheme
                          .secondary,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text('Bluetooth is unavailable'),
                  ],
                ),
              );
            } else if (state is BluetoothOn ||
                state is BluetoothDisconnected ||
                state is BluetoothConnecting ||
                state is BluetoothError) {
              return const BluetoothDeviceListBuilder();
            } else {
              return Center(
                child: Image.asset(
                  'assets/icons/bluetooth.png',
                  width: 200,
                  height: 200,
                  fit: BoxFit.cover,
                  color: Theme.of(context).focusColor,
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
