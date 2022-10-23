import 'dart:async';
import 'dart:convert';

import 'package:flutter_blue/flutter_blue.dart';
import '../model/bluetooth_state.dart';

class FlutterBlueBluetoothService {
  final FlutterBlue _flutterBlue = FlutterBlue.instance;
  BluetoothDevice? _device;

  final StreamController<List<ScanResult>>
      _devicesController =
      StreamController<List<ScanResult>>.broadcast();
  final StreamController<BluetoothServiceState>
      _stateController =
      StreamController<BluetoothServiceState>.broadcast();
  final StreamController<String> _readDataController =
      StreamController<String>();

  Stream<List<ScanResult>> get devices =>
      _devicesController.stream;
  Stream<String> get readData => _readDataController.stream;
  Stream<BluetoothServiceState> get state =>
      _stateController.stream;
  Stream<bool> get isScanning => _flutterBlue.isScanning;

  FlutterBlueBluetoothService() {
    _flutterBlue.state.listen((state) {
      switch (state) {
        case BluetoothState.on:
          _stateController.add(BluetoothServiceState.on);
          break;
        case BluetoothState.off:
          _stateController.add(BluetoothServiceState.off);
          break;
        case BluetoothState.turningOn:
          _stateController
              .add(BluetoothServiceState.turningOn);
          break;
        case BluetoothState.turningOff:
          _stateController
              .add(BluetoothServiceState.turningOff);
          break;
        default:
          _stateController
              .add(BluetoothServiceState.unavailable);
      }
    });

    _flutterBlue.scanResults.listen((results) {
      _devicesController.add(results);
    });
  }

  void startScan() async {
    try {
      if (await _flutterBlue.isAvailable) {
        _flutterBlue.startScan(
            timeout: const Duration(seconds: 4));
      }
    } catch (_) {
      throw Exception("Scan failed");
    }
  }

  void connectToDevice(BluetoothDevice device) async {
    try {
      if (await _flutterBlue.isAvailable) {
        _flutterBlue.stopScan();
        if (_device != null) {
          _device!.disconnect();
        }
        _device = device;
        _device!.state.listen((event) {
          print(event);
          if (event == BluetoothDeviceState.disconnected) {
            _stateController
                .add(BluetoothServiceState.disconnected);
          } else if (event ==
              BluetoothDeviceState.connected) {
            _stateController
                .add(BluetoothServiceState.connected);
          } else if (event ==
              BluetoothDeviceState.connecting) {
            _stateController
                .add(BluetoothServiceState.connecting);
          } else if (event ==
              BluetoothDeviceState.disconnecting) {
            _stateController
                .add(BluetoothServiceState.disconnecting);
          }
        });
        _device!.connect(autoConnect: true).then((value) {
          _device!.discoverServices().then((value) {
            print(value);
            for (var element in value[0].characteristics) {
              print(element);
              element.setNotifyValue(true);
              element.value.listen((event) {
                _readDataController.add(utf8.decode(event));
              });
            }
          });
        });
      }
    } catch (_) {
      throw Exception("Error connecting to device");
    }
  }

  void disconnect() {
    try {
      if (_device != null) {
        _device!
            .disconnect()
            .then((value) => _device = null);
      }
    } catch (e) {
      throw Exception("Error disconnecting from device");
    }
  }

  //write data to device
  void writeData(String data) {
    try {
      if (_device != null) {
        _device!.discoverServices().then((value) {
          for (var element in value[0].characteristics) {
            element.write(utf8.encode(data));
          }
        });
      }
    } catch (_) {
      throw Exception("Error writing data to device");
    }
  }

  void isOn() async {
    try {
      if (await _flutterBlue.isAvailable) {
        if (await _flutterBlue.isOn) {
          _stateController.add(BluetoothServiceState.on);
        } else {
          _stateController.add(BluetoothServiceState.off);
        }
      } else {
        _stateController
            .add(BluetoothServiceState.unavailable);
      }
    } catch (_) {
      throw Exception("Error checking bluetooth state");
    }
  }

  void stopScan() async {
    try {
      if (await _flutterBlue.isAvailable) {
        _flutterBlue.stopScan();
      }
    } catch (_) {
      throw Exception("Error stopping scan");
    }
  }

  BluetoothDevice getDevice() {
    if (_device != null) {
      return _device!;
    } else {
      throw Exception("No device connected");
    }
  }
}
