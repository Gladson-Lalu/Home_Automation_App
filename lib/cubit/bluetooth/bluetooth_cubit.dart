import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/model/bluetooth_device.dart';
import '../../domain/repository/bluetooth/bluetooth_repository.dart';

import '../../domain/model/bluetooth_state.dart';

part 'bluetooth_state.dart';

class BluetoothCubit extends Cubit<BluetoothState> {
  final BluetoothRepository _bluetoothRepository;
  final StreamController<bool> _isScanningController =
      StreamController<bool>.broadcast();
  BluetoothDeviceModel? _connectedDevice;
  BluetoothCubit(this._bluetoothRepository)
      : super(const BluetoothInitial()) {
    try {
      _bluetoothRepository.state.listen((state) {
        switch (state) {
          case BluetoothServiceState.off:
            emit(const BluetoothOff());
            break;
          case BluetoothServiceState.on:
            emit(const BluetoothOn());
            break;
          case BluetoothServiceState.turningOn:
            emit(const BluetoothTurningOn());
            break;
          case BluetoothServiceState.turningOff:
            emit(const BluetoothTurningOff());
            break;
          case BluetoothServiceState.unavailable:
            emit(const BluetoothUnavailable());
            break;
          case BluetoothServiceState.connected:
            emit(const BluetoothConnected());
            break;
          case BluetoothServiceState.disconnected:
            emit(const BluetoothDisconnected());
            break;
          case BluetoothServiceState.connecting:
            emit(const BluetoothConnecting());
            break;
          case BluetoothServiceState.disconnecting:
            emit(const BluetoothDisconnecting());
            break;
        }
      });
      _bluetoothRepository.errorStream.listen((error) {
        emit(BluetoothError(error));
      });
    } catch (e) {
      emit(BluetoothError(e.toString()));
    }
  }

  //get devices
  Future<List<BluetoothDeviceModel>> getDevices() {
    _isScanningController.add(true);
    return _bluetoothRepository.devices.then((value) {
      Future.delayed(const Duration(seconds: 2), () {
        _isScanningController.add(false);
      });
      return value;
    });
  }

  //connect to device
  void connectToDevice(BluetoothDeviceModel device) {
    try {
      _connectedDevice = device;
      _bluetoothRepository.connectToDevice(device);
    } catch (e) {
      emit(BluetoothError(e.toString()));
    }
  }

  void isOn() {
    _bluetoothRepository.isOn();
  }

  //disconnect
  void disconnect() {
    _connectedDevice = null;
    _bluetoothRepository.disconnect();
  }

  BluetoothDeviceModel? get connectedDevice =>
      _connectedDevice;

  Stream<bool> get isScanning =>
      _isScanningController.stream;
}
