// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'color_theme.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ColorTheme {

 Color get mainBackground; Color get onMainBackground; Color get mainBackground2; Color get primary; Color get onPrimary; Color get onPrimary2; Color get secondary; Color get onSecondary; Color get playerBackgroundText; Color get playerSign;
/// Create a copy of ColorTheme
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ColorThemeCopyWith<ColorTheme> get copyWith => _$ColorThemeCopyWithImpl<ColorTheme>(this as ColorTheme, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ColorTheme&&(identical(other.mainBackground, mainBackground) || other.mainBackground == mainBackground)&&(identical(other.onMainBackground, onMainBackground) || other.onMainBackground == onMainBackground)&&(identical(other.mainBackground2, mainBackground2) || other.mainBackground2 == mainBackground2)&&(identical(other.primary, primary) || other.primary == primary)&&(identical(other.onPrimary, onPrimary) || other.onPrimary == onPrimary)&&(identical(other.onPrimary2, onPrimary2) || other.onPrimary2 == onPrimary2)&&(identical(other.secondary, secondary) || other.secondary == secondary)&&(identical(other.onSecondary, onSecondary) || other.onSecondary == onSecondary)&&(identical(other.playerBackgroundText, playerBackgroundText) || other.playerBackgroundText == playerBackgroundText)&&(identical(other.playerSign, playerSign) || other.playerSign == playerSign));
}


@override
int get hashCode => Object.hash(runtimeType,mainBackground,onMainBackground,mainBackground2,primary,onPrimary,onPrimary2,secondary,onSecondary,playerBackgroundText,playerSign);

@override
String toString() {
  return 'ColorTheme(mainBackground: $mainBackground, onMainBackground: $onMainBackground, mainBackground2: $mainBackground2, primary: $primary, onPrimary: $onPrimary, onPrimary2: $onPrimary2, secondary: $secondary, onSecondary: $onSecondary, playerBackgroundText: $playerBackgroundText, playerSign: $playerSign)';
}


}

/// @nodoc
abstract mixin class $ColorThemeCopyWith<$Res>  {
  factory $ColorThemeCopyWith(ColorTheme value, $Res Function(ColorTheme) _then) = _$ColorThemeCopyWithImpl;
@useResult
$Res call({
 Color mainBackground, Color onMainBackground, Color mainBackground2, Color primary, Color onPrimary, Color onPrimary2, Color secondary, Color onSecondary, Color playerBackgroundText, Color playerSign
});




}
/// @nodoc
class _$ColorThemeCopyWithImpl<$Res>
    implements $ColorThemeCopyWith<$Res> {
  _$ColorThemeCopyWithImpl(this._self, this._then);

  final ColorTheme _self;
  final $Res Function(ColorTheme) _then;

/// Create a copy of ColorTheme
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? mainBackground = null,Object? onMainBackground = null,Object? mainBackground2 = null,Object? primary = null,Object? onPrimary = null,Object? onPrimary2 = null,Object? secondary = null,Object? onSecondary = null,Object? playerBackgroundText = null,Object? playerSign = null,}) {
  return _then(_self.copyWith(
mainBackground: null == mainBackground ? _self.mainBackground : mainBackground // ignore: cast_nullable_to_non_nullable
as Color,onMainBackground: null == onMainBackground ? _self.onMainBackground : onMainBackground // ignore: cast_nullable_to_non_nullable
as Color,mainBackground2: null == mainBackground2 ? _self.mainBackground2 : mainBackground2 // ignore: cast_nullable_to_non_nullable
as Color,primary: null == primary ? _self.primary : primary // ignore: cast_nullable_to_non_nullable
as Color,onPrimary: null == onPrimary ? _self.onPrimary : onPrimary // ignore: cast_nullable_to_non_nullable
as Color,onPrimary2: null == onPrimary2 ? _self.onPrimary2 : onPrimary2 // ignore: cast_nullable_to_non_nullable
as Color,secondary: null == secondary ? _self.secondary : secondary // ignore: cast_nullable_to_non_nullable
as Color,onSecondary: null == onSecondary ? _self.onSecondary : onSecondary // ignore: cast_nullable_to_non_nullable
as Color,playerBackgroundText: null == playerBackgroundText ? _self.playerBackgroundText : playerBackgroundText // ignore: cast_nullable_to_non_nullable
as Color,playerSign: null == playerSign ? _self.playerSign : playerSign // ignore: cast_nullable_to_non_nullable
as Color,
  ));
}

}


/// Adds pattern-matching-related methods to [ColorTheme].
extension ColorThemePatterns on ColorTheme {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ColorTheme value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ColorTheme() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ColorTheme value)  $default,){
final _that = this;
switch (_that) {
case _ColorTheme():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ColorTheme value)?  $default,){
final _that = this;
switch (_that) {
case _ColorTheme() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( Color mainBackground,  Color onMainBackground,  Color mainBackground2,  Color primary,  Color onPrimary,  Color onPrimary2,  Color secondary,  Color onSecondary,  Color playerBackgroundText,  Color playerSign)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ColorTheme() when $default != null:
return $default(_that.mainBackground,_that.onMainBackground,_that.mainBackground2,_that.primary,_that.onPrimary,_that.onPrimary2,_that.secondary,_that.onSecondary,_that.playerBackgroundText,_that.playerSign);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( Color mainBackground,  Color onMainBackground,  Color mainBackground2,  Color primary,  Color onPrimary,  Color onPrimary2,  Color secondary,  Color onSecondary,  Color playerBackgroundText,  Color playerSign)  $default,) {final _that = this;
switch (_that) {
case _ColorTheme():
return $default(_that.mainBackground,_that.onMainBackground,_that.mainBackground2,_that.primary,_that.onPrimary,_that.onPrimary2,_that.secondary,_that.onSecondary,_that.playerBackgroundText,_that.playerSign);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( Color mainBackground,  Color onMainBackground,  Color mainBackground2,  Color primary,  Color onPrimary,  Color onPrimary2,  Color secondary,  Color onSecondary,  Color playerBackgroundText,  Color playerSign)?  $default,) {final _that = this;
switch (_that) {
case _ColorTheme() when $default != null:
return $default(_that.mainBackground,_that.onMainBackground,_that.mainBackground2,_that.primary,_that.onPrimary,_that.onPrimary2,_that.secondary,_that.onSecondary,_that.playerBackgroundText,_that.playerSign);case _:
  return null;

}
}

}

/// @nodoc


class _ColorTheme implements ColorTheme {
   _ColorTheme({required this.mainBackground, required this.onMainBackground, required this.mainBackground2, required this.primary, required this.onPrimary, required this.onPrimary2, required this.secondary, required this.onSecondary, required this.playerBackgroundText, required this.playerSign});
  

@override final  Color mainBackground;
@override final  Color onMainBackground;
@override final  Color mainBackground2;
@override final  Color primary;
@override final  Color onPrimary;
@override final  Color onPrimary2;
@override final  Color secondary;
@override final  Color onSecondary;
@override final  Color playerBackgroundText;
@override final  Color playerSign;

/// Create a copy of ColorTheme
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ColorThemeCopyWith<_ColorTheme> get copyWith => __$ColorThemeCopyWithImpl<_ColorTheme>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ColorTheme&&(identical(other.mainBackground, mainBackground) || other.mainBackground == mainBackground)&&(identical(other.onMainBackground, onMainBackground) || other.onMainBackground == onMainBackground)&&(identical(other.mainBackground2, mainBackground2) || other.mainBackground2 == mainBackground2)&&(identical(other.primary, primary) || other.primary == primary)&&(identical(other.onPrimary, onPrimary) || other.onPrimary == onPrimary)&&(identical(other.onPrimary2, onPrimary2) || other.onPrimary2 == onPrimary2)&&(identical(other.secondary, secondary) || other.secondary == secondary)&&(identical(other.onSecondary, onSecondary) || other.onSecondary == onSecondary)&&(identical(other.playerBackgroundText, playerBackgroundText) || other.playerBackgroundText == playerBackgroundText)&&(identical(other.playerSign, playerSign) || other.playerSign == playerSign));
}


@override
int get hashCode => Object.hash(runtimeType,mainBackground,onMainBackground,mainBackground2,primary,onPrimary,onPrimary2,secondary,onSecondary,playerBackgroundText,playerSign);

@override
String toString() {
  return 'ColorTheme(mainBackground: $mainBackground, onMainBackground: $onMainBackground, mainBackground2: $mainBackground2, primary: $primary, onPrimary: $onPrimary, onPrimary2: $onPrimary2, secondary: $secondary, onSecondary: $onSecondary, playerBackgroundText: $playerBackgroundText, playerSign: $playerSign)';
}


}

/// @nodoc
abstract mixin class _$ColorThemeCopyWith<$Res> implements $ColorThemeCopyWith<$Res> {
  factory _$ColorThemeCopyWith(_ColorTheme value, $Res Function(_ColorTheme) _then) = __$ColorThemeCopyWithImpl;
@override @useResult
$Res call({
 Color mainBackground, Color onMainBackground, Color mainBackground2, Color primary, Color onPrimary, Color onPrimary2, Color secondary, Color onSecondary, Color playerBackgroundText, Color playerSign
});




}
/// @nodoc
class __$ColorThemeCopyWithImpl<$Res>
    implements _$ColorThemeCopyWith<$Res> {
  __$ColorThemeCopyWithImpl(this._self, this._then);

  final _ColorTheme _self;
  final $Res Function(_ColorTheme) _then;

/// Create a copy of ColorTheme
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? mainBackground = null,Object? onMainBackground = null,Object? mainBackground2 = null,Object? primary = null,Object? onPrimary = null,Object? onPrimary2 = null,Object? secondary = null,Object? onSecondary = null,Object? playerBackgroundText = null,Object? playerSign = null,}) {
  return _then(_ColorTheme(
mainBackground: null == mainBackground ? _self.mainBackground : mainBackground // ignore: cast_nullable_to_non_nullable
as Color,onMainBackground: null == onMainBackground ? _self.onMainBackground : onMainBackground // ignore: cast_nullable_to_non_nullable
as Color,mainBackground2: null == mainBackground2 ? _self.mainBackground2 : mainBackground2 // ignore: cast_nullable_to_non_nullable
as Color,primary: null == primary ? _self.primary : primary // ignore: cast_nullable_to_non_nullable
as Color,onPrimary: null == onPrimary ? _self.onPrimary : onPrimary // ignore: cast_nullable_to_non_nullable
as Color,onPrimary2: null == onPrimary2 ? _self.onPrimary2 : onPrimary2 // ignore: cast_nullable_to_non_nullable
as Color,secondary: null == secondary ? _self.secondary : secondary // ignore: cast_nullable_to_non_nullable
as Color,onSecondary: null == onSecondary ? _self.onSecondary : onSecondary // ignore: cast_nullable_to_non_nullable
as Color,playerBackgroundText: null == playerBackgroundText ? _self.playerBackgroundText : playerBackgroundText // ignore: cast_nullable_to_non_nullable
as Color,playerSign: null == playerSign ? _self.playerSign : playerSign // ignore: cast_nullable_to_non_nullable
as Color,
  ));
}


}

// dart format on
