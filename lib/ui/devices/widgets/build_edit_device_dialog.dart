import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../cubit/electronic_devices/devices/devices_electronic_devices_cubit.dart';

import '../../../domain/model/device.dart';

Future<dynamic> buildDialogBox(BuildContext context,
    List<String> rooms, ElectronicDevice device) {
  TextEditingController nameController =
      TextEditingController();
  nameController.text = device.name;
  String selectedRoom = device.room;
  DeviceType selectedType = device.type;
  return showDialog(
      context: context,
      builder: (ctx) {
        return StatefulBuilder(
            builder: (BuildContext context, setState) {
          return AlertDialog(
            insetPadding: const EdgeInsets.all(20),
            backgroundColor:
                Theme.of(context).backgroundColor,
            title: const Text('Edit Device'),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10)),
            content: Container(
              padding: const EdgeInsets.all(10),
              height:
                  MediaQuery.of(context).size.height * 0.4,
              width:
                  MediaQuery.of(context).size.width * 0.8,
              child: Column(
                children: [
                  //outlined text field for device name
                  TextField(
                    controller: nameController,
                    decoration: InputDecoration(
                      labelText: 'Device Name',
                      labelStyle: TextStyle(
                          color: Theme.of(context)
                              .textTheme
                              .bodyText1!
                              .color,
                          fontSize: 16,
                          fontWeight: FontWeight.w400),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Theme.of(context)
                                .shadowColor),
                        borderRadius:
                            BorderRadius.circular(10),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Theme.of(context)
                                .focusColor
                                .withOpacity(0.6)),
                        borderRadius:
                            BorderRadius.circular(10),
                      ),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Theme.of(context)
                                .shadowColor
                                .withOpacity(0.4)),
                        borderRadius:
                            BorderRadius.circular(10),
                      ),
                    ),
                    cursorColor: Theme.of(context)
                        .textTheme
                        .bodyText1!
                        .color,
                    style: TextStyle(
                        color: Theme.of(context)
                            .textTheme
                            .bodyText1!
                            .color,
                        fontSize: 16,
                        fontWeight: FontWeight.w400),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: DropdownButtonFormField(
                          value: selectedRoom,
                          decoration: InputDecoration(
                            labelText: 'Room Name',
                            hintText: device.room,
                            labelStyle: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 16,
                                color: Theme.of(context)
                                    .textTheme
                                    .bodyText1!
                                    .color),
                            enabledBorder:
                                OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Theme.of(context)
                                      .textTheme
                                      .bodyText1!
                                      .color!),
                            ),
                            focusedBorder:
                                OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Theme.of(context)
                                      .textTheme
                                      .bodyText1!
                                      .color!),
                            ),
                          ),
                          items: rooms
                              .map((e) => DropdownMenuItem(
                                  value: e, child: Text(e)))
                              .toList(),
                          hint: Text('Select Room',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight:
                                      FontWeight.w400,
                                  color: Theme.of(context)
                                      .textTheme
                                      .bodyText1!
                                      .color)),
                          dropdownColor: Theme.of(context)
                              .backgroundColor,
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              color: Theme.of(context)
                                  .textTheme
                                  .bodyText1!
                                  .color),
                          borderRadius:
                              BorderRadius.circular(10),
                          onChanged: (value) {
                            selectedRoom = value.toString();
                          },
                        ),
                      ),
                      //add room button
                      IconButton(
                        onPressed: () {
                          final TextEditingController
                              roomNameController =
                              TextEditingController();
                          showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  backgroundColor:
                                      Theme.of(context)
                                          .backgroundColor,
                                  title: const Text(
                                      'Add Room'),
                                  shape:
                                      RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius
                                                  .circular(
                                                      10)),
                                  content: SizedBox(
                                    height: MediaQuery.of(
                                                context)
                                            .size
                                            .height *
                                        0.2,
                                    width: MediaQuery.of(
                                                context)
                                            .size
                                            .width *
                                        0.8,
                                    child: Column(
                                      children: [
                                        TextField(
                                          controller:
                                              roomNameController,
                                          decoration: InputDecoration(
                                              labelText:
                                                  'Room Name',
                                              labelStyle: TextStyle(
                                                  color: Theme.of(context)
                                                      .textTheme
                                                      .bodyText1!
                                                      .color,
                                                  fontSize:
                                                      16,
                                                  fontWeight: FontWeight
                                                      .w400),
                                              enabledBorder: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Theme.of(context)
                                                          .shadowColor),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10)),
                                              focusedBorder: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Theme.of(context).focusColor.withOpacity(
                                                          0.6)),
                                                  borderRadius:
                                                      BorderRadius.circular(10)),
                                              border: OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).shadowColor.withOpacity(0.4)), borderRadius: BorderRadius.circular(10))),
                                          cursorColor: Theme
                                                  .of(context)
                                              .textTheme
                                              .bodyText1!
                                              .color,
                                          style: TextStyle(
                                              color: Theme.of(
                                                      context)
                                                  .textTheme
                                                  .bodyText1!
                                                  .color,
                                              fontSize: 16,
                                              fontWeight:
                                                  FontWeight
                                                      .w400),
                                        ),
                                        const SizedBox(
                                            height: 20),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment
                                                  .end,
                                          children: [
                                            TextButton(
                                                onPressed:
                                                    () {
                                                  Navigator.of(
                                                          context)
                                                      .pop();
                                                },
                                                child:
                                                    const Text(
                                                  'Cancel',
                                                  style: TextStyle(
                                                      color: Colors
                                                          .red,
                                                      fontSize:
                                                          16,
                                                      fontWeight:
                                                          FontWeight.w400),
                                                )),
                                            TextButton(
                                                onPressed:
                                                    () {
                                                  setState(
                                                      () {
                                                    rooms.add(
                                                        roomNameController.text);
                                                    selectedRoom =
                                                        roomNameController.text;
                                                  });
                                                  Navigator.of(
                                                          context)
                                                      .pop();
                                                },
                                                child: Text(
                                                  'Add',
                                                  style: TextStyle(
                                                      color: Theme.of(context)
                                                          .focusColor,
                                                      fontSize:
                                                          16,
                                                      fontWeight:
                                                          FontWeight.w400),
                                                ))
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              });
                        },
                        icon: const Icon(Icons.add),
                        color: Theme.of(context).focusColor,
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),
                  //device type dropdown
                  DropdownButtonFormField(
                    value: selectedType,
                    decoration: InputDecoration(
                      labelText: 'Device Type',
                      labelStyle: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 16,
                          color: Theme.of(context)
                              .textTheme
                              .bodyText1!
                              .color),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .color!),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .color!),
                      ),
                    ),
                    items: DeviceType.values
                        .map((e) => DropdownMenuItem(
                              value: e,
                              child: Text(
                                e
                                    .toString()
                                    .split('.')
                                    .last
                                    .splitMapJoin(
                                      RegExp(r'[_]'),
                                      onMatch: (m) => ' ',
                                      onNonMatch: (n) =>
                                          n[0].toUpperCase() +
                                          n.substring(1),
                                    ),
                              ),
                            ))
                        .toList(),
                    hint: Text('Select Device Type',
                        style: TextStyle(
                            color: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .color)),
                    dropdownColor:
                        Theme.of(context).backgroundColor,
                    style: TextStyle(
                        color: Theme.of(context)
                            .textTheme
                            .bodyText1!
                            .color,
                        fontSize: 16,
                        fontWeight: FontWeight.w400),
                    borderRadius: BorderRadius.circular(10),
                    onChanged: (value) {
                      if (value != null) {
                        selectedType = value;
                      }
                    },
                  ),
                ],
              ),
            ),
            scrollable: true,
            //actions for the dialog
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('Cancel',
                    style: TextStyle(
                      color: Theme.of(context)
                          .textTheme
                          .bodyText1!
                          .color,
                    )),
              ),
              TextButton(
                onPressed: () {
                  if (nameController.text.isNotEmpty) {
                    device.name = nameController.text;
                    device.room = selectedRoom;
                    device.type = selectedType;
                    device.icon = selectedType
                        .toString()
                        .split('.')
                        .last;
                    nameController.clear();
                    BlocProvider.of<
                                DevicesElectronicDevicesCubit>(
                            context)
                        .updateDevice(device);
                    Navigator.of(context).pop();
                  } else {
                    ScaffoldMessenger.of(context)
                        .showSnackBar(
                      SnackBar(
                        content: const Text(
                            'Please enter a name'),
                        backgroundColor:
                            Theme.of(context).errorColor,
                      ),
                    );
                  }
                },
                child: Text(
                  'Save',
                  style: TextStyle(
                      color: Theme.of(context).focusColor),
                ),
              ),
            ],
          );
        });
      });
}
