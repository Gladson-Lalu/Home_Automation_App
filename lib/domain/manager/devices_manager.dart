import '../model/bluetooth_state.dart';
import '../repository/bluetooth/bluetooth_repository.dart';
import '../repository/database/local_db_repository.dart';

class DevicesManager {
  final BluetoothRepository _bluetoothRepository;
  final LocalDbRepository _localDbRepository;
  bool isConnected = true;
  final List<String> buffer = [];
  DevicesManager(
      this._bluetoothRepository, this._localDbRepository) {
    _bluetoothRepository.readEvent.listen((e) {
      if (e.isNotEmpty) {
        buffer.add(e);
        if (e.contains("@")) {
          final String text = buffer.join();
          if (text.startsWith('done')) {
            final List<Map<String, dynamic>> data = [];
            final List<String> values = text
                .replaceFirst('done', '')
                .replaceFirst(',@', '')
                .trim()
                .split(',');

            for (var item in values) {
              final keyValue = item.split(':');
              data.add({
                'id': keyValue[0],
                'state': keyValue[1],
                'name': keyValue.length > 2
                    ? keyValue[2]
                    : 'unknown',
              });
            }
            _localDbRepository.initConnectedDevice(data);
          }
          buffer.clear();
        }
      }
    });
    _bluetoothRepository.state.listen((event) {
      if (event == BluetoothServiceState.connected) {
        _bluetoothRepository.initDevices();
      }
    });
  }

  void changeDeviceState(int deviceId, bool state) {
    try {
      if (isConnected) {
        _bluetoothRepository.writeDeviceState(
            deviceId, state);
        _localDbRepository.changeDeviceState(
            deviceId, state);
      } else {
        throw Exception('Device is not connected');
      }
    } catch (e) {
      rethrow;
    }
  }

  void executeAction(
      String intent, Map<String, dynamic> data) {
    try {
      if (isConnected) {
        final String? room = data['room'];
        final String? deviceName = data['device'];
        if (room != null && deviceName != null) {
          final int deviceId = _localDbRepository
              .getIdDeviceByRoomAndDeviceName(
                  room, deviceName);
          if (deviceId != -1) {
            if (intent == 'on') {
              changeDeviceState(deviceId, true);
            } else if (intent == 'off') {
              changeDeviceState(deviceId, false);
            }
          } else {
            throw Exception('Device not found');
          }
        } else {
          throw Exception(
              'Unable to get room or device name');
        }
      } else {
        throw Exception('Device is not connected');
      }
    } catch (e) {
      rethrow;
    }
  }
}
