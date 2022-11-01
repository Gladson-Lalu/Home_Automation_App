import 'dart:async';

import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import '../../model/bluetooth_device.dart';
import '../../service/bluetooth_serial_service.dart';
import 'bluetooth_repository.dart';

import '../../model/bluetooth_state.dart';

class BluetoothRepositoryImpl extends BluetoothRepository {
  final BluetoothSerialService _bluetoothSerialService;
  BluetoothRepositoryImpl(
    this._bluetoothSerialService,
  ) {
    _bluetoothSerialService.init();
  }

  @override
  void connectToDevice(BluetoothDeviceModel device) {
    _bluetoothSerialService.connectToDevice(device.address);
  }

  @override
  void disconnect() {
    _bluetoothSerialService.disconnect();
  }

  @override
  Future<List<BluetoothDeviceModel>> get devices async {
    final List<BluetoothDevice> devices =
        await _bluetoothSerialService.devices;
    return devices
        .map((BluetoothDevice e) => BluetoothDeviceModel(
              name: e.name ?? "Unknown",
              address: e.address,
              isConnectable: e.isBonded,
            ))
        .toList();
  }

  @override
  Stream<BluetoothServiceState> get state =>
      _bluetoothSerialService.state;

  @override
  void writeDeviceState(int deviceId, bool state) {
    _bluetoothSerialService
        .writeData('$deviceId:${state ? 1 : 0}');
  }

  @override
  void isOn() {
    _bluetoothSerialService.isOn();
  }

  @override
  void initDevices() {
    _bluetoothSerialService.writeData('init');
  }

  @override
  Stream<String> get readEvent =>
      _bluetoothSerialService.readData;

  @override
  bool get isConnected =>
      _bluetoothSerialService.isConnected;

  @override
  Stream<String> get errorStream =>
      _bluetoothSerialService.errorStream;
}
