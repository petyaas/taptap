import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:json_annotation/json_annotation.dart';


part 'point_model.freezed.dart';

part 'point_model.g.dart';

@Freezed()
class PointModel with _$PointModel {
  const factory PointModel({
    @Default('') String name,
    @Default(0.0) double lat,
    @Default(0.0) double lon,
  }) = _PointModel;

  factory PointModel.fromJson(Map<String, dynamic> json) => _$PointModelFromJson(json);
}
