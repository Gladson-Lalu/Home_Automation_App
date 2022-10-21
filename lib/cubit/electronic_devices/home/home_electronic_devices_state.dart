part of 'home_electronic_devices_cubit.dart';

@immutable
abstract class HomeElectronicDevicesState {
  const HomeElectronicDevicesState();
}

class HomeElectronicDevicesInitial
    extends HomeElectronicDevicesState {
  const HomeElectronicDevicesInitial();
}

class HomeElectronicDevicesLoading
    extends HomeElectronicDevicesState {
  const HomeElectronicDevicesLoading();
}

class HomeElectronicDevicesLoaded
    extends HomeElectronicDevicesState {
  final List<List<ElectronicDevice>> roomDevices;
  const HomeElectronicDevicesLoaded(this.roomDevices);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is HomeElectronicDevicesLoaded &&
        listEquals(other.roomDevices, roomDevices);
  }

  @override
  int get hashCode => roomDevices.hashCode;
}

class HomeElectronicDevicesError
    extends HomeElectronicDevicesState {
  final String message;
  const HomeElectronicDevicesError(this.message);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is HomeElectronicDevicesError &&
        other.message == message;
  }

  @override
  int get hashCode => message.hashCode;
}
