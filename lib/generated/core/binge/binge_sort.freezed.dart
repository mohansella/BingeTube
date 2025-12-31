// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of '../../../core/binge/binge_sort.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$BingeSort {

 BingeSortType get sortType; BingeSortOrder get sortOrder;
/// Create a copy of BingeSort
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BingeSortCopyWith<BingeSort> get copyWith => _$BingeSortCopyWithImpl<BingeSort>(this as BingeSort, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BingeSort&&(identical(other.sortType, sortType) || other.sortType == sortType)&&(identical(other.sortOrder, sortOrder) || other.sortOrder == sortOrder));
}


@override
int get hashCode => Object.hash(runtimeType,sortType,sortOrder);

@override
String toString() {
  return 'BingeSort(sortType: $sortType, sortOrder: $sortOrder)';
}


}

/// @nodoc
abstract mixin class $BingeSortCopyWith<$Res>  {
  factory $BingeSortCopyWith(BingeSort value, $Res Function(BingeSort) _then) = _$BingeSortCopyWithImpl;
@useResult
$Res call({
 BingeSortType sortType, BingeSortOrder sortOrder
});




}
/// @nodoc
class _$BingeSortCopyWithImpl<$Res>
    implements $BingeSortCopyWith<$Res> {
  _$BingeSortCopyWithImpl(this._self, this._then);

  final BingeSort _self;
  final $Res Function(BingeSort) _then;

/// Create a copy of BingeSort
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? sortType = null,Object? sortOrder = null,}) {
  return _then(_self.copyWith(
sortType: null == sortType ? _self.sortType : sortType // ignore: cast_nullable_to_non_nullable
as BingeSortType,sortOrder: null == sortOrder ? _self.sortOrder : sortOrder // ignore: cast_nullable_to_non_nullable
as BingeSortOrder,
  ));
}

}


/// Adds pattern-matching-related methods to [BingeSort].
extension BingeSortPatterns on BingeSort {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BingeSort value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BingeSort() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BingeSort value)  $default,){
final _that = this;
switch (_that) {
case _BingeSort():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BingeSort value)?  $default,){
final _that = this;
switch (_that) {
case _BingeSort() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( BingeSortType sortType,  BingeSortOrder sortOrder)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BingeSort() when $default != null:
return $default(_that.sortType,_that.sortOrder);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( BingeSortType sortType,  BingeSortOrder sortOrder)  $default,) {final _that = this;
switch (_that) {
case _BingeSort():
return $default(_that.sortType,_that.sortOrder);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( BingeSortType sortType,  BingeSortOrder sortOrder)?  $default,) {final _that = this;
switch (_that) {
case _BingeSort() when $default != null:
return $default(_that.sortType,_that.sortOrder);case _:
  return null;

}
}

}

/// @nodoc


class _BingeSort extends BingeSort {
  const _BingeSort({required this.sortType, required this.sortOrder}): super._();
  

@override final  BingeSortType sortType;
@override final  BingeSortOrder sortOrder;

/// Create a copy of BingeSort
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BingeSortCopyWith<_BingeSort> get copyWith => __$BingeSortCopyWithImpl<_BingeSort>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BingeSort&&(identical(other.sortType, sortType) || other.sortType == sortType)&&(identical(other.sortOrder, sortOrder) || other.sortOrder == sortOrder));
}


@override
int get hashCode => Object.hash(runtimeType,sortType,sortOrder);

@override
String toString() {
  return 'BingeSort(sortType: $sortType, sortOrder: $sortOrder)';
}


}

/// @nodoc
abstract mixin class _$BingeSortCopyWith<$Res> implements $BingeSortCopyWith<$Res> {
  factory _$BingeSortCopyWith(_BingeSort value, $Res Function(_BingeSort) _then) = __$BingeSortCopyWithImpl;
@override @useResult
$Res call({
 BingeSortType sortType, BingeSortOrder sortOrder
});




}
/// @nodoc
class __$BingeSortCopyWithImpl<$Res>
    implements _$BingeSortCopyWith<$Res> {
  __$BingeSortCopyWithImpl(this._self, this._then);

  final _BingeSort _self;
  final $Res Function(_BingeSort) _then;

/// Create a copy of BingeSort
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? sortType = null,Object? sortOrder = null,}) {
  return _then(_BingeSort(
sortType: null == sortType ? _self.sortType : sortType // ignore: cast_nullable_to_non_nullable
as BingeSortType,sortOrder: null == sortOrder ? _self.sortOrder : sortOrder // ignore: cast_nullable_to_non_nullable
as BingeSortOrder,
  ));
}


}

// dart format on
