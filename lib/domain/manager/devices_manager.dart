import '../repository/bluetooth/bluetooth_repository.dart';
import '../repository/database/local_db_repository.dart';

import '../model/bluetooth_state.dart';

class DevicesManager {
  final BluetoothRepository _bluetoothRepository;
  final LocalDbRepository _localDbRepository;
  bool isConnected =
      true; //TODO: change to false when bluetooth is implemented
  DevicesManager(
      this._bluetoothRepository, this._localDbRepository) {
    _bluetoothRepository.state.listen((state) {
      if (state == BluetoothServiceState.connected) {
        isConnected = true;
        _bluetoothRepository.readEvent.listen((event) {
          if (event.isNotEmpty) {
            final List<Map<String, dynamic>> data = [];
            for (var item in event.split(',')) {
              final keyValue = item.split(':');
              data.add({
                'deviceId': keyValue[0],
                'state': keyValue[1]
              });
            }
          }
        });
      } else if (state ==
          BluetoothServiceState.disconnected) {
        isConnected = false;
      }
    });
  }

  void changeDeviceState(int deviceId, bool state) {
    try {
      if (isConnected) {
        // _bluetoothRepository.writeDeviceState(
        //     deviceId, state); //TODO: uncomment when bluetooth is implemented
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
