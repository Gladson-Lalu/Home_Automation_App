// GENERATED CODE - DO NOT MODIFY BY HAND
// This code was generated by ObjectBox. To update it run the generator again:
// With a Flutter package, run `flutter pub run build_runner build`.
// With a Dart package, run `dart run build_runner build`.
// See also https://docs.objectbox.io/getting-started#generate-objectbox-code

// ignore_for_file: camel_case_types
// coverage:ignore-file

import 'dart:typed_data';

import 'package:flat_buffers/flat_buffers.dart' as fb;
import 'package:objectbox/internal.dart'; // generated code can access "internal" functionality
import 'package:objectbox/objectbox.dart';
import 'package:objectbox_flutter_libs/objectbox_flutter_libs.dart';

import 'domain/model/device.dart';

export 'package:objectbox/objectbox.dart'; // so that callers only have to import this file

final _entities = <ModelEntity>[
  ModelEntity(
      id: const IdUid(5, 103902490568200414),
      name: 'ElectronicDevice',
      lastPropertyId: const IdUid(8, 2572104495178499985),
      flags: 0,
      properties: <ModelProperty>[
        ModelProperty(
            id: const IdUid(1, 169555659793757554),
            name: 'id',
            type: 6,
            flags: 129),
        ModelProperty(
            id: const IdUid(2, 586847949906433414),
            name: 'name',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(3, 5575958208288376553),
            name: 'room',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(5, 7154527879649978527),
            name: 'isConnected',
            type: 1,
            flags: 0),
        ModelProperty(
            id: const IdUid(6, 7842010971402161182),
            name: 'icon',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(7, 5868241358691030961),
            name: 'state',
            type: 1,
            flags: 0),
        ModelProperty(
            id: const IdUid(8, 2572104495178499985),
            name: 'typeValue',
            type: 6,
            flags: 0)
      ],
      relations: <ModelRelation>[],
      backlinks: <ModelBacklink>[])
];

/// Open an ObjectBox store with the model declared in this file.
Future<Store> openStore(
        {String? directory,
        int? maxDBSizeInKB,
        int? fileMode,
        int? maxReaders,
        bool queriesCaseSensitiveDefault = true,
        String? macosApplicationGroup}) async =>
    Store(getObjectBoxModel(),
        directory: directory ?? (await defaultStoreDirectory()).path,
        maxDBSizeInKB: maxDBSizeInKB,
        fileMode: fileMode,
        maxReaders: maxReaders,
        queriesCaseSensitiveDefault: queriesCaseSensitiveDefault,
        macosApplicationGroup: macosApplicationGroup);

/// ObjectBox model definition, pass it to [Store] - Store(getObjectBoxModel())
ModelDefinition getObjectBoxModel() {
  final model = ModelInfo(
      entities: _entities,
      lastEntityId: const IdUid(5, 103902490568200414),
      lastIndexId: const IdUid(0, 0),
      lastRelationId: const IdUid(0, 0),
      lastSequenceId: const IdUid(0, 0),
      retiredEntityUids: const [
        846025736934660011,
        5471299033161570165,
        7072457029822021612,
        1024470043022513100
      ],
      retiredIndexUids: const [],
      retiredPropertyUids: const [
        5305640603830175744,
        2102171731464610208,
        7630104142082930269,
        695907131009546227,
        8047536908192972114,
        82190003123334376,
        3574667088172890905,
        5463135518791484504,
        1359491938705732668,
        8461759583901862196,
        8556243042324637685,
        3495025484979034544,
        4880865798373852944,
        1457729864447622990,
        8202452046333383712,
        6856425798372286289,
        9198817241102697427,
        7985582326777885322,
        560089055825997664,
        5165459659119541109,
        2382265933627953243
      ],
      retiredRelationUids: const [],
      modelVersion: 5,
      modelVersionParserMinimum: 5,
      version: 1);

  final bindings = <Type, EntityDefinition>{
    ElectronicDevice: EntityDefinition<ElectronicDevice>(
        model: _entities[0],
        toOneRelations: (ElectronicDevice object) => [],
        toManyRelations: (ElectronicDevice object) => {},
        getId: (ElectronicDevice object) => object.id,
        setId: (ElectronicDevice object, int id) {
          object.id = id;
        },
        objectToFB: (ElectronicDevice object, fb.Builder fbb) {
          final nameOffset = fbb.writeString(object.name);
          final roomOffset = fbb.writeString(object.room);
          final iconOffset = fbb.writeString(object.icon);
          fbb.startTable(9);
          fbb.addInt64(0, object.id);
          fbb.addOffset(1, nameOffset);
          fbb.addOffset(2, roomOffset);
          fbb.addBool(4, object.isConnected);
          fbb.addOffset(5, iconOffset);
          fbb.addBool(6, object.state);
          fbb.addInt64(7, object.typeValue);
          fbb.finish(fbb.endTable());
          return object.id;
        },
        objectFromFB: (Store store, ByteData fbData) {
          final buffer = fb.BufferContext(fbData);
          final rootOffset = buffer.derefObject(0);

          final object = ElectronicDevice(
              id: const fb.Int64Reader().vTableGet(buffer, rootOffset, 4, 0),
              isConnected: const fb.BoolReader()
                  .vTableGet(buffer, rootOffset, 12, false),
              name: const fb.StringReader(asciiOptimization: true)
                  .vTableGet(buffer, rootOffset, 6, ''),
              room: const fb.StringReader(asciiOptimization: true)
                  .vTableGet(buffer, rootOffset, 8, ''),
              icon: const fb.StringReader(asciiOptimization: true)
                  .vTableGet(buffer, rootOffset, 14, ''),
              state: const fb.BoolReader()
                  .vTableGet(buffer, rootOffset, 16, false))
            ..typeValue =
                const fb.Int64Reader().vTableGet(buffer, rootOffset, 18, 0);

          return object;
        })
  };

  return ModelDefinition(model, bindings);
}

/// [ElectronicDevice] entity fields to define ObjectBox queries.
class ElectronicDevice_ {
  /// see [ElectronicDevice.id]
  static final id =
      QueryIntegerProperty<ElectronicDevice>(_entities[0].properties[0]);

  /// see [ElectronicDevice.name]
  static final name =
      QueryStringProperty<ElectronicDevice>(_entities[0].properties[1]);

  /// see [ElectronicDevice.room]
  static final room =
      QueryStringProperty<ElectronicDevice>(_entities[0].properties[2]);

  /// see [ElectronicDevice.isConnected]
  static final isConnected =
      QueryBooleanProperty<ElectronicDevice>(_entities[0].properties[3]);

  /// see [ElectronicDevice.icon]
  static final icon =
      QueryStringProperty<ElectronicDevice>(_entities[0].properties[4]);

  /// see [ElectronicDevice.state]
  static final state =
      QueryBooleanProperty<ElectronicDevice>(_entities[0].properties[5]);

  /// see [ElectronicDevice.typeValue]
  static final typeValue =
      QueryIntegerProperty<ElectronicDevice>(_entities[0].properties[6]);
}