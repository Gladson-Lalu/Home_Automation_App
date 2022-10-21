// ignore_for_file: constant_identifier_names

import 'package:objectbox/objectbox.dart';

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
  unknown,
}

@Entity()
class ElectronicDevice {
  @Id(assignable: true)
  int id;
  String name;
  DeviceType type;
  int get typeValue {
    _ensureStableEnumValues();
    return type.index;
  }

  set typeValue(int value) {
    _ensureStableEnumValues();
    type = DeviceType.values[value];
  }

  String room;
  bool isConnected;
  String icon;
  bool state;

  ElectronicDevice({
    required this.id,
    this.type = DeviceType.unknown,
    this.isConnected = false,
    required this.name,
    required this.room,
    required this.icon,
    required this.state,
  });

  void _ensureStableEnumValues() {
    assert(DeviceType.table_lamp.index == 0);
    assert(DeviceType.light.index == 1);
    assert(DeviceType.ceiling_lamp.index == 2);
    assert(DeviceType.ceiling_fan.index == 3);
    assert(DeviceType.pedestal_fan.index == 4);
    assert(DeviceType.table_fan.index == 5);
    assert(DeviceType.desktop.index == 6);
    assert(DeviceType.fan.index == 7);
    assert(DeviceType.air_conditioner.index == 8);
    assert(DeviceType.air_cooler.index == 9);
    assert(DeviceType.television.index == 10);
    assert(DeviceType.refrigerator.index == 11);
    assert(DeviceType.heater.index == 12);
    assert(DeviceType.water_dispenser.index == 13);
    assert(DeviceType.water_heater.index == 14);
    assert(DeviceType.water_filter.index == 15);
    assert(DeviceType.water_pump.index == 16);
    assert(DeviceType.washing_machine.index == 17);
    assert(DeviceType.electric_kettle.index == 18);
    assert(DeviceType.toaster.index == 19);
    assert(DeviceType.coffee_maker.index == 20);
    assert(DeviceType.extractor.index == 21);
    assert(DeviceType.oven.index == 22);
    assert(DeviceType.air_purifier.index == 23);
    assert(DeviceType.dehumidifier.index == 24);
    assert(DeviceType.juicer.index == 25);
    assert(DeviceType.exhaust_fan.index == 26);
    assert(DeviceType.socket.index == 27);
    assert(DeviceType.blender.index == 28);
    assert(DeviceType.dish_washer.index == 29);
    assert(DeviceType.induction_stove.index == 30);
    assert(DeviceType.iron.index == 31);
    assert(DeviceType.unknown.index == 32);
  }
}
