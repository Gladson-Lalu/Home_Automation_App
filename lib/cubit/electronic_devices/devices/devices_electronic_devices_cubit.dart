import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/model/device.dart';
import '../../../domain/repository/database/local_db_repository.dart';

part 'devices_electronic_devices_state.dart';

class DevicesElectronicDevicesCubit
    extends Cubit<DevicesElectronicDevicesState> {
  final LocalDbRepository _localDbRepository;
  DevicesElectronicDevicesCubit(this._localDbRepository)
      : super(const DevicesElectronicDevicesInitial()) {
    try {
      _localDbRepository
          .getAllDevicesStream()
          .listen((devices) {
        if (devices.isNotEmpty) {
          emit(DevicesElectronicDevicesLoaded(devices));
        } else {
          emit(const DevicesElectronicDevicesInitial());
        }
      });
    } on Exception catch (e) {
      emit(DevicesElectronicDevicesError(e.toString()));
    }
  }

  //get all devices
  void getAllDevices() {
    try {
      emit(const DevicesElectronicDevicesLoading());
      final devices = _localDbRepository.getAllDevices();
      if (devices.isNotEmpty) {
        emit(DevicesElectronicDevicesLoaded(devices));
      } else {
        emit(const DevicesElectronicDevicesInitial());
      }
    } on Exception catch (e) {
      emit(DevicesElectronicDevicesError(e.toString()));
    }
  }

  //set device state
  void changeDeviceState(int deviceId, bool state) async {
    try {
      emit(const DevicesElectronicDevicesLoading());
      _localDbRepository.setElectronicDeviceState(
          deviceId, state);
    } on Exception catch (e) {
      emit(DevicesElectronicDevicesError(e.toString()));
    }
  }

  //update the electronic device
  void updateDevice(ElectronicDevice device) async {
    try {
      emit(const DevicesElectronicDevicesLoading());
      _localDbRepository.updateElectronicDevice(device);
    } on Exception catch (e) {
      emit(DevicesElectronicDevicesError(e.toString()));
    }
  }
}
