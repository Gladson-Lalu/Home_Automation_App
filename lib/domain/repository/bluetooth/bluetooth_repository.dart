import 'package:flutter_blue/flutter_blue.dart';
import 'package:home_automation/domain/model/bluetooth_device.dart';

import '../../model/bluetooth_state.dart';

abstract class BluetoothRepository {
  Stream<List<BluetoothDeviceModel>> get devices;
  Stream<bool> get isScanning;
  Stream<BluetoothServiceState> get state;
  Stream<String> get readEvent;
  void startScan();
  void stopScan();
  void connectToDevice(BluetoothDeviceModel device);
  void disconnect();
  void writeDeviceState(int deviceId, bool state);
  void isOn();
  BluetoothDevice get device;
}
