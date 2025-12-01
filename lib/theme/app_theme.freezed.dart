// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'app_theme.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$AppThemeData {

 AppBrightness get brightness; ColorTheme get color; String get backgroundAssetPath;
/// Create a copy of AppThemeData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AppThemeDataCopyWith<AppThemeData> get copyWith => _$AppThemeDataCopyWithImpl<AppThemeData>(this as AppThemeData, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AppThemeData&&(identical(other.brightness, brightness) || other.brightness == brightness)&&(identical(other.color, color) || other.color == color)&&(identical(other.backgroundAssetPath, backgroundAssetPath) || other.backgroundAssetPath == backgroundAssetPath));
}


@override
int get hashCode => Object.hash(runtimeType,brightness,color,backgroundAssetPath);

@override
String toString() {
  return 'AppThemeData(brightness: $brightness, color: $color, backgroundAssetPath: $backgroundAssetPath)';
}


}

/// @nodoc
abstract mixin class $AppThemeDataCopyWith<$Res>  {
  factory $AppThemeDataCopyWith(AppThemeData value, $Res Function(AppThemeData) _then) = _$AppThemeDataCopyWithImpl;
@useResult
$Res call({
 AppBrightness brightness, ColorTheme color, String backgroundAssetPath
});


$ColorThemeCopyWith<$Res> get color;

}
/// @nodoc
class _$AppThemeDataCopyWithImpl<$Res>
    implements $AppThemeDataCopyWith<$Res> {
  _$AppThemeDataCopyWithImpl(this._self, this._then);

  final AppThemeData _self;
  final $Res Function(AppThemeData) _then;

/// Create a copy of AppThemeData
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? brightness = null,Object? color = null,Object? backgroundAssetPath = null,}) {
  return _then(_self.copyWith(
brightness: null == brightness ? _self.brightness : brightness // ignore: cast_nullable_to_non_nullable
as AppBrightness,color: null == color ? _self.color : color // ignore: cast_nullable_to_non_nullable
as ColorTheme,backgroundAssetPath: null == backgroundAssetPath ? _self.backgroundAssetPath : backgroundAssetPath // ignore: cast_nullable_to_non_nullable
as String,
  ));
}
/// Create a copy of AppThemeData
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ColorThemeCopyWith<$Res> get color {
  
  return $ColorThemeCopyWith<$Res>(_self.color, (value) {
    return _then(_self.copyWith(color: value));
  });
}
}


/// Adds pattern-matching-related methods to [AppThemeData].
extension AppThemeDataPatterns on AppThemeData {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AppThemeData value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AppThemeData() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AppThemeData value)  $default,){
final _that = this;
switch (_that) {
case _AppThemeData():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AppThemeData value)?  $default,){
final _that = this;
switch (_that) {
case _AppThemeData() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( AppBrightness brightness,  ColorTheme color,  String backgroundAssetPath)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AppThemeData() when $default != null:
return $default(_that.brightness,_that.color,_that.backgroundAssetPath);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( AppBrightness brightness,  ColorTheme color,  String backgroundAssetPath)  $default,) {final _that = this;
switch (_that) {
case _AppThemeData():
return $default(_that.brightness,_that.color,_that.backgroundAssetPath);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( AppBrightness brightness,  ColorTheme color,  String backgroundAssetPath)?  $default,) {final _that = this;
switch (_that) {
case _AppThemeData() when $default != null:
return $default(_that.brightness,_that.color,_that.backgroundAssetPath);case _:
  return null;

}
}

}

/// @nodoc


class _AppThemeData implements AppThemeData {
  const _AppThemeData({required this.brightness, required this.color, required this.backgroundAssetPath});
  

@override final  AppBrightness brightness;
@override final  ColorTheme color;
@override final  String backgroundAssetPath;

/// Create a copy of AppThemeData
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AppThemeDataCopyWith<_AppThemeData> get copyWith => __$AppThemeDataCopyWithImpl<_AppThemeData>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AppThemeData&&(identical(other.brightness, brightness) || other.brightness == brightness)&&(identical(other.color, color) || other.color == color)&&(identical(other.backgroundAssetPath, backgroundAssetPath) || other.backgroundAssetPath == backgroundAssetPath));
}


@override
int get hashCode => Object.hash(runtimeType,brightness,color,backgroundAssetPath);

@override
String toString() {
  return 'AppThemeData(brightness: $brightness, color: $color, backgroundAssetPath: $backgroundAssetPath)';
}


}

/// @nodoc
abstract mixin class _$AppThemeDataCopyWith<$Res> implements $AppThemeDataCopyWith<$Res> {
  factory _$AppThemeDataCopyWith(_AppThemeData value, $Res Function(_AppThemeData) _then) = __$AppThemeDataCopyWithImpl;
@override @useResult
$Res call({
 AppBrightness brightness, ColorTheme color, String backgroundAssetPath
});


@override $ColorThemeCopyWith<$Res> get color;

}
/// @nodoc
class __$AppThemeDataCopyWithImpl<$Res>
    implements _$AppThemeDataCopyWith<$Res> {
  __$AppThemeDataCopyWithImpl(this._self, this._then);

  final _AppThemeData _self;
  final $Res Function(_AppThemeData) _then;

/// Create a copy of AppThemeData
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? brightness = null,Object? color = null,Object? backgroundAssetPath = null,}) {
  return _then(_AppThemeData(
brightness: null == brightness ? _self.brightness : brightness // ignore: cast_nullable_to_non_nullable
as AppBrightness,color: null == color ? _self.color : color // ignore: cast_nullable_to_non_nullable
as ColorTheme,backgroundAssetPath: null == backgroundAssetPath ? _self.backgroundAssetPath : backgroundAssetPath // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

/// Create a copy of AppThemeData
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ColorThemeCopyWith<$Res> get color {
  
  return $ColorThemeCopyWith<$Res>(_self.color, (value) {
    return _then(_self.copyWith(color: value));
  });
}
}

// dart format on
