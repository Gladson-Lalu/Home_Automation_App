import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:path_provider/path_provider.dart';

import '../../objectbox.g.dart';
import '../model/device.dart';

//singleton class for objectBox database
class ObjectBoxDBService {
  static final ObjectBoxDBService _dbService =
      ObjectBoxDBService._internal();
  late Store _store;
  ObjectBoxDBService._internal() {
    _init();
  }
  factory ObjectBoxDBService() {
    return _dbService;
  }

  void _init() async {
    try {
      final path = await getApplicationDocumentsDirectory();
      final directory = Directory('${path.path}/objectbox');
      if (!directory.existsSync()) {
        directory.createSync(recursive: true);
      }
      _store = Store(getObjectBoxModel(),
          directory: directory.path);
    } on Exception catch (e) {
      debugPrint(e.toString());
    }
  }

  Stream<List<ElectronicDevice>>
      get connectedDevicesStream => Box<ElectronicDevice>(
              _store)
          .query(ElectronicDevice_.isConnected.equals(true))
          .watch()
          .map((query) => query.find());

  Stream<List<ElectronicDevice>> get allDevicesStream =>
      Box<ElectronicDevice>(_store)
          .query()
          .watch()
          .map((query) => query.find());

  void addDevices(List<ElectronicDevice> devices) {
    final box = Box<ElectronicDevice>(_store);
    box.putMany(devices);
  }

  void addDevice(ElectronicDevice device) {
    final box = Box<ElectronicDevice>(_store);
    box.put(device);
  }

  ElectronicDevice? getDeviceById(int id) {
    final box = Box<ElectronicDevice>(_store);
    return box.get(id);
  }

  List<ElectronicDevice> getAllDevices() {
    final box = Box<ElectronicDevice>(_store);
    return box.getAll();
  }

  List<ElectronicDevice> getConnectedDevices() {
    final box = Box<ElectronicDevice>(_store);
    return box
        .query(ElectronicDevice_.isConnected.equals(true))
        .build()
        .find();
  }

  void updateDevice(ElectronicDevice device) {
    final box = Box<ElectronicDevice>(_store);
    box.put(device);
  }

  ElectronicDevice? getDeviceByRoomAndDeviceName(
      String room, String deviceName) {
    final box = Box<ElectronicDevice>(_store);
    return box
        .query(ElectronicDevice_.room
            .equals(room, caseSensitive: false)
            .and(ElectronicDevice_.name
                .equals(deviceName, caseSensitive: false)))
        .build()
        .findFirst();
  }
}
