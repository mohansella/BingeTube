// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of '../../../pages/binge/binge_filter.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$BingeFilter {

 BingeFilterWatchType get watchType; BingeFilterSortOrder get sortOder; BingeFilterSortType get sortType; String? get searchValue;
/// Create a copy of BingeFilter
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BingeFilterCopyWith<BingeFilter> get copyWith => _$BingeFilterCopyWithImpl<BingeFilter>(this as BingeFilter, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BingeFilter&&(identical(other.watchType, watchType) || other.watchType == watchType)&&(identical(other.sortOder, sortOder) || other.sortOder == sortOder)&&(identical(other.sortType, sortType) || other.sortType == sortType)&&(identical(other.searchValue, searchValue) || other.searchValue == searchValue));
}


@override
int get hashCode => Object.hash(runtimeType,watchType,sortOder,sortType,searchValue);

@override
String toString() {
  return 'BingeFilter(watchType: $watchType, sortOder: $sortOder, sortType: $sortType, searchValue: $searchValue)';
}


}

/// @nodoc
abstract mixin class $BingeFilterCopyWith<$Res>  {
  factory $BingeFilterCopyWith(BingeFilter value, $Res Function(BingeFilter) _then) = _$BingeFilterCopyWithImpl;
@useResult
$Res call({
 BingeFilterWatchType watchType, BingeFilterSortOrder sortOder, BingeFilterSortType sortType, String? searchValue
});




}
/// @nodoc
class _$BingeFilterCopyWithImpl<$Res>
    implements $BingeFilterCopyWith<$Res> {
  _$BingeFilterCopyWithImpl(this._self, this._then);

  final BingeFilter _self;
  final $Res Function(BingeFilter) _then;

/// Create a copy of BingeFilter
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? watchType = null,Object? sortOder = null,Object? sortType = null,Object? searchValue = freezed,}) {
  return _then(_self.copyWith(
watchType: null == watchType ? _self.watchType : watchType // ignore: cast_nullable_to_non_nullable
as BingeFilterWatchType,sortOder: null == sortOder ? _self.sortOder : sortOder // ignore: cast_nullable_to_non_nullable
as BingeFilterSortOrder,sortType: null == sortType ? _self.sortType : sortType // ignore: cast_nullable_to_non_nullable
as BingeFilterSortType,searchValue: freezed == searchValue ? _self.searchValue : searchValue // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [BingeFilter].
extension BingeFilterPatterns on BingeFilter {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BingeFilter value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BingeFilter() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BingeFilter value)  $default,){
final _that = this;
switch (_that) {
case _BingeFilter():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BingeFilter value)?  $default,){
final _that = this;
switch (_that) {
case _BingeFilter() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( BingeFilterWatchType watchType,  BingeFilterSortOrder sortOder,  BingeFilterSortType sortType,  String? searchValue)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BingeFilter() when $default != null:
return $default(_that.watchType,_that.sortOder,_that.sortType,_that.searchValue);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( BingeFilterWatchType watchType,  BingeFilterSortOrder sortOder,  BingeFilterSortType sortType,  String? searchValue)  $default,) {final _that = this;
switch (_that) {
case _BingeFilter():
return $default(_that.watchType,_that.sortOder,_that.sortType,_that.searchValue);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( BingeFilterWatchType watchType,  BingeFilterSortOrder sortOder,  BingeFilterSortType sortType,  String? searchValue)?  $default,) {final _that = this;
switch (_that) {
case _BingeFilter() when $default != null:
return $default(_that.watchType,_that.sortOder,_that.sortType,_that.searchValue);case _:
  return null;

}
}

}

/// @nodoc


class _BingeFilter implements BingeFilter {
  const _BingeFilter({required this.watchType, required this.sortOder, required this.sortType, required this.searchValue});
  

@override final  BingeFilterWatchType watchType;
@override final  BingeFilterSortOrder sortOder;
@override final  BingeFilterSortType sortType;
@override final  String? searchValue;

/// Create a copy of BingeFilter
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BingeFilterCopyWith<_BingeFilter> get copyWith => __$BingeFilterCopyWithImpl<_BingeFilter>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BingeFilter&&(identical(other.watchType, watchType) || other.watchType == watchType)&&(identical(other.sortOder, sortOder) || other.sortOder == sortOder)&&(identical(other.sortType, sortType) || other.sortType == sortType)&&(identical(other.searchValue, searchValue) || other.searchValue == searchValue));
}


@override
int get hashCode => Object.hash(runtimeType,watchType,sortOder,sortType,searchValue);

@override
String toString() {
  return 'BingeFilter(watchType: $watchType, sortOder: $sortOder, sortType: $sortType, searchValue: $searchValue)';
}


}

/// @nodoc
abstract mixin class _$BingeFilterCopyWith<$Res> implements $BingeFilterCopyWith<$Res> {
  factory _$BingeFilterCopyWith(_BingeFilter value, $Res Function(_BingeFilter) _then) = __$BingeFilterCopyWithImpl;
@override @useResult
$Res call({
 BingeFilterWatchType watchType, BingeFilterSortOrder sortOder, BingeFilterSortType sortType, String? searchValue
});




}
/// @nodoc
class __$BingeFilterCopyWithImpl<$Res>
    implements _$BingeFilterCopyWith<$Res> {
  __$BingeFilterCopyWithImpl(this._self, this._then);

  final _BingeFilter _self;
  final $Res Function(_BingeFilter) _then;

/// Create a copy of BingeFilter
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? watchType = null,Object? sortOder = null,Object? sortType = null,Object? searchValue = freezed,}) {
  return _then(_BingeFilter(
watchType: null == watchType ? _self.watchType : watchType // ignore: cast_nullable_to_non_nullable
as BingeFilterWatchType,sortOder: null == sortOder ? _self.sortOder : sortOder // ignore: cast_nullable_to_non_nullable
as BingeFilterSortOrder,sortType: null == sortType ? _self.sortType : sortType // ignore: cast_nullable_to_non_nullable
as BingeFilterSortType,searchValue: freezed == searchValue ? _self.searchValue : searchValue // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
