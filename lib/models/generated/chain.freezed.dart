// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of '../chain.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ProxyChain {

 int get id; String get name; String? get description; int get branchLimit; int? get order;
/// Create a copy of ProxyChain
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProxyChainCopyWith<ProxyChain> get copyWith => _$ProxyChainCopyWithImpl<ProxyChain>(this as ProxyChain, _$identity);

  /// Serializes this ProxyChain to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProxyChain&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.description, description) || other.description == description)&&(identical(other.branchLimit, branchLimit) || other.branchLimit == branchLimit)&&(identical(other.order, order) || other.order == order));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,description,branchLimit,order);

@override
String toString() {
  return 'ProxyChain(id: $id, name: $name, description: $description, branchLimit: $branchLimit, order: $order)';
}


}

/// @nodoc
abstract mixin class $ProxyChainCopyWith<$Res>  {
  factory $ProxyChainCopyWith(ProxyChain value, $Res Function(ProxyChain) _then) = _$ProxyChainCopyWithImpl;
@useResult
$Res call({
 int id, String name, String? description, int branchLimit, int? order
});




}
/// @nodoc
class _$ProxyChainCopyWithImpl<$Res>
    implements $ProxyChainCopyWith<$Res> {
  _$ProxyChainCopyWithImpl(this._self, this._then);

  final ProxyChain _self;
  final $Res Function(ProxyChain) _then;

/// Create a copy of ProxyChain
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? description = freezed,Object? branchLimit = null,Object? order = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,branchLimit: null == branchLimit ? _self.branchLimit : branchLimit // ignore: cast_nullable_to_non_nullable
as int,order: freezed == order ? _self.order : order // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

}


/// Adds pattern-matching-related methods to [ProxyChain].
extension ProxyChainPatterns on ProxyChain {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ProxyChain value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ProxyChain() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ProxyChain value)  $default,){
final _that = this;
switch (_that) {
case _ProxyChain():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ProxyChain value)?  $default,){
final _that = this;
switch (_that) {
case _ProxyChain() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String name,  String? description,  int branchLimit,  int? order)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ProxyChain() when $default != null:
return $default(_that.id,_that.name,_that.description,_that.branchLimit,_that.order);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String name,  String? description,  int branchLimit,  int? order)  $default,) {final _that = this;
switch (_that) {
case _ProxyChain():
return $default(_that.id,_that.name,_that.description,_that.branchLimit,_that.order);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String name,  String? description,  int branchLimit,  int? order)?  $default,) {final _that = this;
switch (_that) {
case _ProxyChain() when $default != null:
return $default(_that.id,_that.name,_that.description,_that.branchLimit,_that.order);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ProxyChain implements ProxyChain {
  const _ProxyChain({required this.id, required this.name, this.description, this.branchLimit = 64, this.order});
  factory _ProxyChain.fromJson(Map<String, dynamic> json) => _$ProxyChainFromJson(json);

@override final  int id;
@override final  String name;
@override final  String? description;
@override@JsonKey() final  int branchLimit;
@override final  int? order;

/// Create a copy of ProxyChain
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ProxyChainCopyWith<_ProxyChain> get copyWith => __$ProxyChainCopyWithImpl<_ProxyChain>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ProxyChainToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ProxyChain&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.description, description) || other.description == description)&&(identical(other.branchLimit, branchLimit) || other.branchLimit == branchLimit)&&(identical(other.order, order) || other.order == order));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,description,branchLimit,order);

@override
String toString() {
  return 'ProxyChain(id: $id, name: $name, description: $description, branchLimit: $branchLimit, order: $order)';
}


}

/// @nodoc
abstract mixin class _$ProxyChainCopyWith<$Res> implements $ProxyChainCopyWith<$Res> {
  factory _$ProxyChainCopyWith(_ProxyChain value, $Res Function(_ProxyChain) _then) = __$ProxyChainCopyWithImpl;
@override @useResult
$Res call({
 int id, String name, String? description, int branchLimit, int? order
});




}
/// @nodoc
class __$ProxyChainCopyWithImpl<$Res>
    implements _$ProxyChainCopyWith<$Res> {
  __$ProxyChainCopyWithImpl(this._self, this._then);

  final _ProxyChain _self;
  final $Res Function(_ProxyChain) _then;

/// Create a copy of ProxyChain
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? description = freezed,Object? branchLimit = null,Object? order = freezed,}) {
  return _then(_ProxyChain(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,branchLimit: null == branchLimit ? _self.branchLimit : branchLimit // ignore: cast_nullable_to_non_nullable
as int,order: freezed == order ? _self.order : order // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}


/// @nodoc
mixin _$ProxyChainHop {

 int get id; int get chainId; int get order; String get targetKind; int? get nodeId; int? get groupId; int? get profileId; String? get groupName; Map<String, Object?>? get localEndpoint;
/// Create a copy of ProxyChainHop
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProxyChainHopCopyWith<ProxyChainHop> get copyWith => _$ProxyChainHopCopyWithImpl<ProxyChainHop>(this as ProxyChainHop, _$identity);

  /// Serializes this ProxyChainHop to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProxyChainHop&&(identical(other.id, id) || other.id == id)&&(identical(other.chainId, chainId) || other.chainId == chainId)&&(identical(other.order, order) || other.order == order)&&(identical(other.targetKind, targetKind) || other.targetKind == targetKind)&&(identical(other.nodeId, nodeId) || other.nodeId == nodeId)&&(identical(other.groupId, groupId) || other.groupId == groupId)&&(identical(other.profileId, profileId) || other.profileId == profileId)&&(identical(other.groupName, groupName) || other.groupName == groupName)&&const DeepCollectionEquality().equals(other.localEndpoint, localEndpoint));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,chainId,order,targetKind,nodeId,groupId,profileId,groupName,const DeepCollectionEquality().hash(localEndpoint));

@override
String toString() {
  return 'ProxyChainHop(id: $id, chainId: $chainId, order: $order, targetKind: $targetKind, nodeId: $nodeId, groupId: $groupId, profileId: $profileId, groupName: $groupName, localEndpoint: $localEndpoint)';
}


}

/// @nodoc
abstract mixin class $ProxyChainHopCopyWith<$Res>  {
  factory $ProxyChainHopCopyWith(ProxyChainHop value, $Res Function(ProxyChainHop) _then) = _$ProxyChainHopCopyWithImpl;
@useResult
$Res call({
 int id, int chainId, int order, String targetKind, int? nodeId, int? groupId, int? profileId, String? groupName, Map<String, Object?>? localEndpoint
});




}
/// @nodoc
class _$ProxyChainHopCopyWithImpl<$Res>
    implements $ProxyChainHopCopyWith<$Res> {
  _$ProxyChainHopCopyWithImpl(this._self, this._then);

  final ProxyChainHop _self;
  final $Res Function(ProxyChainHop) _then;

/// Create a copy of ProxyChainHop
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? chainId = null,Object? order = null,Object? targetKind = null,Object? nodeId = freezed,Object? groupId = freezed,Object? profileId = freezed,Object? groupName = freezed,Object? localEndpoint = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,chainId: null == chainId ? _self.chainId : chainId // ignore: cast_nullable_to_non_nullable
as int,order: null == order ? _self.order : order // ignore: cast_nullable_to_non_nullable
as int,targetKind: null == targetKind ? _self.targetKind : targetKind // ignore: cast_nullable_to_non_nullable
as String,nodeId: freezed == nodeId ? _self.nodeId : nodeId // ignore: cast_nullable_to_non_nullable
as int?,groupId: freezed == groupId ? _self.groupId : groupId // ignore: cast_nullable_to_non_nullable
as int?,profileId: freezed == profileId ? _self.profileId : profileId // ignore: cast_nullable_to_non_nullable
as int?,groupName: freezed == groupName ? _self.groupName : groupName // ignore: cast_nullable_to_non_nullable
as String?,localEndpoint: freezed == localEndpoint ? _self.localEndpoint : localEndpoint // ignore: cast_nullable_to_non_nullable
as Map<String, Object?>?,
  ));
}

}


/// Adds pattern-matching-related methods to [ProxyChainHop].
extension ProxyChainHopPatterns on ProxyChainHop {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ProxyChainHop value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ProxyChainHop() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ProxyChainHop value)  $default,){
final _that = this;
switch (_that) {
case _ProxyChainHop():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ProxyChainHop value)?  $default,){
final _that = this;
switch (_that) {
case _ProxyChainHop() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  int chainId,  int order,  String targetKind,  int? nodeId,  int? groupId,  int? profileId,  String? groupName,  Map<String, Object?>? localEndpoint)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ProxyChainHop() when $default != null:
return $default(_that.id,_that.chainId,_that.order,_that.targetKind,_that.nodeId,_that.groupId,_that.profileId,_that.groupName,_that.localEndpoint);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  int chainId,  int order,  String targetKind,  int? nodeId,  int? groupId,  int? profileId,  String? groupName,  Map<String, Object?>? localEndpoint)  $default,) {final _that = this;
switch (_that) {
case _ProxyChainHop():
return $default(_that.id,_that.chainId,_that.order,_that.targetKind,_that.nodeId,_that.groupId,_that.profileId,_that.groupName,_that.localEndpoint);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  int chainId,  int order,  String targetKind,  int? nodeId,  int? groupId,  int? profileId,  String? groupName,  Map<String, Object?>? localEndpoint)?  $default,) {final _that = this;
switch (_that) {
case _ProxyChainHop() when $default != null:
return $default(_that.id,_that.chainId,_that.order,_that.targetKind,_that.nodeId,_that.groupId,_that.profileId,_that.groupName,_that.localEndpoint);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ProxyChainHop implements ProxyChainHop {
  const _ProxyChainHop({required this.id, required this.chainId, required this.order, required this.targetKind, this.nodeId, this.groupId, this.profileId, this.groupName, final  Map<String, Object?>? localEndpoint}): _localEndpoint = localEndpoint;
  factory _ProxyChainHop.fromJson(Map<String, dynamic> json) => _$ProxyChainHopFromJson(json);

@override final  int id;
@override final  int chainId;
@override final  int order;
@override final  String targetKind;
@override final  int? nodeId;
@override final  int? groupId;
@override final  int? profileId;
@override final  String? groupName;
 final  Map<String, Object?>? _localEndpoint;
@override Map<String, Object?>? get localEndpoint {
  final value = _localEndpoint;
  if (value == null) return null;
  if (_localEndpoint is EqualUnmodifiableMapView) return _localEndpoint;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}


/// Create a copy of ProxyChainHop
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ProxyChainHopCopyWith<_ProxyChainHop> get copyWith => __$ProxyChainHopCopyWithImpl<_ProxyChainHop>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ProxyChainHopToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ProxyChainHop&&(identical(other.id, id) || other.id == id)&&(identical(other.chainId, chainId) || other.chainId == chainId)&&(identical(other.order, order) || other.order == order)&&(identical(other.targetKind, targetKind) || other.targetKind == targetKind)&&(identical(other.nodeId, nodeId) || other.nodeId == nodeId)&&(identical(other.groupId, groupId) || other.groupId == groupId)&&(identical(other.profileId, profileId) || other.profileId == profileId)&&(identical(other.groupName, groupName) || other.groupName == groupName)&&const DeepCollectionEquality().equals(other._localEndpoint, _localEndpoint));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,chainId,order,targetKind,nodeId,groupId,profileId,groupName,const DeepCollectionEquality().hash(_localEndpoint));

@override
String toString() {
  return 'ProxyChainHop(id: $id, chainId: $chainId, order: $order, targetKind: $targetKind, nodeId: $nodeId, groupId: $groupId, profileId: $profileId, groupName: $groupName, localEndpoint: $localEndpoint)';
}


}

/// @nodoc
abstract mixin class _$ProxyChainHopCopyWith<$Res> implements $ProxyChainHopCopyWith<$Res> {
  factory _$ProxyChainHopCopyWith(_ProxyChainHop value, $Res Function(_ProxyChainHop) _then) = __$ProxyChainHopCopyWithImpl;
@override @useResult
$Res call({
 int id, int chainId, int order, String targetKind, int? nodeId, int? groupId, int? profileId, String? groupName, Map<String, Object?>? localEndpoint
});




}
/// @nodoc
class __$ProxyChainHopCopyWithImpl<$Res>
    implements _$ProxyChainHopCopyWith<$Res> {
  __$ProxyChainHopCopyWithImpl(this._self, this._then);

  final _ProxyChainHop _self;
  final $Res Function(_ProxyChainHop) _then;

/// Create a copy of ProxyChainHop
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? chainId = null,Object? order = null,Object? targetKind = null,Object? nodeId = freezed,Object? groupId = freezed,Object? profileId = freezed,Object? groupName = freezed,Object? localEndpoint = freezed,}) {
  return _then(_ProxyChainHop(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,chainId: null == chainId ? _self.chainId : chainId // ignore: cast_nullable_to_non_nullable
as int,order: null == order ? _self.order : order // ignore: cast_nullable_to_non_nullable
as int,targetKind: null == targetKind ? _self.targetKind : targetKind // ignore: cast_nullable_to_non_nullable
as String,nodeId: freezed == nodeId ? _self.nodeId : nodeId // ignore: cast_nullable_to_non_nullable
as int?,groupId: freezed == groupId ? _self.groupId : groupId // ignore: cast_nullable_to_non_nullable
as int?,profileId: freezed == profileId ? _self.profileId : profileId // ignore: cast_nullable_to_non_nullable
as int?,groupName: freezed == groupName ? _self.groupName : groupName // ignore: cast_nullable_to_non_nullable
as String?,localEndpoint: freezed == localEndpoint ? _self._localEndpoint : localEndpoint // ignore: cast_nullable_to_non_nullable
as Map<String, Object?>?,
  ));
}


}


/// @nodoc
mixin _$ProxyChainBinding {

 int get profileId; int get chainId; bool get enabled; bool get isDefault; String? get selectorName; List<String> get entryGroups; int? get order;
/// Create a copy of ProxyChainBinding
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProxyChainBindingCopyWith<ProxyChainBinding> get copyWith => _$ProxyChainBindingCopyWithImpl<ProxyChainBinding>(this as ProxyChainBinding, _$identity);

  /// Serializes this ProxyChainBinding to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProxyChainBinding&&(identical(other.profileId, profileId) || other.profileId == profileId)&&(identical(other.chainId, chainId) || other.chainId == chainId)&&(identical(other.enabled, enabled) || other.enabled == enabled)&&(identical(other.isDefault, isDefault) || other.isDefault == isDefault)&&(identical(other.selectorName, selectorName) || other.selectorName == selectorName)&&const DeepCollectionEquality().equals(other.entryGroups, entryGroups)&&(identical(other.order, order) || other.order == order));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,profileId,chainId,enabled,isDefault,selectorName,const DeepCollectionEquality().hash(entryGroups),order);

@override
String toString() {
  return 'ProxyChainBinding(profileId: $profileId, chainId: $chainId, enabled: $enabled, isDefault: $isDefault, selectorName: $selectorName, entryGroups: $entryGroups, order: $order)';
}


}

/// @nodoc
abstract mixin class $ProxyChainBindingCopyWith<$Res>  {
  factory $ProxyChainBindingCopyWith(ProxyChainBinding value, $Res Function(ProxyChainBinding) _then) = _$ProxyChainBindingCopyWithImpl;
@useResult
$Res call({
 int profileId, int chainId, bool enabled, bool isDefault, String? selectorName, List<String> entryGroups, int? order
});




}
/// @nodoc
class _$ProxyChainBindingCopyWithImpl<$Res>
    implements $ProxyChainBindingCopyWith<$Res> {
  _$ProxyChainBindingCopyWithImpl(this._self, this._then);

  final ProxyChainBinding _self;
  final $Res Function(ProxyChainBinding) _then;

/// Create a copy of ProxyChainBinding
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? profileId = null,Object? chainId = null,Object? enabled = null,Object? isDefault = null,Object? selectorName = freezed,Object? entryGroups = null,Object? order = freezed,}) {
  return _then(_self.copyWith(
profileId: null == profileId ? _self.profileId : profileId // ignore: cast_nullable_to_non_nullable
as int,chainId: null == chainId ? _self.chainId : chainId // ignore: cast_nullable_to_non_nullable
as int,enabled: null == enabled ? _self.enabled : enabled // ignore: cast_nullable_to_non_nullable
as bool,isDefault: null == isDefault ? _self.isDefault : isDefault // ignore: cast_nullable_to_non_nullable
as bool,selectorName: freezed == selectorName ? _self.selectorName : selectorName // ignore: cast_nullable_to_non_nullable
as String?,entryGroups: null == entryGroups ? _self.entryGroups : entryGroups // ignore: cast_nullable_to_non_nullable
as List<String>,order: freezed == order ? _self.order : order // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

}


/// Adds pattern-matching-related methods to [ProxyChainBinding].
extension ProxyChainBindingPatterns on ProxyChainBinding {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ProxyChainBinding value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ProxyChainBinding() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ProxyChainBinding value)  $default,){
final _that = this;
switch (_that) {
case _ProxyChainBinding():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ProxyChainBinding value)?  $default,){
final _that = this;
switch (_that) {
case _ProxyChainBinding() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int profileId,  int chainId,  bool enabled,  bool isDefault,  String? selectorName,  List<String> entryGroups,  int? order)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ProxyChainBinding() when $default != null:
return $default(_that.profileId,_that.chainId,_that.enabled,_that.isDefault,_that.selectorName,_that.entryGroups,_that.order);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int profileId,  int chainId,  bool enabled,  bool isDefault,  String? selectorName,  List<String> entryGroups,  int? order)  $default,) {final _that = this;
switch (_that) {
case _ProxyChainBinding():
return $default(_that.profileId,_that.chainId,_that.enabled,_that.isDefault,_that.selectorName,_that.entryGroups,_that.order);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int profileId,  int chainId,  bool enabled,  bool isDefault,  String? selectorName,  List<String> entryGroups,  int? order)?  $default,) {final _that = this;
switch (_that) {
case _ProxyChainBinding() when $default != null:
return $default(_that.profileId,_that.chainId,_that.enabled,_that.isDefault,_that.selectorName,_that.entryGroups,_that.order);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ProxyChainBinding implements ProxyChainBinding {
  const _ProxyChainBinding({required this.profileId, required this.chainId, this.enabled = true, this.isDefault = false, this.selectorName, final  List<String> entryGroups = const [], this.order}): _entryGroups = entryGroups;
  factory _ProxyChainBinding.fromJson(Map<String, dynamic> json) => _$ProxyChainBindingFromJson(json);

@override final  int profileId;
@override final  int chainId;
@override@JsonKey() final  bool enabled;
@override@JsonKey() final  bool isDefault;
@override final  String? selectorName;
 final  List<String> _entryGroups;
@override@JsonKey() List<String> get entryGroups {
  if (_entryGroups is EqualUnmodifiableListView) return _entryGroups;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_entryGroups);
}

@override final  int? order;

/// Create a copy of ProxyChainBinding
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ProxyChainBindingCopyWith<_ProxyChainBinding> get copyWith => __$ProxyChainBindingCopyWithImpl<_ProxyChainBinding>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ProxyChainBindingToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ProxyChainBinding&&(identical(other.profileId, profileId) || other.profileId == profileId)&&(identical(other.chainId, chainId) || other.chainId == chainId)&&(identical(other.enabled, enabled) || other.enabled == enabled)&&(identical(other.isDefault, isDefault) || other.isDefault == isDefault)&&(identical(other.selectorName, selectorName) || other.selectorName == selectorName)&&const DeepCollectionEquality().equals(other._entryGroups, _entryGroups)&&(identical(other.order, order) || other.order == order));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,profileId,chainId,enabled,isDefault,selectorName,const DeepCollectionEquality().hash(_entryGroups),order);

@override
String toString() {
  return 'ProxyChainBinding(profileId: $profileId, chainId: $chainId, enabled: $enabled, isDefault: $isDefault, selectorName: $selectorName, entryGroups: $entryGroups, order: $order)';
}


}

/// @nodoc
abstract mixin class _$ProxyChainBindingCopyWith<$Res> implements $ProxyChainBindingCopyWith<$Res> {
  factory _$ProxyChainBindingCopyWith(_ProxyChainBinding value, $Res Function(_ProxyChainBinding) _then) = __$ProxyChainBindingCopyWithImpl;
@override @useResult
$Res call({
 int profileId, int chainId, bool enabled, bool isDefault, String? selectorName, List<String> entryGroups, int? order
});




}
/// @nodoc
class __$ProxyChainBindingCopyWithImpl<$Res>
    implements _$ProxyChainBindingCopyWith<$Res> {
  __$ProxyChainBindingCopyWithImpl(this._self, this._then);

  final _ProxyChainBinding _self;
  final $Res Function(_ProxyChainBinding) _then;

/// Create a copy of ProxyChainBinding
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? profileId = null,Object? chainId = null,Object? enabled = null,Object? isDefault = null,Object? selectorName = freezed,Object? entryGroups = null,Object? order = freezed,}) {
  return _then(_ProxyChainBinding(
profileId: null == profileId ? _self.profileId : profileId // ignore: cast_nullable_to_non_nullable
as int,chainId: null == chainId ? _self.chainId : chainId // ignore: cast_nullable_to_non_nullable
as int,enabled: null == enabled ? _self.enabled : enabled // ignore: cast_nullable_to_non_nullable
as bool,isDefault: null == isDefault ? _self.isDefault : isDefault // ignore: cast_nullable_to_non_nullable
as bool,selectorName: freezed == selectorName ? _self.selectorName : selectorName // ignore: cast_nullable_to_non_nullable
as String?,entryGroups: null == entryGroups ? _self._entryGroups : entryGroups // ignore: cast_nullable_to_non_nullable
as List<String>,order: freezed == order ? _self.order : order // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}


/// @nodoc
mixin _$ProxyNodeAsset {

 int get id; int get nodeId; String get fieldPath; String get fileName; String get relativePath; String get sha256; int? get size;
/// Create a copy of ProxyNodeAsset
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProxyNodeAssetCopyWith<ProxyNodeAsset> get copyWith => _$ProxyNodeAssetCopyWithImpl<ProxyNodeAsset>(this as ProxyNodeAsset, _$identity);

  /// Serializes this ProxyNodeAsset to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProxyNodeAsset&&(identical(other.id, id) || other.id == id)&&(identical(other.nodeId, nodeId) || other.nodeId == nodeId)&&(identical(other.fieldPath, fieldPath) || other.fieldPath == fieldPath)&&(identical(other.fileName, fileName) || other.fileName == fileName)&&(identical(other.relativePath, relativePath) || other.relativePath == relativePath)&&(identical(other.sha256, sha256) || other.sha256 == sha256)&&(identical(other.size, size) || other.size == size));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,nodeId,fieldPath,fileName,relativePath,sha256,size);

@override
String toString() {
  return 'ProxyNodeAsset(id: $id, nodeId: $nodeId, fieldPath: $fieldPath, fileName: $fileName, relativePath: $relativePath, sha256: $sha256, size: $size)';
}


}

/// @nodoc
abstract mixin class $ProxyNodeAssetCopyWith<$Res>  {
  factory $ProxyNodeAssetCopyWith(ProxyNodeAsset value, $Res Function(ProxyNodeAsset) _then) = _$ProxyNodeAssetCopyWithImpl;
@useResult
$Res call({
 int id, int nodeId, String fieldPath, String fileName, String relativePath, String sha256, int? size
});




}
/// @nodoc
class _$ProxyNodeAssetCopyWithImpl<$Res>
    implements $ProxyNodeAssetCopyWith<$Res> {
  _$ProxyNodeAssetCopyWithImpl(this._self, this._then);

  final ProxyNodeAsset _self;
  final $Res Function(ProxyNodeAsset) _then;

/// Create a copy of ProxyNodeAsset
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? nodeId = null,Object? fieldPath = null,Object? fileName = null,Object? relativePath = null,Object? sha256 = null,Object? size = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,nodeId: null == nodeId ? _self.nodeId : nodeId // ignore: cast_nullable_to_non_nullable
as int,fieldPath: null == fieldPath ? _self.fieldPath : fieldPath // ignore: cast_nullable_to_non_nullable
as String,fileName: null == fileName ? _self.fileName : fileName // ignore: cast_nullable_to_non_nullable
as String,relativePath: null == relativePath ? _self.relativePath : relativePath // ignore: cast_nullable_to_non_nullable
as String,sha256: null == sha256 ? _self.sha256 : sha256 // ignore: cast_nullable_to_non_nullable
as String,size: freezed == size ? _self.size : size // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

}


/// Adds pattern-matching-related methods to [ProxyNodeAsset].
extension ProxyNodeAssetPatterns on ProxyNodeAsset {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ProxyNodeAsset value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ProxyNodeAsset() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ProxyNodeAsset value)  $default,){
final _that = this;
switch (_that) {
case _ProxyNodeAsset():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ProxyNodeAsset value)?  $default,){
final _that = this;
switch (_that) {
case _ProxyNodeAsset() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  int nodeId,  String fieldPath,  String fileName,  String relativePath,  String sha256,  int? size)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ProxyNodeAsset() when $default != null:
return $default(_that.id,_that.nodeId,_that.fieldPath,_that.fileName,_that.relativePath,_that.sha256,_that.size);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  int nodeId,  String fieldPath,  String fileName,  String relativePath,  String sha256,  int? size)  $default,) {final _that = this;
switch (_that) {
case _ProxyNodeAsset():
return $default(_that.id,_that.nodeId,_that.fieldPath,_that.fileName,_that.relativePath,_that.sha256,_that.size);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  int nodeId,  String fieldPath,  String fileName,  String relativePath,  String sha256,  int? size)?  $default,) {final _that = this;
switch (_that) {
case _ProxyNodeAsset() when $default != null:
return $default(_that.id,_that.nodeId,_that.fieldPath,_that.fileName,_that.relativePath,_that.sha256,_that.size);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ProxyNodeAsset implements ProxyNodeAsset {
  const _ProxyNodeAsset({required this.id, required this.nodeId, required this.fieldPath, required this.fileName, required this.relativePath, required this.sha256, this.size});
  factory _ProxyNodeAsset.fromJson(Map<String, dynamic> json) => _$ProxyNodeAssetFromJson(json);

@override final  int id;
@override final  int nodeId;
@override final  String fieldPath;
@override final  String fileName;
@override final  String relativePath;
@override final  String sha256;
@override final  int? size;

/// Create a copy of ProxyNodeAsset
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ProxyNodeAssetCopyWith<_ProxyNodeAsset> get copyWith => __$ProxyNodeAssetCopyWithImpl<_ProxyNodeAsset>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ProxyNodeAssetToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ProxyNodeAsset&&(identical(other.id, id) || other.id == id)&&(identical(other.nodeId, nodeId) || other.nodeId == nodeId)&&(identical(other.fieldPath, fieldPath) || other.fieldPath == fieldPath)&&(identical(other.fileName, fileName) || other.fileName == fileName)&&(identical(other.relativePath, relativePath) || other.relativePath == relativePath)&&(identical(other.sha256, sha256) || other.sha256 == sha256)&&(identical(other.size, size) || other.size == size));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,nodeId,fieldPath,fileName,relativePath,sha256,size);

@override
String toString() {
  return 'ProxyNodeAsset(id: $id, nodeId: $nodeId, fieldPath: $fieldPath, fileName: $fileName, relativePath: $relativePath, sha256: $sha256, size: $size)';
}


}

/// @nodoc
abstract mixin class _$ProxyNodeAssetCopyWith<$Res> implements $ProxyNodeAssetCopyWith<$Res> {
  factory _$ProxyNodeAssetCopyWith(_ProxyNodeAsset value, $Res Function(_ProxyNodeAsset) _then) = __$ProxyNodeAssetCopyWithImpl;
@override @useResult
$Res call({
 int id, int nodeId, String fieldPath, String fileName, String relativePath, String sha256, int? size
});




}
/// @nodoc
class __$ProxyNodeAssetCopyWithImpl<$Res>
    implements _$ProxyNodeAssetCopyWith<$Res> {
  __$ProxyNodeAssetCopyWithImpl(this._self, this._then);

  final _ProxyNodeAsset _self;
  final $Res Function(_ProxyNodeAsset) _then;

/// Create a copy of ProxyNodeAsset
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? nodeId = null,Object? fieldPath = null,Object? fileName = null,Object? relativePath = null,Object? sha256 = null,Object? size = freezed,}) {
  return _then(_ProxyNodeAsset(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,nodeId: null == nodeId ? _self.nodeId : nodeId // ignore: cast_nullable_to_non_nullable
as int,fieldPath: null == fieldPath ? _self.fieldPath : fieldPath // ignore: cast_nullable_to_non_nullable
as String,fileName: null == fileName ? _self.fileName : fileName // ignore: cast_nullable_to_non_nullable
as String,relativePath: null == relativePath ? _self.relativePath : relativePath // ignore: cast_nullable_to_non_nullable
as String,sha256: null == sha256 ? _self.sha256 : sha256 // ignore: cast_nullable_to_non_nullable
as String,size: freezed == size ? _self.size : size // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}


/// @nodoc
mixin _$ProxyGroupMember {

 int get id; int get groupId; int? get nodeId; String? get literalName; int? get order;
/// Create a copy of ProxyGroupMember
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProxyGroupMemberCopyWith<ProxyGroupMember> get copyWith => _$ProxyGroupMemberCopyWithImpl<ProxyGroupMember>(this as ProxyGroupMember, _$identity);

  /// Serializes this ProxyGroupMember to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProxyGroupMember&&(identical(other.id, id) || other.id == id)&&(identical(other.groupId, groupId) || other.groupId == groupId)&&(identical(other.nodeId, nodeId) || other.nodeId == nodeId)&&(identical(other.literalName, literalName) || other.literalName == literalName)&&(identical(other.order, order) || other.order == order));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,groupId,nodeId,literalName,order);

@override
String toString() {
  return 'ProxyGroupMember(id: $id, groupId: $groupId, nodeId: $nodeId, literalName: $literalName, order: $order)';
}


}

/// @nodoc
abstract mixin class $ProxyGroupMemberCopyWith<$Res>  {
  factory $ProxyGroupMemberCopyWith(ProxyGroupMember value, $Res Function(ProxyGroupMember) _then) = _$ProxyGroupMemberCopyWithImpl;
@useResult
$Res call({
 int id, int groupId, int? nodeId, String? literalName, int? order
});




}
/// @nodoc
class _$ProxyGroupMemberCopyWithImpl<$Res>
    implements $ProxyGroupMemberCopyWith<$Res> {
  _$ProxyGroupMemberCopyWithImpl(this._self, this._then);

  final ProxyGroupMember _self;
  final $Res Function(ProxyGroupMember) _then;

/// Create a copy of ProxyGroupMember
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? groupId = null,Object? nodeId = freezed,Object? literalName = freezed,Object? order = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,groupId: null == groupId ? _self.groupId : groupId // ignore: cast_nullable_to_non_nullable
as int,nodeId: freezed == nodeId ? _self.nodeId : nodeId // ignore: cast_nullable_to_non_nullable
as int?,literalName: freezed == literalName ? _self.literalName : literalName // ignore: cast_nullable_to_non_nullable
as String?,order: freezed == order ? _self.order : order // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

}


/// Adds pattern-matching-related methods to [ProxyGroupMember].
extension ProxyGroupMemberPatterns on ProxyGroupMember {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ProxyGroupMember value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ProxyGroupMember() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ProxyGroupMember value)  $default,){
final _that = this;
switch (_that) {
case _ProxyGroupMember():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ProxyGroupMember value)?  $default,){
final _that = this;
switch (_that) {
case _ProxyGroupMember() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  int groupId,  int? nodeId,  String? literalName,  int? order)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ProxyGroupMember() when $default != null:
return $default(_that.id,_that.groupId,_that.nodeId,_that.literalName,_that.order);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  int groupId,  int? nodeId,  String? literalName,  int? order)  $default,) {final _that = this;
switch (_that) {
case _ProxyGroupMember():
return $default(_that.id,_that.groupId,_that.nodeId,_that.literalName,_that.order);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  int groupId,  int? nodeId,  String? literalName,  int? order)?  $default,) {final _that = this;
switch (_that) {
case _ProxyGroupMember() when $default != null:
return $default(_that.id,_that.groupId,_that.nodeId,_that.literalName,_that.order);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ProxyGroupMember implements ProxyGroupMember {
  const _ProxyGroupMember({required this.id, required this.groupId, this.nodeId, this.literalName, this.order});
  factory _ProxyGroupMember.fromJson(Map<String, dynamic> json) => _$ProxyGroupMemberFromJson(json);

@override final  int id;
@override final  int groupId;
@override final  int? nodeId;
@override final  String? literalName;
@override final  int? order;

/// Create a copy of ProxyGroupMember
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ProxyGroupMemberCopyWith<_ProxyGroupMember> get copyWith => __$ProxyGroupMemberCopyWithImpl<_ProxyGroupMember>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ProxyGroupMemberToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ProxyGroupMember&&(identical(other.id, id) || other.id == id)&&(identical(other.groupId, groupId) || other.groupId == groupId)&&(identical(other.nodeId, nodeId) || other.nodeId == nodeId)&&(identical(other.literalName, literalName) || other.literalName == literalName)&&(identical(other.order, order) || other.order == order));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,groupId,nodeId,literalName,order);

@override
String toString() {
  return 'ProxyGroupMember(id: $id, groupId: $groupId, nodeId: $nodeId, literalName: $literalName, order: $order)';
}


}

/// @nodoc
abstract mixin class _$ProxyGroupMemberCopyWith<$Res> implements $ProxyGroupMemberCopyWith<$Res> {
  factory _$ProxyGroupMemberCopyWith(_ProxyGroupMember value, $Res Function(_ProxyGroupMember) _then) = __$ProxyGroupMemberCopyWithImpl;
@override @useResult
$Res call({
 int id, int groupId, int? nodeId, String? literalName, int? order
});




}
/// @nodoc
class __$ProxyGroupMemberCopyWithImpl<$Res>
    implements _$ProxyGroupMemberCopyWith<$Res> {
  __$ProxyGroupMemberCopyWithImpl(this._self, this._then);

  final _ProxyGroupMember _self;
  final $Res Function(_ProxyGroupMember) _then;

/// Create a copy of ProxyGroupMember
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? groupId = null,Object? nodeId = freezed,Object? literalName = freezed,Object? order = freezed,}) {
  return _then(_ProxyGroupMember(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,groupId: null == groupId ? _self.groupId : groupId // ignore: cast_nullable_to_non_nullable
as int,nodeId: freezed == nodeId ? _self.nodeId : nodeId // ignore: cast_nullable_to_non_nullable
as int?,literalName: freezed == literalName ? _self.literalName : literalName // ignore: cast_nullable_to_non_nullable
as String?,order: freezed == order ? _self.order : order // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}

// dart format on
