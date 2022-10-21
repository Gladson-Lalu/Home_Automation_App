import '../../model/device.dart';

abstract class LocalDbRepository {
  Stream<List<List<ElectronicDevice>>>
      getConnectedDevicesStream();
  Stream<List<List<ElectronicDevice>>>
      getAllDevicesStream();

  List<List<ElectronicDevice>> getConnectedDevices();
  List<List<ElectronicDevice>> getAllDevices();
  void setElectronicDeviceState(int deviceId, bool state);
  void updateElectronicDevice(ElectronicDevice device);
  void initConnectedDevice(
      List<Map<String, dynamic>> eDevices);
}
