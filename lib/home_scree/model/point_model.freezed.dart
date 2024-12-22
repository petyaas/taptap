// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'point_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

PointModel _$PointModelFromJson(Map<String, dynamic> json) {
  return _PointModel.fromJson(json);
}

/// @nodoc
mixin _$PointModel {
  String get name => throw _privateConstructorUsedError;
  double get lat => throw _privateConstructorUsedError;
  double get lon => throw _privateConstructorUsedError;

  /// Serializes this PointModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PointModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PointModelCopyWith<PointModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PointModelCopyWith<$Res> {
  factory $PointModelCopyWith(
          PointModel value, $Res Function(PointModel) then) =
      _$PointModelCopyWithImpl<$Res, PointModel>;
  @useResult
  $Res call({String name, double lat, double lon});
}

/// @nodoc
class _$PointModelCopyWithImpl<$Res, $Val extends PointModel>
    implements $PointModelCopyWith<$Res> {
  _$PointModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PointModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? lat = null,
    Object? lon = null,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      lat: null == lat
          ? _value.lat
          : lat // ignore: cast_nullable_to_non_nullable
              as double,
      lon: null == lon
          ? _value.lon
          : lon // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PointModelImplCopyWith<$Res>
    implements $PointModelCopyWith<$Res> {
  factory _$$PointModelImplCopyWith(
          _$PointModelImpl value, $Res Function(_$PointModelImpl) then) =
      __$$PointModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String name, double lat, double lon});
}

/// @nodoc
class __$$PointModelImplCopyWithImpl<$Res>
    extends _$PointModelCopyWithImpl<$Res, _$PointModelImpl>
    implements _$$PointModelImplCopyWith<$Res> {
  __$$PointModelImplCopyWithImpl(
      _$PointModelImpl _value, $Res Function(_$PointModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of PointModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? lat = null,
    Object? lon = null,
  }) {
    return _then(_$PointModelImpl(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      lat: null == lat
          ? _value.lat
          : lat // ignore: cast_nullable_to_non_nullable
              as double,
      lon: null == lon
          ? _value.lon
          : lon // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PointModelImpl implements _PointModel {
  const _$PointModelImpl({this.name = '', this.lat = 0.0, this.lon = 0.0});

  factory _$PointModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$PointModelImplFromJson(json);

  @override
  @JsonKey()
  final String name;
  @override
  @JsonKey()
  final double lat;
  @override
  @JsonKey()
  final double lon;

  @override
  String toString() {
    return 'PointModel(name: $name, lat: $lat, lon: $lon)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PointModelImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.lat, lat) || other.lat == lat) &&
            (identical(other.lon, lon) || other.lon == lon));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, name, lat, lon);

  /// Create a copy of PointModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PointModelImplCopyWith<_$PointModelImpl> get copyWith =>
      __$$PointModelImplCopyWithImpl<_$PointModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PointModelImplToJson(
      this,
    );
  }
}

abstract class _PointModel implements PointModel {
  const factory _PointModel(
      {final String name,
      final double lat,
      final double lon}) = _$PointModelImpl;

  factory _PointModel.fromJson(Map<String, dynamic> json) =
      _$PointModelImpl.fromJson;

  @override
  String get name;
  @override
  double get lat;
  @override
  double get lon;

  /// Create a copy of PointModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PointModelImplCopyWith<_$PointModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
