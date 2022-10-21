part of 'devices_electronic_devices_cubit.dart';

@immutable
abstract class DevicesElectronicDevicesState {
  const DevicesElectronicDevicesState();
}

class DevicesElectronicDevicesInitial
    extends DevicesElectronicDevicesState {
  const DevicesElectronicDevicesInitial();
}

class DevicesElectronicDevicesLoading
    extends DevicesElectronicDevicesState {
  const DevicesElectronicDevicesLoading();
}

class DevicesElectronicDevicesLoaded
    extends DevicesElectronicDevicesState {
  final List<List<ElectronicDevice>> devices;
  const DevicesElectronicDevicesLoaded(this.devices);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is DevicesElectronicDevicesLoaded &&
        listEquals(other.devices, devices);
  }

  @override
  int get hashCode => devices.hashCode;
}

class DevicesElectronicDevicesError
    extends DevicesElectronicDevicesState {
  final String message;
  const DevicesElectronicDevicesError(this.message);
}
