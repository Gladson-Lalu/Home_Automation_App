//sample devices

import '../domain/model/device.dart';

final sampleDevices = [
  [
    ElectronicDevice(
      id: 1,
      name: 'Table Lamp',
      type: DeviceType.table_lamp,
      room: 'Living Room',
      icon: 'table_lamp',
      state: true,
    ),
    ElectronicDevice(
      id: 2,
      name: 'Ceiling Lamp',
      type: DeviceType.ceiling_lamp,
      room: 'Living Room',
      icon: 'ceiling_lamp',
      state: false,
    ),
    ElectronicDevice(
      id: 3,
      name: 'Ceiling Fan',
      type: DeviceType.ceiling_fan,
      room: 'Living Room',
      icon: 'ceiling_fan',
      state: true,
    ),
    ElectronicDevice(
      id: 4,
      name: 'Table Fan',
      type: DeviceType.table_fan,
      room: 'Living Room',
      icon: 'table_fan',
      state: false,
    ),
    ElectronicDevice(
      id: 5,
      name: 'Air Conditioner',
      type: DeviceType.air_conditioner,
      room: 'Living Room',
      icon: 'air_conditioner',
      state: true,
    ),
    ElectronicDevice(
      id: 6,
      name: 'Air Cooler',
      type: DeviceType.air_cooler,
      room: 'Living Room',
      icon: 'air_cooler',
      state: false,
    ),
    ElectronicDevice(
      id: 7,
      name: 'Television',
      type: DeviceType.television,
      room: 'Living Room',
      icon: 'television',
      state: true,
    ),
    ElectronicDevice(
      id: 8,
      name: 'Refrigerator',
      type: DeviceType.refrigerator,
      room: 'Kitchen',
      icon: 'refrigerator',
      state: false,
    ),
    ElectronicDevice(
      id: 9,
      name: 'Heater',
      type: DeviceType.heater,
      room: 'Kitchen',
      icon: 'heater',
      state: true,
    ),
  ],
  [
    ElectronicDevice(
      id: 10,
      name: 'Water Dispenser',
      type: DeviceType.water_dispenser,
      room: 'Kitchen',
      icon: 'water_dispenser',
      state: false,
    ),
    ElectronicDevice(
      id: 11,
      name: 'Water Heater',
      type: DeviceType.water_heater,
      room: 'Kitchen',
      icon: 'water_heater',
      state: true,
    ),
    ElectronicDevice(
      id: 12,
      name: 'Water Filter',
      type: DeviceType.water_filter,
      room: 'Kitchen',
      icon: 'water_filter',
      state: false,
    ),
    ElectronicDevice(
      id: 13,
      name: 'Water Pump',
      type: DeviceType.water_pump,
      room: 'Kitchen',
      icon: 'water_pump',
      state: true,
    ),
    ElectronicDevice(
      id: 14,
      name: 'Water Purifier',
      type: DeviceType.water_filter,
      room: 'Kitchen',
      icon: 'water_filter',
      state: false,
    ),
    ElectronicDevice(
      id: 15,
      name: 'Dish Washer',
      type: DeviceType.dish_washer,
      room: 'Kitchen',
      icon: 'dish_washer',
      state: true,
    ),
    ElectronicDevice(
      id: 16,
      name: 'Microwave',
      type: DeviceType.oven,
      room: 'Kitchen',
      icon: 'oven',
      state: false,
    ),
    ElectronicDevice(
      id: 17,
      name: 'Toaster',
      type: DeviceType.toaster,
      room: 'Kitchen',
      icon: 'toaster',
      state: true,
    ),
    ElectronicDevice(
      id: 18,
      name: 'Coffee Maker',
      type: DeviceType.coffee_maker,
      room: 'Kitchen',
      icon: 'coffee_maker',
      state: false,
    ),
    ElectronicDevice(
      id: 19,
      name: 'Electric Kettle',
      type: DeviceType.electric_kettle,
      room: 'Kitchen',
      icon: 'electric_kettle',
      state: true,
    ),
    ElectronicDevice(
      id: 20,
      name: 'Induction Stove',
      type: DeviceType.induction_stove,
      room: 'Kitchen',
      icon: 'induction_stove',
      state: false,
    ),
  ],
  [
    //bedroom
    ElectronicDevice(
      id: 21,
      name: 'Ceiling Fan',
      type: DeviceType.ceiling_fan,
      room: 'Bedroom',
      icon: 'ceiling_fan',
      state: true,
    ),
    ElectronicDevice(
      id: 22,
      name: 'Air Conditioner',
      type: DeviceType.air_conditioner,
      room: 'Bedroom',
      icon: 'air_conditioner',
      state: false,
    ),
    ElectronicDevice(
      id: 23,
      name: 'Air Cooler',
      type: DeviceType.air_cooler,
      room: 'Bedroom',
      icon: 'air_cooler',
      state: true,
    ),
    ElectronicDevice(
      id: 24,
      name: 'Air Purifier',
      type: DeviceType.air_purifier,
      room: 'Bedroom',
      icon: 'air_purifier',
      state: false,
    ),
    ElectronicDevice(
      id: 26,
      name: 'Dehumidifier',
      type: DeviceType.dehumidifier,
      room: 'Bedroom',
      icon: 'dehumidifier',
      state: false,
    ),
  ],
  [
    //hallway
    ElectronicDevice(
      id: 27,
      name: 'Ceiling Fan',
      type: DeviceType.ceiling_fan,
      room: 'Hallway',
      icon: 'ceiling_fan',
      state: true,
    ),
    //ceiling light on Hallway
    ElectronicDevice(
      id: 28,
      name: 'Ceiling Light',
      type: DeviceType.ceiling_lamp,
      room: 'Hallway',
      icon: 'ceiling_lamp',
      state: false,
    ),
  ],
  [
    //bathroom
    //exhaust fan on bathroom
    ElectronicDevice(
      id: 29,
      name: 'Exhaust Fan',
      type: DeviceType.exhaust_fan,
      room: 'Bathroom',
      icon: 'exhaust_fan',
      state: true,
    ),
    //water heater on bathroom
    ElectronicDevice(
      id: 30,
      name: 'Water Heater',
      type: DeviceType.water_heater,
      room: 'Bathroom',
      icon: 'water_heater',
      state: false,
    ),
    //ceiling light on bathroom
    ElectronicDevice(
      id: 31,
      name: 'Ceiling Light',
      type: DeviceType.ceiling_lamp,
      room: 'Bathroom',
      icon: 'ceiling_lamp',
      state: true,
    ),
  ],
  [
    //guest room
    ElectronicDevice(
      id: 32,
      name: 'Ceiling Fan',
      type: DeviceType.ceiling_fan,
      room: 'Guest Room',
      icon: 'ceiling_fan',
      state: false,
    ),
    ElectronicDevice(
      id: 33,
      name: 'Air Conditioner',
      type: DeviceType.air_conditioner,
      room: 'Guest Room',
      icon: 'air_conditioner',
      state: true,
    ),
    ElectronicDevice(
      id: 34,
      name: 'Air Cooler',
      type: DeviceType.air_cooler,
      room: 'Guest Room',
      icon: 'air_cooler',
      state: false,
    ),
    ElectronicDevice(
      id: 35,
      name: 'Air Purifier',
      type: DeviceType.air_purifier,
      room: 'Guest Room',
      icon: 'air_purifier',
      state: true,
    ),
    ElectronicDevice(
      id: 36,
      name: 'Dehumidifier',
      type: DeviceType.dehumidifier,
      room: 'Guest Room',
      icon: 'dehumidifier',
      state: false,
    ),
    ElectronicDevice(
      id: 37,
      name: 'Ceiling Light',
      type: DeviceType.ceiling_lamp,
      room: 'Guest Room',
      icon: 'ceiling_lamp',
      state: true,
    ),
  ],
  [
    //master bedroom
    //dining room
    ElectronicDevice(
      id: 38,
      name: 'Ceiling Fan',
      type: DeviceType.ceiling_fan,
      room: 'Dining Room',
      icon: 'ceiling_fan',
      state: false,
    ),
    ElectronicDevice(
      id: 39,
      name: 'Ceiling Light',
      type: DeviceType.ceiling_lamp,
      room: 'Dining Room',
      icon: 'ceiling_lamp',
      state: true,
    ),
  ],
  [
    //laundry room
    ElectronicDevice(
      id: 40,
      name: 'Ceiling Fan',
      type: DeviceType.ceiling_fan,
      room: 'Laundry Room',
      icon: 'ceiling_fan',
      state: true,
    ),
    //washing machine on laundry room
    ElectronicDevice(
      id: 41,
      name: 'Washing Machine',
      type: DeviceType.washing_machine,
      room: 'Laundry Room',
      icon: 'washing_machine',
      state: false,
    ),
    //ceiling light on laundry room
    ElectronicDevice(
      id: 42,
      name: 'Ceiling Light',
      type: DeviceType.ceiling_lamp,
      room: 'Laundry Room',
      icon: 'ceiling_lamp',
      state: true,
    ),
    //exhaust fan on laundry room
    ElectronicDevice(
      id: 43,
      name: 'Exhaust Fan',
      type: DeviceType.exhaust_fan,
      room: 'Laundry Room',
      icon: 'exhaust_fan',
      state: false,
    ),
    ElectronicDevice(
      id: 44,
      name: 'Iron',
      type: DeviceType.iron,
      room: 'Laundry Room',
      icon: 'iron',
      state: true,
    )
  ]
];
