// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of '../node.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ProxyNodeSource {

 String get kind; int? get profileId; String? get provider; String? get sourceKey;
/// Create a copy of ProxyNodeSource
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProxyNodeSourceCopyWith<ProxyNodeSource> get copyWith => _$ProxyNodeSourceCopyWithImpl<ProxyNodeSource>(this as ProxyNodeSource, _$identity);

  /// Serializes this ProxyNodeSource to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProxyNodeSource&&(identical(other.kind, kind) || other.kind == kind)&&(identical(other.profileId, profileId) || other.profileId == profileId)&&(identical(other.provider, provider) || other.provider == provider)&&(identical(other.sourceKey, sourceKey) || other.sourceKey == sourceKey));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,kind,profileId,provider,sourceKey);

@override
String toString() {
  return 'ProxyNodeSource(kind: $kind, profileId: $profileId, provider: $provider, sourceKey: $sourceKey)';
}


}

/// @nodoc
abstract mixin class $ProxyNodeSourceCopyWith<$Res>  {
  factory $ProxyNodeSourceCopyWith(ProxyNodeSource value, $Res Function(ProxyNodeSource) _then) = _$ProxyNodeSourceCopyWithImpl;
@useResult
$Res call({
 String kind, int? profileId, String? provider, String? sourceKey
});




}
/// @nodoc
class _$ProxyNodeSourceCopyWithImpl<$Res>
    implements $ProxyNodeSourceCopyWith<$Res> {
  _$ProxyNodeSourceCopyWithImpl(this._self, this._then);

  final ProxyNodeSource _self;
  final $Res Function(ProxyNodeSource) _then;

/// Create a copy of ProxyNodeSource
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? kind = null,Object? profileId = freezed,Object? provider = freezed,Object? sourceKey = freezed,}) {
  return _then(_self.copyWith(
kind: null == kind ? _self.kind : kind // ignore: cast_nullable_to_non_nullable
as String,profileId: freezed == profileId ? _self.profileId : profileId // ignore: cast_nullable_to_non_nullable
as int?,provider: freezed == provider ? _self.provider : provider // ignore: cast_nullable_to_non_nullable
as String?,sourceKey: freezed == sourceKey ? _self.sourceKey : sourceKey // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [ProxyNodeSource].
extension ProxyNodeSourcePatterns on ProxyNodeSource {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ProxyNodeSource value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ProxyNodeSource() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ProxyNodeSource value)  $default,){
final _that = this;
switch (_that) {
case _ProxyNodeSource():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ProxyNodeSource value)?  $default,){
final _that = this;
switch (_that) {
case _ProxyNodeSource() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String kind,  int? profileId,  String? provider,  String? sourceKey)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ProxyNodeSource() when $default != null:
return $default(_that.kind,_that.profileId,_that.provider,_that.sourceKey);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String kind,  int? profileId,  String? provider,  String? sourceKey)  $default,) {final _that = this;
switch (_that) {
case _ProxyNodeSource():
return $default(_that.kind,_that.profileId,_that.provider,_that.sourceKey);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String kind,  int? profileId,  String? provider,  String? sourceKey)?  $default,) {final _that = this;
switch (_that) {
case _ProxyNodeSource() when $default != null:
return $default(_that.kind,_that.profileId,_that.provider,_that.sourceKey);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ProxyNodeSource implements ProxyNodeSource {
  const _ProxyNodeSource({required this.kind, this.profileId, this.provider, this.sourceKey});
  factory _ProxyNodeSource.fromJson(Map<String, dynamic> json) => _$ProxyNodeSourceFromJson(json);

@override final  String kind;
@override final  int? profileId;
@override final  String? provider;
@override final  String? sourceKey;

/// Create a copy of ProxyNodeSource
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ProxyNodeSourceCopyWith<_ProxyNodeSource> get copyWith => __$ProxyNodeSourceCopyWithImpl<_ProxyNodeSource>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ProxyNodeSourceToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ProxyNodeSource&&(identical(other.kind, kind) || other.kind == kind)&&(identical(other.profileId, profileId) || other.profileId == profileId)&&(identical(other.provider, provider) || other.provider == provider)&&(identical(other.sourceKey, sourceKey) || other.sourceKey == sourceKey));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,kind,profileId,provider,sourceKey);

@override
String toString() {
  return 'ProxyNodeSource(kind: $kind, profileId: $profileId, provider: $provider, sourceKey: $sourceKey)';
}


}

/// @nodoc
abstract mixin class _$ProxyNodeSourceCopyWith<$Res> implements $ProxyNodeSourceCopyWith<$Res> {
  factory _$ProxyNodeSourceCopyWith(_ProxyNodeSource value, $Res Function(_ProxyNodeSource) _then) = __$ProxyNodeSourceCopyWithImpl;
@override @useResult
$Res call({
 String kind, int? profileId, String? provider, String? sourceKey
});




}
/// @nodoc
class __$ProxyNodeSourceCopyWithImpl<$Res>
    implements _$ProxyNodeSourceCopyWith<$Res> {
  __$ProxyNodeSourceCopyWithImpl(this._self, this._then);

  final _ProxyNodeSource _self;
  final $Res Function(_ProxyNodeSource) _then;

/// Create a copy of ProxyNodeSource
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? kind = null,Object? profileId = freezed,Object? provider = freezed,Object? sourceKey = freezed,}) {
  return _then(_ProxyNodeSource(
kind: null == kind ? _self.kind : kind // ignore: cast_nullable_to_non_nullable
as String,profileId: freezed == profileId ? _self.profileId : profileId // ignore: cast_nullable_to_non_nullable
as int?,provider: freezed == provider ? _self.provider : provider // ignore: cast_nullable_to_non_nullable
as String?,sourceKey: freezed == sourceKey ? _self.sourceKey : sourceKey // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$ProxyNode {

 int get id; String get displayName; String get type; Map<String, Object?> get config; Map<String, Object?>? get sourceSnapshot; ProxyNodeSource? get source; Map<String, Object?> get overlaySet; List<String> get overlayRemove; Map<String, Object?> get metadata; String get fingerprint; String get status; DateTime? get createdAt; DateTime? get updatedAt; int? get order;
/// Create a copy of ProxyNode
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProxyNodeCopyWith<ProxyNode> get copyWith => _$ProxyNodeCopyWithImpl<ProxyNode>(this as ProxyNode, _$identity);

  /// Serializes this ProxyNode to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProxyNode&&(identical(other.id, id) || other.id == id)&&(identical(other.displayName, displayName) || other.displayName == displayName)&&(identical(other.type, type) || other.type == type)&&const DeepCollectionEquality().equals(other.config, config)&&const DeepCollectionEquality().equals(other.sourceSnapshot, sourceSnapshot)&&(identical(other.source, source) || other.source == source)&&const DeepCollectionEquality().equals(other.overlaySet, overlaySet)&&const DeepCollectionEquality().equals(other.overlayRemove, overlayRemove)&&const DeepCollectionEquality().equals(other.metadata, metadata)&&(identical(other.fingerprint, fingerprint) || other.fingerprint == fingerprint)&&(identical(other.status, status) || other.status == status)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.order, order) || other.order == order));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,displayName,type,const DeepCollectionEquality().hash(config),const DeepCollectionEquality().hash(sourceSnapshot),source,const DeepCollectionEquality().hash(overlaySet),const DeepCollectionEquality().hash(overlayRemove),const DeepCollectionEquality().hash(metadata),fingerprint,status,createdAt,updatedAt,order);

@override
String toString() {
  return 'ProxyNode(id: $id, displayName: $displayName, type: $type, config: $config, sourceSnapshot: $sourceSnapshot, source: $source, overlaySet: $overlaySet, overlayRemove: $overlayRemove, metadata: $metadata, fingerprint: $fingerprint, status: $status, createdAt: $createdAt, updatedAt: $updatedAt, order: $order)';
}


}

/// @nodoc
abstract mixin class $ProxyNodeCopyWith<$Res>  {
  factory $ProxyNodeCopyWith(ProxyNode value, $Res Function(ProxyNode) _then) = _$ProxyNodeCopyWithImpl;
@useResult
$Res call({
 int id, String displayName, String type, Map<String, Object?> config, Map<String, Object?>? sourceSnapshot, ProxyNodeSource? source, Map<String, Object?> overlaySet, List<String> overlayRemove, Map<String, Object?> metadata, String fingerprint, String status, DateTime? createdAt, DateTime? updatedAt, int? order
});


$ProxyNodeSourceCopyWith<$Res>? get source;

}
/// @nodoc
class _$ProxyNodeCopyWithImpl<$Res>
    implements $ProxyNodeCopyWith<$Res> {
  _$ProxyNodeCopyWithImpl(this._self, this._then);

  final ProxyNode _self;
  final $Res Function(ProxyNode) _then;

/// Create a copy of ProxyNode
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? displayName = null,Object? type = null,Object? config = null,Object? sourceSnapshot = freezed,Object? source = freezed,Object? overlaySet = null,Object? overlayRemove = null,Object? metadata = null,Object? fingerprint = null,Object? status = null,Object? createdAt = freezed,Object? updatedAt = freezed,Object? order = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,displayName: null == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,config: null == config ? _self.config : config // ignore: cast_nullable_to_non_nullable
as Map<String, Object?>,sourceSnapshot: freezed == sourceSnapshot ? _self.sourceSnapshot : sourceSnapshot // ignore: cast_nullable_to_non_nullable
as Map<String, Object?>?,source: freezed == source ? _self.source : source // ignore: cast_nullable_to_non_nullable
as ProxyNodeSource?,overlaySet: null == overlaySet ? _self.overlaySet : overlaySet // ignore: cast_nullable_to_non_nullable
as Map<String, Object?>,overlayRemove: null == overlayRemove ? _self.overlayRemove : overlayRemove // ignore: cast_nullable_to_non_nullable
as List<String>,metadata: null == metadata ? _self.metadata : metadata // ignore: cast_nullable_to_non_nullable
as Map<String, Object?>,fingerprint: null == fingerprint ? _self.fingerprint : fingerprint // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,order: freezed == order ? _self.order : order // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}
/// Create a copy of ProxyNode
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ProxyNodeSourceCopyWith<$Res>? get source {
    if (_self.source == null) {
    return null;
  }

  return $ProxyNodeSourceCopyWith<$Res>(_self.source!, (value) {
    return _then(_self.copyWith(source: value));
  });
}
}


/// Adds pattern-matching-related methods to [ProxyNode].
extension ProxyNodePatterns on ProxyNode {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ProxyNode value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ProxyNode() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ProxyNode value)  $default,){
final _that = this;
switch (_that) {
case _ProxyNode():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ProxyNode value)?  $default,){
final _that = this;
switch (_that) {
case _ProxyNode() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String displayName,  String type,  Map<String, Object?> config,  Map<String, Object?>? sourceSnapshot,  ProxyNodeSource? source,  Map<String, Object?> overlaySet,  List<String> overlayRemove,  Map<String, Object?> metadata,  String fingerprint,  String status,  DateTime? createdAt,  DateTime? updatedAt,  int? order)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ProxyNode() when $default != null:
return $default(_that.id,_that.displayName,_that.type,_that.config,_that.sourceSnapshot,_that.source,_that.overlaySet,_that.overlayRemove,_that.metadata,_that.fingerprint,_that.status,_that.createdAt,_that.updatedAt,_that.order);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String displayName,  String type,  Map<String, Object?> config,  Map<String, Object?>? sourceSnapshot,  ProxyNodeSource? source,  Map<String, Object?> overlaySet,  List<String> overlayRemove,  Map<String, Object?> metadata,  String fingerprint,  String status,  DateTime? createdAt,  DateTime? updatedAt,  int? order)  $default,) {final _that = this;
switch (_that) {
case _ProxyNode():
return $default(_that.id,_that.displayName,_that.type,_that.config,_that.sourceSnapshot,_that.source,_that.overlaySet,_that.overlayRemove,_that.metadata,_that.fingerprint,_that.status,_that.createdAt,_that.updatedAt,_that.order);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String displayName,  String type,  Map<String, Object?> config,  Map<String, Object?>? sourceSnapshot,  ProxyNodeSource? source,  Map<String, Object?> overlaySet,  List<String> overlayRemove,  Map<String, Object?> metadata,  String fingerprint,  String status,  DateTime? createdAt,  DateTime? updatedAt,  int? order)?  $default,) {final _that = this;
switch (_that) {
case _ProxyNode() when $default != null:
return $default(_that.id,_that.displayName,_that.type,_that.config,_that.sourceSnapshot,_that.source,_that.overlaySet,_that.overlayRemove,_that.metadata,_that.fingerprint,_that.status,_that.createdAt,_that.updatedAt,_that.order);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ProxyNode implements ProxyNode {
  const _ProxyNode({required this.id, required this.displayName, required this.type, final  Map<String, Object?> config = const {}, final  Map<String, Object?>? sourceSnapshot, this.source, final  Map<String, Object?> overlaySet = const {}, final  List<String> overlayRemove = const [], final  Map<String, Object?> metadata = const {}, required this.fingerprint, this.status = 'active', this.createdAt, this.updatedAt, this.order}): _config = config,_sourceSnapshot = sourceSnapshot,_overlaySet = overlaySet,_overlayRemove = overlayRemove,_metadata = metadata;
  factory _ProxyNode.fromJson(Map<String, dynamic> json) => _$ProxyNodeFromJson(json);

@override final  int id;
@override final  String displayName;
@override final  String type;
 final  Map<String, Object?> _config;
@override@JsonKey() Map<String, Object?> get config {
  if (_config is EqualUnmodifiableMapView) return _config;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_config);
}

 final  Map<String, Object?>? _sourceSnapshot;
@override Map<String, Object?>? get sourceSnapshot {
  final value = _sourceSnapshot;
  if (value == null) return null;
  if (_sourceSnapshot is EqualUnmodifiableMapView) return _sourceSnapshot;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}

@override final  ProxyNodeSource? source;
 final  Map<String, Object?> _overlaySet;
@override@JsonKey() Map<String, Object?> get overlaySet {
  if (_overlaySet is EqualUnmodifiableMapView) return _overlaySet;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_overlaySet);
}

 final  List<String> _overlayRemove;
@override@JsonKey() List<String> get overlayRemove {
  if (_overlayRemove is EqualUnmodifiableListView) return _overlayRemove;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_overlayRemove);
}

 final  Map<String, Object?> _metadata;
@override@JsonKey() Map<String, Object?> get metadata {
  if (_metadata is EqualUnmodifiableMapView) return _metadata;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_metadata);
}

@override final  String fingerprint;
@override@JsonKey() final  String status;
@override final  DateTime? createdAt;
@override final  DateTime? updatedAt;
@override final  int? order;

/// Create a copy of ProxyNode
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ProxyNodeCopyWith<_ProxyNode> get copyWith => __$ProxyNodeCopyWithImpl<_ProxyNode>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ProxyNodeToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ProxyNode&&(identical(other.id, id) || other.id == id)&&(identical(other.displayName, displayName) || other.displayName == displayName)&&(identical(other.type, type) || other.type == type)&&const DeepCollectionEquality().equals(other._config, _config)&&const DeepCollectionEquality().equals(other._sourceSnapshot, _sourceSnapshot)&&(identical(other.source, source) || other.source == source)&&const DeepCollectionEquality().equals(other._overlaySet, _overlaySet)&&const DeepCollectionEquality().equals(other._overlayRemove, _overlayRemove)&&const DeepCollectionEquality().equals(other._metadata, _metadata)&&(identical(other.fingerprint, fingerprint) || other.fingerprint == fingerprint)&&(identical(other.status, status) || other.status == status)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.order, order) || other.order == order));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,displayName,type,const DeepCollectionEquality().hash(_config),const DeepCollectionEquality().hash(_sourceSnapshot),source,const DeepCollectionEquality().hash(_overlaySet),const DeepCollectionEquality().hash(_overlayRemove),const DeepCollectionEquality().hash(_metadata),fingerprint,status,createdAt,updatedAt,order);

@override
String toString() {
  return 'ProxyNode(id: $id, displayName: $displayName, type: $type, config: $config, sourceSnapshot: $sourceSnapshot, source: $source, overlaySet: $overlaySet, overlayRemove: $overlayRemove, metadata: $metadata, fingerprint: $fingerprint, status: $status, createdAt: $createdAt, updatedAt: $updatedAt, order: $order)';
}


}

/// @nodoc
abstract mixin class _$ProxyNodeCopyWith<$Res> implements $ProxyNodeCopyWith<$Res> {
  factory _$ProxyNodeCopyWith(_ProxyNode value, $Res Function(_ProxyNode) _then) = __$ProxyNodeCopyWithImpl;
@override @useResult
$Res call({
 int id, String displayName, String type, Map<String, Object?> config, Map<String, Object?>? sourceSnapshot, ProxyNodeSource? source, Map<String, Object?> overlaySet, List<String> overlayRemove, Map<String, Object?> metadata, String fingerprint, String status, DateTime? createdAt, DateTime? updatedAt, int? order
});


@override $ProxyNodeSourceCopyWith<$Res>? get source;

}
/// @nodoc
class __$ProxyNodeCopyWithImpl<$Res>
    implements _$ProxyNodeCopyWith<$Res> {
  __$ProxyNodeCopyWithImpl(this._self, this._then);

  final _ProxyNode _self;
  final $Res Function(_ProxyNode) _then;

/// Create a copy of ProxyNode
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? displayName = null,Object? type = null,Object? config = null,Object? sourceSnapshot = freezed,Object? source = freezed,Object? overlaySet = null,Object? overlayRemove = null,Object? metadata = null,Object? fingerprint = null,Object? status = null,Object? createdAt = freezed,Object? updatedAt = freezed,Object? order = freezed,}) {
  return _then(_ProxyNode(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,displayName: null == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,config: null == config ? _self._config : config // ignore: cast_nullable_to_non_nullable
as Map<String, Object?>,sourceSnapshot: freezed == sourceSnapshot ? _self._sourceSnapshot : sourceSnapshot // ignore: cast_nullable_to_non_nullable
as Map<String, Object?>?,source: freezed == source ? _self.source : source // ignore: cast_nullable_to_non_nullable
as ProxyNodeSource?,overlaySet: null == overlaySet ? _self._overlaySet : overlaySet // ignore: cast_nullable_to_non_nullable
as Map<String, Object?>,overlayRemove: null == overlayRemove ? _self._overlayRemove : overlayRemove // ignore: cast_nullable_to_non_nullable
as List<String>,metadata: null == metadata ? _self._metadata : metadata // ignore: cast_nullable_to_non_nullable
as Map<String, Object?>,fingerprint: null == fingerprint ? _self.fingerprint : fingerprint // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,order: freezed == order ? _self.order : order // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

/// Create a copy of ProxyNode
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ProxyNodeSourceCopyWith<$Res>? get source {
    if (_self.source == null) {
    return null;
  }

  return $ProxyNodeSourceCopyWith<$Res>(_self.source!, (value) {
    return _then(_self.copyWith(source: value));
  });
}
}


/// @nodoc
mixin _$ProxyNodeBinding {

 int get profileId; int get nodeId; String? get alias; bool get enabled; int? get order;
/// Create a copy of ProxyNodeBinding
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProxyNodeBindingCopyWith<ProxyNodeBinding> get copyWith => _$ProxyNodeBindingCopyWithImpl<ProxyNodeBinding>(this as ProxyNodeBinding, _$identity);

  /// Serializes this ProxyNodeBinding to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProxyNodeBinding&&(identical(other.profileId, profileId) || other.profileId == profileId)&&(identical(other.nodeId, nodeId) || other.nodeId == nodeId)&&(identical(other.alias, alias) || other.alias == alias)&&(identical(other.enabled, enabled) || other.enabled == enabled)&&(identical(other.order, order) || other.order == order));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,profileId,nodeId,alias,enabled,order);

@override
String toString() {
  return 'ProxyNodeBinding(profileId: $profileId, nodeId: $nodeId, alias: $alias, enabled: $enabled, order: $order)';
}


}

/// @nodoc
abstract mixin class $ProxyNodeBindingCopyWith<$Res>  {
  factory $ProxyNodeBindingCopyWith(ProxyNodeBinding value, $Res Function(ProxyNodeBinding) _then) = _$ProxyNodeBindingCopyWithImpl;
@useResult
$Res call({
 int profileId, int nodeId, String? alias, bool enabled, int? order
});




}
/// @nodoc
class _$ProxyNodeBindingCopyWithImpl<$Res>
    implements $ProxyNodeBindingCopyWith<$Res> {
  _$ProxyNodeBindingCopyWithImpl(this._self, this._then);

  final ProxyNodeBinding _self;
  final $Res Function(ProxyNodeBinding) _then;

/// Create a copy of ProxyNodeBinding
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? profileId = null,Object? nodeId = null,Object? alias = freezed,Object? enabled = null,Object? order = freezed,}) {
  return _then(_self.copyWith(
profileId: null == profileId ? _self.profileId : profileId // ignore: cast_nullable_to_non_nullable
as int,nodeId: null == nodeId ? _self.nodeId : nodeId // ignore: cast_nullable_to_non_nullable
as int,alias: freezed == alias ? _self.alias : alias // ignore: cast_nullable_to_non_nullable
as String?,enabled: null == enabled ? _self.enabled : enabled // ignore: cast_nullable_to_non_nullable
as bool,order: freezed == order ? _self.order : order // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

}


/// Adds pattern-matching-related methods to [ProxyNodeBinding].
extension ProxyNodeBindingPatterns on ProxyNodeBinding {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ProxyNodeBinding value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ProxyNodeBinding() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ProxyNodeBinding value)  $default,){
final _that = this;
switch (_that) {
case _ProxyNodeBinding():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ProxyNodeBinding value)?  $default,){
final _that = this;
switch (_that) {
case _ProxyNodeBinding() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int profileId,  int nodeId,  String? alias,  bool enabled,  int? order)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ProxyNodeBinding() when $default != null:
return $default(_that.profileId,_that.nodeId,_that.alias,_that.enabled,_that.order);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int profileId,  int nodeId,  String? alias,  bool enabled,  int? order)  $default,) {final _that = this;
switch (_that) {
case _ProxyNodeBinding():
return $default(_that.profileId,_that.nodeId,_that.alias,_that.enabled,_that.order);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int profileId,  int nodeId,  String? alias,  bool enabled,  int? order)?  $default,) {final _that = this;
switch (_that) {
case _ProxyNodeBinding() when $default != null:
return $default(_that.profileId,_that.nodeId,_that.alias,_that.enabled,_that.order);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ProxyNodeBinding implements ProxyNodeBinding {
  const _ProxyNodeBinding({required this.profileId, required this.nodeId, this.alias, this.enabled = true, this.order});
  factory _ProxyNodeBinding.fromJson(Map<String, dynamic> json) => _$ProxyNodeBindingFromJson(json);

@override final  int profileId;
@override final  int nodeId;
@override final  String? alias;
@override@JsonKey() final  bool enabled;
@override final  int? order;

/// Create a copy of ProxyNodeBinding
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ProxyNodeBindingCopyWith<_ProxyNodeBinding> get copyWith => __$ProxyNodeBindingCopyWithImpl<_ProxyNodeBinding>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ProxyNodeBindingToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ProxyNodeBinding&&(identical(other.profileId, profileId) || other.profileId == profileId)&&(identical(other.nodeId, nodeId) || other.nodeId == nodeId)&&(identical(other.alias, alias) || other.alias == alias)&&(identical(other.enabled, enabled) || other.enabled == enabled)&&(identical(other.order, order) || other.order == order));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,profileId,nodeId,alias,enabled,order);

@override
String toString() {
  return 'ProxyNodeBinding(profileId: $profileId, nodeId: $nodeId, alias: $alias, enabled: $enabled, order: $order)';
}


}

/// @nodoc
abstract mixin class _$ProxyNodeBindingCopyWith<$Res> implements $ProxyNodeBindingCopyWith<$Res> {
  factory _$ProxyNodeBindingCopyWith(_ProxyNodeBinding value, $Res Function(_ProxyNodeBinding) _then) = __$ProxyNodeBindingCopyWithImpl;
@override @useResult
$Res call({
 int profileId, int nodeId, String? alias, bool enabled, int? order
});




}
/// @nodoc
class __$ProxyNodeBindingCopyWithImpl<$Res>
    implements _$ProxyNodeBindingCopyWith<$Res> {
  __$ProxyNodeBindingCopyWithImpl(this._self, this._then);

  final _ProxyNodeBinding _self;
  final $Res Function(_ProxyNodeBinding) _then;

/// Create a copy of ProxyNodeBinding
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? profileId = null,Object? nodeId = null,Object? alias = freezed,Object? enabled = null,Object? order = freezed,}) {
  return _then(_ProxyNodeBinding(
profileId: null == profileId ? _self.profileId : profileId // ignore: cast_nullable_to_non_nullable
as int,nodeId: null == nodeId ? _self.nodeId : nodeId // ignore: cast_nullable_to_non_nullable
as int,alias: freezed == alias ? _self.alias : alias // ignore: cast_nullable_to_non_nullable
as String?,enabled: null == enabled ? _self.enabled : enabled // ignore: cast_nullable_to_non_nullable
as bool,order: freezed == order ? _self.order : order // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}

// dart format on
