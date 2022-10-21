import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/model/device.dart';

import '../../../domain/repository/database/local_db_repository.dart';

part 'home_electronic_devices_state.dart';

class HomeElectronicDevicesCubit
    extends Cubit<HomeElectronicDevicesState> {
  final LocalDbRepository _localDbRepository;
  HomeElectronicDevicesCubit(this._localDbRepository)
      : super(const HomeElectronicDevicesInitial()) {
    try {
      _localDbRepository
          .getConnectedDevicesStream()
          .listen((devices) {
        if (devices.isNotEmpty) {
          emit(HomeElectronicDevicesLoaded(devices));
        } else {
          emit(const HomeElectronicDevicesInitial());
        }
      });
    } on Exception catch (e) {
      emit(HomeElectronicDevicesError(e.toString()));
    }
  }

  //get all connected devices
  void getConnectedDevices() {
    try {
      emit(const HomeElectronicDevicesLoading());
      final devices =
          _localDbRepository.getConnectedDevices();
      if (devices.isNotEmpty) {
        emit(HomeElectronicDevicesLoaded(devices));
      } else {
        emit(const HomeElectronicDevicesInitial());
      }
    } on Exception catch (e) {
      emit(HomeElectronicDevicesError(e.toString()));
    }
  }

  //set device state
  void changeState(int deviceId, bool state) async {
    try {
      emit(const HomeElectronicDevicesLoading());
      _localDbRepository.setElectronicDeviceState(
          deviceId, state);
    } on Exception catch (e) {
      emit(HomeElectronicDevicesError(e.toString()));
    }
  }
}
