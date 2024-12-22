// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'point_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PointModelImpl _$$PointModelImplFromJson(Map<String, dynamic> json) =>
    _$PointModelImpl(
      name: json['name'] as String? ?? '',
      lat: (json['lat'] as num?)?.toDouble() ?? 0.0,
      lon: (json['lon'] as num?)?.toDouble() ?? 0.0,
    );

Map<String, dynamic> _$$PointModelImplToJson(_$PointModelImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'lat': instance.lat,
      'lon': instance.lon,
    };
