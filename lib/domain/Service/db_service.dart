import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:path_provider/path_provider.dart';

import '../../objectbox.g.dart';
import '../model/device.dart';

//singleton class for objectBox database
class LocalDBService {
  static final LocalDBService _dbService =
      LocalDBService._internal();
  late Store _store;
  LocalDBService._internal() {
    _init();
  }
  factory LocalDBService() {
    return _dbService;
  }
  Store get store => _store;
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

  void initConnectedDevice(
      List<Map<String, dynamic>> eDevices) {
    try {
      final box = Box<ElectronicDevice>(_store);
      final List<ElectronicDevice> devices = box.getAll();
      for (var element in eDevices) {
        final device = devices.where(
            (device) => device.id == element['deviceId']);
        if (device.isEmpty) {
          box.put(ElectronicDevice(
              id: int.parse(element['deviceId']),
              state: element['state'] == 'true',
              icon: 'unknown',
              name: 'unknown',
              type: DeviceType.unknown,
              room: 'unknown',
              isConnected: true));
        } else {
          device.first.state = element['state'] == 'true';
          device.first.isConnected = true;
          box.put(device.first);
        }
      }
    } on Exception {
      rethrow;
    }
  }

  Stream<List<List<ElectronicDevice>>>
      getConnectedDevicesStream() {
    try {
      final box = Box<ElectronicDevice>(_store);
      final StreamController<List<List<ElectronicDevice>>>
          controller = StreamController<
              List<List<ElectronicDevice>>>.broadcast();
      box
          .query(ElectronicDevice_.isConnected.equals(true))
          .watch()
          .listen((event) {
        controller.add(getConnectedDevices());
      });
      return controller.stream;
    } on Exception {
      rethrow;
    }
  }

  Stream<List<List<ElectronicDevice>>>
      getAllDevicesStream() {
    try {
      final box = Box<ElectronicDevice>(_store);
      final StreamController<List<List<ElectronicDevice>>>
          controller = StreamController<
              List<List<ElectronicDevice>>>.broadcast();
      box.query().watch().listen((event) {
        controller.add(getAllDevices());
      });
      return controller.stream;
    } on Exception {
      rethrow;
    }
  }

  List<List<ElectronicDevice>> getAllDevices() {
    try {
      final box = Box<ElectronicDevice>(_store);
      final devices = box.getAll();
      final Map<String, List<ElectronicDevice>> map = {};
      for (var device in devices) {
        if (map.containsKey(device.room)) {
          map[device.room]!.add(device);
        } else {
          map[device.room] = [device];
        }
      }
      return map.values.toList();
    } on Exception {
      rethrow;
    }
  }

  List<List<ElectronicDevice>> getConnectedDevices() {
    try {
      final devices = _store
          .box<ElectronicDevice>()
          .query(ElectronicDevice_.isConnected.equals(true))
          .build()
          .find();
      final Map<String, List<ElectronicDevice>> map = {};
      for (var device in devices) {
        if (map.containsKey(device.room)) {
          map[device.room]!.add(device);
        } else {
          map[device.room] = [device];
        }
      }
      return map.values.toList();
    } on Exception {
      rethrow;
    }
  }

  //set ElectronicDevice state
  void setElectronicDeviceState(int deviceId, bool state) {
    try {
      final box = Box<ElectronicDevice>(_store);
      final device = box.get(deviceId);
      if (device != null) {
        device.state = state;
        box.put(device);
      }
    } on Exception {
      rethrow;
    }
  }

  //update ElectronicDevice
  void updateElectronicDevice(ElectronicDevice device) {
    try {
      final box = Box<ElectronicDevice>(_store);
      box.put(device);
    } on Exception {
      rethrow;
    }
  }
}
