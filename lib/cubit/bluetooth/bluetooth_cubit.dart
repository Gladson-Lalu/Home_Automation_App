import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:home_automation/domain/model/bluetooth_device.dart';
import 'package:home_automation/domain/repository/bluetooth/bluetooth_repository.dart';

import '../../domain/model/bluetooth_state.dart';

part 'bluetooth_state.dart';

class BluetoothCubit extends Cubit<BluetoothState> {
  final BluetoothRepository _bluetoothRepository;

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
          case BluetoothServiceState.disconnecting:
            emit(const BluetoothDisconnecting());
            break;
          case BluetoothServiceState.connecting:
            emit(const BluetoothConnecting());
            break;
          case BluetoothServiceState.connected:
            emit(BluetoothConnected(
                _bluetoothRepository.device));
            break;
          case BluetoothServiceState.disconnected:
            emit(const BluetoothDisconnected());
            break;
        }
      });
    } catch (e) {
      emit(BluetoothError(e.toString()));
    }
  }

  //get devices
  Stream<List<BluetoothDeviceModel>> get devices =>
      _bluetoothRepository.devices;

  //get isScanning
  Stream<bool> get isScanning =>
      _bluetoothRepository.isScanning;

  //connect to device
  void connectToDevice(BluetoothDeviceModel device) {
    _bluetoothRepository.connectToDevice(device);
  }

  void isOn() {
    _bluetoothRepository.isOn();
  }

  //start scanning
  void startScanning() {
    _bluetoothRepository.startScan();
  }

  //stop scanning
  void stopScanning() {
    _bluetoothRepository.stopScan();
  }

  //disconnect
  void disconnect() {
    _bluetoothRepository.disconnect();
  }
}
