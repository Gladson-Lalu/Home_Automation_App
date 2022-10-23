import 'package:flutter_blue/flutter_blue.dart';

class BluetoothDeviceModel {
  final String name;
  final String address;
  final BluetoothDevice device;

  const BluetoothDeviceModel(
      {required this.name,
      required this.address,
      required this.device});
}
