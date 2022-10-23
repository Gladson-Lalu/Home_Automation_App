import '../repository/bluetooth/bluetooth_repository.dart';
import '../repository/database/local_db_repository.dart';

import '../model/bluetooth_state.dart';

class DevicesManager {
  final BluetoothRepository _bluetoothRepository;
  final LocalDbRepository _localDbRepository;
  bool isConnected = false;
  DevicesManager(
      this._bluetoothRepository, this._localDbRepository) {
    _bluetoothRepository.state.listen((state) {
      if (state == BluetoothServiceState.connected) {
        isConnected = true;
        _bluetoothRepository.readEvent.listen((event) {
          print(event);
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
}
