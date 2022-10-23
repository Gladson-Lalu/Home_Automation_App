import 'dart:async';

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
      device.isConnected = state;
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
          (device) => device.id == element['deviceId'],
          orElse: () => ElectronicDevice(
              id: int.parse(element['deviceId']),
              name: 'unknown',
              room: 'unknown',
              isConnected: true,
              state: false,
              type: DeviceType.unknown,
              icon: 'unknown'));

      device.state = element['state'] == 'true';
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
}
