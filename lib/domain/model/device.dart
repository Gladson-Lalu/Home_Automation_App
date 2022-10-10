// ignore_for_file: constant_identifier_names

enum DeviceType {
  table_lamp,
  light,
  ceiling_lamp,
  ceiling_fan,
  pedestal_fan,
  table_fan,
  desktop,
  fan,
  air_conditioner,
  air_cooler,
  television,
  refrigerator,
  heater,
  water_dispenser,
  water_heater,
  water_filter,
  water_pump,
  washing_machine,
  electric_kettle,
  toaster,
  coffee_maker,
  extractor,
  oven,
  air_purifier,
  dehumidifier,
  juicer,
  exhaust_fan,
  socket,
  blender,
  dish_washer,
  induction_stove,
  iron,
}

class ElectronicDevice {
  final String id;
  String name;
  DeviceType type;
  String room;
  String roomId;
  String icon;
  bool state;

  ElectronicDevice({
    required this.roomId,
    required this.id,
    required this.name,
    required this.type,
    required this.room,
    required this.icon,
    required this.state,
  });
}
