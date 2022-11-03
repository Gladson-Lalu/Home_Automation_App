import '../../model/device.dart';

abstract class LocalDbRepository {
  Stream<List<List<ElectronicDevice>>>
      get connectedDevicesStream;
  Stream<List<List<ElectronicDevice>>> get allDevicesStream;

  List<List<ElectronicDevice>> getConnectedDevices();
  List<List<ElectronicDevice>> getAllDevices();
  void changeDeviceState(int deviceId, bool state);
  void updateElectronicDevice(ElectronicDevice device);
  void initConnectedDevice(
      List<Map<String, dynamic>> eDevices);
  int getIdDeviceByRoomAndDeviceName(
      String room, String deviceName);
}
