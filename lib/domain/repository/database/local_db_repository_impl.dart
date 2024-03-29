import 'dart:async';

import '../../../config/sample_devices.dart';

import '../../service/db_service.dart';
import '../../model/device.dart';
import 'local_db_repository.dart';

class LocalDbRepositoryImpl implements LocalDbRepository {
  final ObjectBoxDBService _localDBService;
  LocalDbRepositoryImpl(this._localDBService);

  List<List<ElectronicDevice>> _transformDevices(
      List<ElectronicDevice> devices) {
    final Map<String, List<ElectronicDevice>> map = {};
    for (var device in devices) {
      if (map.containsKey(device.room)) {
        map[device.room]!.add(device);
      } else {
        map[device.room] = [device];
      }
    }
    return map.values.toList();
  }

  @override
  Stream<List<List<ElectronicDevice>>>
      get connectedDevicesStream =>
          _localDBService.connectedDevicesStream.transform(
              StreamTransformer<
                  List<ElectronicDevice>,
                  List<
                      List<ElectronicDevice>>>.fromHandlers(
            handleData: (devices, sink) {
              sink.add(_transformDevices(devices));
            },
          ));

  @override
  Stream<List<List<ElectronicDevice>>>
      get allDevicesStream =>
          _localDBService.allDevicesStream.transform(
              StreamTransformer<
                  List<ElectronicDevice>,
                  List<
                      List<ElectronicDevice>>>.fromHandlers(
            handleData: (devices, sink) {
              sink.add(_transformDevices(devices));
            },
          ));

  @override
  void changeDeviceState(int deviceId, bool state) {
    final device = _localDBService.getDeviceById(deviceId);
    if (device != null) {
      device.state = state;
      _localDBService.updateDevice(device);
    }
  }

  @override
  void updateElectronicDevice(ElectronicDevice device) {
    _localDBService.updateDevice(device);
  }

  @override
  void initConnectedDevice(
      List<Map<String, dynamic>> eDevices) {
    final devices = _localDBService.getAllDevices();
    final List<ElectronicDevice> connectedDevices =
        eDevices.map((element) {
      final device = devices.firstWhere(
          (device) => device.id == int.parse(element['id']),
          orElse: () => ElectronicDevice(
              id: int.parse(element['id']),
              name: element['name'],
              room: 'unknown',
              isConnected: true,
              state: false,
              type: DeviceType.unknown,
              icon: 'unknown'));

      device.state = element['state'] == '1';
      device.isConnected = true;
      return device;
    }).toList();
    _localDBService.addDevices(connectedDevices);
  }

  @override
  List<List<ElectronicDevice>> getConnectedDevices() {
    return _transformDevices(
        _localDBService.getConnectedDevices());
  }

  @override
  List<List<ElectronicDevice>> getAllDevices() {
    return _transformDevices(
        _localDBService.getAllDevices());
  }

  @override
  int getIdDeviceByRoomAndDeviceName(
      String room, String deviceName) {
    final device = _localDBService
        .getDeviceByRoomAndDeviceName(room, deviceName);
    return device?.id ?? -1;
  }

  @override
  void debugAddSampleDevices() {
    for (var element in sampleDevices) {
      for (var device in element) {
        if (device.id % 6 == 0) {
          device.isConnected = false;
        } else {
          device.isConnected = true;
        }
        _localDBService.addDevice(device);
      }
    }
  }
}
