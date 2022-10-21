import '../../Service/db_service.dart';
import '../../model/device.dart';
import 'local_db_repository.dart';

class LocalDbRepositoryImpl implements LocalDbRepository {
  final LocalDBService _localDBService;
  LocalDbRepositoryImpl(this._localDBService);
  @override
  Stream<List<List<ElectronicDevice>>>
      getConnectedDevicesStream() {
    return _localDBService.getConnectedDevicesStream();
  }

  @override
  Stream<List<List<ElectronicDevice>>>
      getAllDevicesStream() {
    return _localDBService.getAllDevicesStream();
  }

  @override
  void setElectronicDeviceState(int deviceId, bool state) {
    _localDBService.setElectronicDeviceState(
        deviceId, state);
  }

  @override
  void updateElectronicDevice(ElectronicDevice device) {
    _localDBService.updateElectronicDevice(device);
  }

  @override
  void initConnectedDevice(
      List<Map<String, dynamic>> eDevices) {
    _localDBService.initConnectedDevice(eDevices);
  }

  @override
  List<List<ElectronicDevice>> getConnectedDevices() {
    return _localDBService.getConnectedDevices();
  }

  @override
  List<List<ElectronicDevice>> getAllDevices() {
    return _localDBService.getAllDevices();
  }
}
