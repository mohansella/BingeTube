// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of '../../../../core/db/models/binge_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$BingeModel {

 String get title; String get description; List<VideoModel> get videos; int? get priority; int? get collectionId;
/// Create a copy of BingeModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BingeModelCopyWith<BingeModel> get copyWith => _$BingeModelCopyWithImpl<BingeModel>(this as BingeModel, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BingeModel&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&const DeepCollectionEquality().equals(other.videos, videos)&&(identical(other.priority, priority) || other.priority == priority)&&(identical(other.collectionId, collectionId) || other.collectionId == collectionId));
}


@override
int get hashCode => Object.hash(runtimeType,title,description,const DeepCollectionEquality().hash(videos),priority,collectionId);

@override
String toString() {
  return 'BingeModel(title: $title, description: $description, videos: $videos, priority: $priority, collectionId: $collectionId)';
}


}

/// @nodoc
abstract mixin class $BingeModelCopyWith<$Res>  {
  factory $BingeModelCopyWith(BingeModel value, $Res Function(BingeModel) _then) = _$BingeModelCopyWithImpl;
@useResult
$Res call({
 String title, String description, List<VideoModel> videos, int? priority, int? collectionId
});




}
/// @nodoc
class _$BingeModelCopyWithImpl<$Res>
    implements $BingeModelCopyWith<$Res> {
  _$BingeModelCopyWithImpl(this._self, this._then);

  final BingeModel _self;
  final $Res Function(BingeModel) _then;

/// Create a copy of BingeModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? title = null,Object? description = null,Object? videos = null,Object? priority = freezed,Object? collectionId = freezed,}) {
  return _then(_self.copyWith(
title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,videos: null == videos ? _self.videos : videos // ignore: cast_nullable_to_non_nullable
as List<VideoModel>,priority: freezed == priority ? _self.priority : priority // ignore: cast_nullable_to_non_nullable
as int?,collectionId: freezed == collectionId ? _self.collectionId : collectionId // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

}


/// Adds pattern-matching-related methods to [BingeModel].
extension BingeModelPatterns on BingeModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BingeModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BingeModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BingeModel value)  $default,){
final _that = this;
switch (_that) {
case _BingeModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BingeModel value)?  $default,){
final _that = this;
switch (_that) {
case _BingeModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String title,  String description,  List<VideoModel> videos,  int? priority,  int? collectionId)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BingeModel() when $default != null:
return $default(_that.title,_that.description,_that.videos,_that.priority,_that.collectionId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String title,  String description,  List<VideoModel> videos,  int? priority,  int? collectionId)  $default,) {final _that = this;
switch (_that) {
case _BingeModel():
return $default(_that.title,_that.description,_that.videos,_that.priority,_that.collectionId);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String title,  String description,  List<VideoModel> videos,  int? priority,  int? collectionId)?  $default,) {final _that = this;
switch (_that) {
case _BingeModel() when $default != null:
return $default(_that.title,_that.description,_that.videos,_that.priority,_that.collectionId);case _:
  return null;

}
}

}

/// @nodoc


class _BingeModel extends BingeModel {
  const _BingeModel({required this.title, required this.description, required final  List<VideoModel> videos, this.priority, this.collectionId}): _videos = videos,super._();
  

@override final  String title;
@override final  String description;
 final  List<VideoModel> _videos;
@override List<VideoModel> get videos {
  if (_videos is EqualUnmodifiableListView) return _videos;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_videos);
}

@override final  int? priority;
@override final  int? collectionId;

/// Create a copy of BingeModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BingeModelCopyWith<_BingeModel> get copyWith => __$BingeModelCopyWithImpl<_BingeModel>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BingeModel&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&const DeepCollectionEquality().equals(other._videos, _videos)&&(identical(other.priority, priority) || other.priority == priority)&&(identical(other.collectionId, collectionId) || other.collectionId == collectionId));
}


@override
int get hashCode => Object.hash(runtimeType,title,description,const DeepCollectionEquality().hash(_videos),priority,collectionId);

@override
String toString() {
  return 'BingeModel(title: $title, description: $description, videos: $videos, priority: $priority, collectionId: $collectionId)';
}


}

/// @nodoc
abstract mixin class _$BingeModelCopyWith<$Res> implements $BingeModelCopyWith<$Res> {
  factory _$BingeModelCopyWith(_BingeModel value, $Res Function(_BingeModel) _then) = __$BingeModelCopyWithImpl;
@override @useResult
$Res call({
 String title, String description, List<VideoModel> videos, int? priority, int? collectionId
});




}
/// @nodoc
class __$BingeModelCopyWithImpl<$Res>
    implements _$BingeModelCopyWith<$Res> {
  __$BingeModelCopyWithImpl(this._self, this._then);

  final _BingeModel _self;
  final $Res Function(_BingeModel) _then;

/// Create a copy of BingeModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? title = null,Object? description = null,Object? videos = null,Object? priority = freezed,Object? collectionId = freezed,}) {
  return _then(_BingeModel(
title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,videos: null == videos ? _self._videos : videos // ignore: cast_nullable_to_non_nullable
as List<VideoModel>,priority: freezed == priority ? _self.priority : priority // ignore: cast_nullable_to_non_nullable
as int?,collectionId: freezed == collectionId ? _self.collectionId : collectionId // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}

// dart format on
