import 'dart:async';

import 'package:flutter_blue/flutter_blue.dart';
import 'package:home_automation/domain/model/bluetooth_device.dart';
import '../../service/bluetooth_service.dart';
import 'bluetooth_repository.dart';

import '../../model/bluetooth_state.dart';

class BluetoothRepositoryImpl extends BluetoothRepository {
  final FlutterBlueBluetoothService
      _flutterBlueBluetoothService;

  BluetoothRepositoryImpl(
      this._flutterBlueBluetoothService);

  @override
  void connectToDevice(BluetoothDeviceModel device) {
    return _flutterBlueBluetoothService
        .connectToDevice(device.device);
  }

  @override
  void disconnect() {
    return _flutterBlueBluetoothService.disconnect();
  }

  @override
  Stream<List<BluetoothDeviceModel>> get devices =>
      _flutterBlueBluetoothService.devices.transform(
          StreamTransformer.fromHandlers(
              handleData: (List<ScanResult> data, sink) {
        print('data: $data.toString()');
        sink.add(data
            .map((e) => BluetoothDeviceModel(
                name: e.advertisementData.localName,
                address: e.device.id.id,
                device: e.device))
            .toList());
      }));

  @override
  Stream<bool> get isScanning =>
      _flutterBlueBluetoothService.isScanning;

  @override
  Stream<BluetoothServiceState> get state =>
      _flutterBlueBluetoothService.state;

  @override
  void startScan() {
    return _flutterBlueBluetoothService.startScan();
  }

  @override
  void writeDeviceState(int deviceId, bool state) {
    return _flutterBlueBluetoothService
        .writeData('$deviceId:$state');
  }

  @override
  Stream<String> get readEvent =>
      _flutterBlueBluetoothService.readData;

  @override
  void isOn() {
    return _flutterBlueBluetoothService.isOn();
  }

  @override
  void stopScan() {
    return _flutterBlueBluetoothService.stopScan();
  }

  @override
  BluetoothDevice get device =>
      _flutterBlueBluetoothService.getDevice();
}
