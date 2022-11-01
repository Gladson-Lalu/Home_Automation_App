part of 'bluetooth_cubit.dart';

@immutable
abstract class BluetoothState {
  const BluetoothState();
}

class BluetoothInitial extends BluetoothState {
  const BluetoothInitial();
}

class BluetoothOff extends BluetoothState {
  const BluetoothOff();
}

class BluetoothOn extends BluetoothState {
  const BluetoothOn();
}

class BluetoothTurningOn extends BluetoothState {
  const BluetoothTurningOn();
}

class BluetoothTurningOff extends BluetoothState {
  const BluetoothTurningOff();
}

class BluetoothUnavailable extends BluetoothState {
  const BluetoothUnavailable();
}

class BluetoothDisconnecting extends BluetoothState {
  const BluetoothDisconnecting();
}

class BluetoothConnecting extends BluetoothState {
  const BluetoothConnecting();
}

class BluetoothConnected extends BluetoothState {
  const BluetoothConnected();
}

class BluetoothDisconnected extends BluetoothState {
  const BluetoothDisconnected();
}

class BluetoothError extends BluetoothState {
  final String message;

  const BluetoothError(this.message);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is BluetoothError &&
        other.message == message;
  }

  @override
  int get hashCode => message.hashCode;
}
