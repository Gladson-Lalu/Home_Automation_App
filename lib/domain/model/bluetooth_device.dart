class BluetoothDeviceModel {
  final String name;
  final String address;
  final bool isConnectable;

  const BluetoothDeviceModel({
    required this.name,
    required this.address,
    required this.isConnectable,
  });
}
