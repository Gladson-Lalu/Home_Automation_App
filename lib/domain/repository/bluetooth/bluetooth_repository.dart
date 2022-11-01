import '../../model/bluetooth_device.dart';

import '../../model/bluetooth_state.dart';

abstract class BluetoothRepository {
  Future<List<BluetoothDeviceModel>> get devices;
  Stream<BluetoothServiceState> get state;
  Stream<String> get readEvent;
  bool get isConnected;
  void connectToDevice(BluetoothDeviceModel device);
  void disconnect();
  void writeDeviceState(int deviceId, bool state);
  void isOn();
  void initDevices();
  Stream<String> get errorStream;
}
