import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import '../model/bluetooth_state.dart';

class BluetoothSerialService {
  final FlutterBluetoothSerial _flutterBluetoothSerial =
      FlutterBluetoothSerial.instance;
  BluetoothConnection? _connection;
  final StreamController<BluetoothServiceState>
      _stateController =
      StreamController<BluetoothServiceState>.broadcast();
  Stream<BluetoothServiceState> get state =>
      _stateController.stream;

  final StreamController<String> _errorController =
      StreamController<String>();
  Stream<String> get errorStream => _errorController.stream;

  final StreamController<String> _readDataController =
      StreamController<String>();
  Stream<String> get readData => _readDataController.stream;

  bool get isConnected => _connection != null;

  Future<List<BluetoothDevice>> get devices =>
      _flutterBluetoothSerial.getBondedDevices();

  void init() {
    _flutterBluetoothSerial
        .onStateChanged()
        .listen((BluetoothState state) {
      if (state == BluetoothState.STATE_ON ||
          state == BluetoothState.STATE_BLE_ON) {
        _stateController.add(BluetoothServiceState.on);
      } else if (state == BluetoothState.STATE_OFF) {
        _stateController.add(BluetoothServiceState.off);
      } else if (state == BluetoothState.STATE_TURNING_ON ||
          state == BluetoothState.STATE_BLE_TURNING_ON) {
        _stateController
            .add(BluetoothServiceState.turningOn);
      } else if (state ==
              BluetoothState.STATE_TURNING_OFF ||
          state == BluetoothState.STATE_BLE_TURNING_OFF) {
        _stateController
            .add(BluetoothServiceState.turningOff);
      } else if (BluetoothState.UNKNOWN == state) {
        _stateController
            .add(BluetoothServiceState.unavailable);
      }
    });
  }

  // Future<bool> _requestPermission() async {
  //   Map<Permission, PermissionStatus> status = await [
  //     Permission.bluetooth,
  //     Permission.bluetoothConnect,
  //     Permission.bluetoothScan,
  //     Permission.location,
  //   ].request();
  //   return status[Permission.location]!.isGranted &&
  //       status[Permission.bluetooth]!.isGranted &&
  //       status[Permission.bluetoothConnect]!.isGranted &&
  //       status[Permission.bluetoothScan]!.isGranted;
  // }

  void connectToDevice(String address) {
    _stateController.add(BluetoothServiceState.connecting);
    BluetoothConnection.toAddress(address).then((value) {
      _connection = value;
      if (_connection != null && _connection!.isConnected) {
        _stateController
            .add(BluetoothServiceState.connected);
        if (_connection!.input != null) {
          _connection!.input!.listen((event) {
            _readDataController
                .add(utf8.decoder.convert(event));
          });
        }
      }
    }).onError((error, stackTrace) {
      _errorController.add("Error connecting to device");
    });
  }

  void disconnect() {
    _stateController
        .add(BluetoothServiceState.disconnecting);
    if (_connection != null) {
      _connection!.dispose();
      _stateController
          .add(BluetoothServiceState.disconnected);
      _connection = null;
    }
  }

  void writeData(String data) {
    if (_connection != null && _connection!.isConnected) {
      _connection!.output
          .add(Uint8List.fromList(utf8.encode(data)));
    }
  }

  void isOn() {
    _flutterBluetoothSerial.isEnabled.then((value) {
      if (value != null) {
        if (value) {
          _stateController.add(BluetoothServiceState.on);
        } else {
          _stateController.add(BluetoothServiceState.off);
        }
      } else {
        _stateController.add(BluetoothServiceState.off);
      }
    });
  }
}
