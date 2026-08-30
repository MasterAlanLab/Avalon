// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../database.dart';

// ignore_for_file: type=lint
class $ProfilesTable extends Profiles
    with TableInfo<$ProfilesTable, RawProfile> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ProfilesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _labelMeta = const VerificationMeta('label');
  @override
  late final GeneratedColumn<String> label = GeneratedColumn<String>(
    'label',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _currentGroupNameMeta = const VerificationMeta(
    'currentGroupName',
  );
  @override
  late final GeneratedColumn<String> currentGroupName = GeneratedColumn<String>(
    'current_group_name',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _urlMeta = const VerificationMeta('url');
  @override
  late final GeneratedColumn<String> url = GeneratedColumn<String>(
    'url',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _lastUpdateDateMeta = const VerificationMeta(
    'lastUpdateDate',
  );
  @override
  late final GeneratedColumn<DateTime> lastUpdateDate =
      GeneratedColumn<DateTime>(
        'last_update_date',
        aliasedName,
        true,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: false,
      );
  @override
  late final GeneratedColumnWithTypeConverter<OverwriteType, String>
  overwriteType = GeneratedColumn<String>(
    'overwrite_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  ).withConverter<OverwriteType>($ProfilesTable.$converteroverwriteType);
  static const VerificationMeta _scriptIdMeta = const VerificationMeta(
    'scriptId',
  );
  @override
  late final GeneratedColumn<int> scriptId = GeneratedColumn<int>(
    'script_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _autoUpdateDurationMillisMeta =
      const VerificationMeta('autoUpdateDurationMillis');
  @override
  late final GeneratedColumn<int> autoUpdateDurationMillis =
      GeneratedColumn<int>(
        'auto_update_duration_millis',
        aliasedName,
        false,
        type: DriftSqlType.int,
        requiredDuringInsert: true,
      );
  @override
  late final GeneratedColumnWithTypeConverter<SubscriptionInfo?, String>
  subscriptionInfo = GeneratedColumn<String>(
    'subscription_info',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  ).withConverter<SubscriptionInfo?>($ProfilesTable.$convertersubscriptionInfo);
  static const VerificationMeta _autoUpdateMeta = const VerificationMeta(
    'autoUpdate',
  );
  @override
  late final GeneratedColumn<bool> autoUpdate = GeneratedColumn<bool>(
    'auto_update',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("auto_update" IN (0, 1))',
    ),
  );
  @override
  late final GeneratedColumnWithTypeConverter<Map<String, String>, String>
  selectedMap = GeneratedColumn<String>(
    'selected_map',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  ).withConverter<Map<String, String>>($ProfilesTable.$converterselectedMap);
  @override
  late final GeneratedColumnWithTypeConverter<Set<String>, String> unfoldSet =
      GeneratedColumn<String>(
        'unfold_set',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<Set<String>>($ProfilesTable.$converterunfoldSet);
  static const VerificationMeta _orderMeta = const VerificationMeta('order');
  @override
  late final GeneratedColumn<int> order = GeneratedColumn<int>(
    'order',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    label,
    currentGroupName,
    url,
    lastUpdateDate,
    overwriteType,
    scriptId,
    autoUpdateDurationMillis,
    subscriptionInfo,
    autoUpdate,
    selectedMap,
    unfoldSet,
    order,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'profiles';
  @override
  VerificationContext validateIntegrity(
    Insertable<RawProfile> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('label')) {
      context.handle(
        _labelMeta,
        label.isAcceptableOrUnknown(data['label']!, _labelMeta),
      );
    } else if (isInserting) {
      context.missing(_labelMeta);
    }
    if (data.containsKey('current_group_name')) {
      context.handle(
        _currentGroupNameMeta,
        currentGroupName.isAcceptableOrUnknown(
          data['current_group_name']!,
          _currentGroupNameMeta,
        ),
      );
    }
    if (data.containsKey('url')) {
      context.handle(
        _urlMeta,
        url.isAcceptableOrUnknown(data['url']!, _urlMeta),
      );
    } else if (isInserting) {
      context.missing(_urlMeta);
    }
    if (data.containsKey('last_update_date')) {
      context.handle(
        _lastUpdateDateMeta,
        lastUpdateDate.isAcceptableOrUnknown(
          data['last_update_date']!,
          _lastUpdateDateMeta,
        ),
      );
    }
    if (data.containsKey('script_id')) {
      context.handle(
        _scriptIdMeta,
        scriptId.isAcceptableOrUnknown(data['script_id']!, _scriptIdMeta),
      );
    }
    if (data.containsKey('auto_update_duration_millis')) {
      context.handle(
        _autoUpdateDurationMillisMeta,
        autoUpdateDurationMillis.isAcceptableOrUnknown(
          data['auto_update_duration_millis']!,
          _autoUpdateDurationMillisMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_autoUpdateDurationMillisMeta);
    }
    if (data.containsKey('auto_update')) {
      context.handle(
        _autoUpdateMeta,
        autoUpdate.isAcceptableOrUnknown(data['auto_update']!, _autoUpdateMeta),
      );
    } else if (isInserting) {
      context.missing(_autoUpdateMeta);
    }
    if (data.containsKey('order')) {
      context.handle(
        _orderMeta,
        order.isAcceptableOrUnknown(data['order']!, _orderMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  RawProfile map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return RawProfile(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      label: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}label'],
      )!,
      currentGroupName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}current_group_name'],
      ),
      url: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}url'],
      )!,
      lastUpdateDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}last_update_date'],
      ),
      overwriteType: $ProfilesTable.$converteroverwriteType.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}overwrite_type'],
        )!,
      ),
      scriptId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}script_id'],
      ),
      autoUpdateDurationMillis: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}auto_update_duration_millis'],
      )!,
      subscriptionInfo: $ProfilesTable.$convertersubscriptionInfo.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}subscription_info'],
        ),
      ),
      autoUpdate: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}auto_update'],
      )!,
      selectedMap: $ProfilesTable.$converterselectedMap.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}selected_map'],
        )!,
      ),
      unfoldSet: $ProfilesTable.$converterunfoldSet.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}unfold_set'],
        )!,
      ),
      order: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}order'],
      ),
    );
  }

  @override
  $ProfilesTable createAlias(String alias) {
    return $ProfilesTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<OverwriteType, String, String>
  $converteroverwriteType = const EnumNameConverter<OverwriteType>(
    OverwriteType.values,
  );
  static TypeConverter<SubscriptionInfo?, String?> $convertersubscriptionInfo =
      const SubscriptionInfoConverter();
  static TypeConverter<Map<String, String>, String> $converterselectedMap =
      const StringMapConverter();
  static TypeConverter<Set<String>, String> $converterunfoldSet =
      const StringSetConverter();
}

class RawProfile extends DataClass implements Insertable<RawProfile> {
  final int id;
  final String label;
  final String? currentGroupName;
  final String url;
  final DateTime? lastUpdateDate;
  final OverwriteType overwriteType;
  final int? scriptId;
  final int autoUpdateDurationMillis;
  final SubscriptionInfo? subscriptionInfo;
  final bool autoUpdate;
  final Map<String, String> selectedMap;
  final Set<String> unfoldSet;
  final int? order;
  const RawProfile({
    required this.id,
    required this.label,
    this.currentGroupName,
    required this.url,
    this.lastUpdateDate,
    required this.overwriteType,
    this.scriptId,
    required this.autoUpdateDurationMillis,
    this.subscriptionInfo,
    required this.autoUpdate,
    required this.selectedMap,
    required this.unfoldSet,
    this.order,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['label'] = Variable<String>(label);
    if (!nullToAbsent || currentGroupName != null) {
      map['current_group_name'] = Variable<String>(currentGroupName);
    }
    map['url'] = Variable<String>(url);
    if (!nullToAbsent || lastUpdateDate != null) {
      map['last_update_date'] = Variable<DateTime>(lastUpdateDate);
    }
    {
      map['overwrite_type'] = Variable<String>(
        $ProfilesTable.$converteroverwriteType.toSql(overwriteType),
      );
    }
    if (!nullToAbsent || scriptId != null) {
      map['script_id'] = Variable<int>(scriptId);
    }
    map['auto_update_duration_millis'] = Variable<int>(
      autoUpdateDurationMillis,
    );
    if (!nullToAbsent || subscriptionInfo != null) {
      map['subscription_info'] = Variable<String>(
        $ProfilesTable.$convertersubscriptionInfo.toSql(subscriptionInfo),
      );
    }
    map['auto_update'] = Variable<bool>(autoUpdate);
    {
      map['selected_map'] = Variable<String>(
        $ProfilesTable.$converterselectedMap.toSql(selectedMap),
      );
    }
    {
      map['unfold_set'] = Variable<String>(
        $ProfilesTable.$converterunfoldSet.toSql(unfoldSet),
      );
    }
    if (!nullToAbsent || order != null) {
      map['order'] = Variable<int>(order);
    }
    return map;
  }

  ProfilesCompanion toCompanion(bool nullToAbsent) {
    return ProfilesCompanion(
      id: Value(id),
      label: Value(label),
      currentGroupName: currentGroupName == null && nullToAbsent
          ? const Value.absent()
          : Value(currentGroupName),
      url: Value(url),
      lastUpdateDate: lastUpdateDate == null && nullToAbsent
          ? const Value.absent()
          : Value(lastUpdateDate),
      overwriteType: Value(overwriteType),
      scriptId: scriptId == null && nullToAbsent
          ? const Value.absent()
          : Value(scriptId),
      autoUpdateDurationMillis: Value(autoUpdateDurationMillis),
      subscriptionInfo: subscriptionInfo == null && nullToAbsent
          ? const Value.absent()
          : Value(subscriptionInfo),
      autoUpdate: Value(autoUpdate),
      selectedMap: Value(selectedMap),
      unfoldSet: Value(unfoldSet),
      order: order == null && nullToAbsent
          ? const Value.absent()
          : Value(order),
    );
  }

  factory RawProfile.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return RawProfile(
      id: serializer.fromJson<int>(json['id']),
      label: serializer.fromJson<String>(json['label']),
      currentGroupName: serializer.fromJson<String?>(json['currentGroupName']),
      url: serializer.fromJson<String>(json['url']),
      lastUpdateDate: serializer.fromJson<DateTime?>(json['lastUpdateDate']),
      overwriteType: $ProfilesTable.$converteroverwriteType.fromJson(
        serializer.fromJson<String>(json['overwriteType']),
      ),
      scriptId: serializer.fromJson<int?>(json['scriptId']),
      autoUpdateDurationMillis: serializer.fromJson<int>(
        json['autoUpdateDurationMillis'],
      ),
      subscriptionInfo: serializer.fromJson<SubscriptionInfo?>(
        json['subscriptionInfo'],
      ),
      autoUpdate: serializer.fromJson<bool>(json['autoUpdate']),
      selectedMap: serializer.fromJson<Map<String, String>>(
        json['selectedMap'],
      ),
      unfoldSet: serializer.fromJson<Set<String>>(json['unfoldSet']),
      order: serializer.fromJson<int?>(json['order']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'label': serializer.toJson<String>(label),
      'currentGroupName': serializer.toJson<String?>(currentGroupName),
      'url': serializer.toJson<String>(url),
      'lastUpdateDate': serializer.toJson<DateTime?>(lastUpdateDate),
      'overwriteType': serializer.toJson<String>(
        $ProfilesTable.$converteroverwriteType.toJson(overwriteType),
      ),
      'scriptId': serializer.toJson<int?>(scriptId),
      'autoUpdateDurationMillis': serializer.toJson<int>(
        autoUpdateDurationMillis,
      ),
      'subscriptionInfo': serializer.toJson<SubscriptionInfo?>(
        subscriptionInfo,
      ),
      'autoUpdate': serializer.toJson<bool>(autoUpdate),
      'selectedMap': serializer.toJson<Map<String, String>>(selectedMap),
      'unfoldSet': serializer.toJson<Set<String>>(unfoldSet),
      'order': serializer.toJson<int?>(order),
    };
  }

  RawProfile copyWith({
    int? id,
    String? label,
    Value<String?> currentGroupName = const Value.absent(),
    String? url,
    Value<DateTime?> lastUpdateDate = const Value.absent(),
    OverwriteType? overwriteType,
    Value<int?> scriptId = const Value.absent(),
    int? autoUpdateDurationMillis,
    Value<SubscriptionInfo?> subscriptionInfo = const Value.absent(),
    bool? autoUpdate,
    Map<String, String>? selectedMap,
    Set<String>? unfoldSet,
    Value<int?> order = const Value.absent(),
  }) => RawProfile(
    id: id ?? this.id,
    label: label ?? this.label,
    currentGroupName: currentGroupName.present
        ? currentGroupName.value
        : this.currentGroupName,
    url: url ?? this.url,
    lastUpdateDate: lastUpdateDate.present
        ? lastUpdateDate.value
        : this.lastUpdateDate,
    overwriteType: overwriteType ?? this.overwriteType,
    scriptId: scriptId.present ? scriptId.value : this.scriptId,
    autoUpdateDurationMillis:
        autoUpdateDurationMillis ?? this.autoUpdateDurationMillis,
    subscriptionInfo: subscriptionInfo.present
        ? subscriptionInfo.value
        : this.subscriptionInfo,
    autoUpdate: autoUpdate ?? this.autoUpdate,
    selectedMap: selectedMap ?? this.selectedMap,
    unfoldSet: unfoldSet ?? this.unfoldSet,
    order: order.present ? order.value : this.order,
  );
  RawProfile copyWithCompanion(ProfilesCompanion data) {
    return RawProfile(
      id: data.id.present ? data.id.value : this.id,
      label: data.label.present ? data.label.value : this.label,
      currentGroupName: data.currentGroupName.present
          ? data.currentGroupName.value
          : this.currentGroupName,
      url: data.url.present ? data.url.value : this.url,
      lastUpdateDate: data.lastUpdateDate.present
          ? data.lastUpdateDate.value
          : this.lastUpdateDate,
      overwriteType: data.overwriteType.present
          ? data.overwriteType.value
          : this.overwriteType,
      scriptId: data.scriptId.present ? data.scriptId.value : this.scriptId,
      autoUpdateDurationMillis: data.autoUpdateDurationMillis.present
          ? data.autoUpdateDurationMillis.value
          : this.autoUpdateDurationMillis,
      subscriptionInfo: data.subscriptionInfo.present
          ? data.subscriptionInfo.value
          : this.subscriptionInfo,
      autoUpdate: data.autoUpdate.present
          ? data.autoUpdate.value
          : this.autoUpdate,
      selectedMap: data.selectedMap.present
          ? data.selectedMap.value
          : this.selectedMap,
      unfoldSet: data.unfoldSet.present ? data.unfoldSet.value : this.unfoldSet,
      order: data.order.present ? data.order.value : this.order,
    );
  }

  @override
  String toString() {
    return (StringBuffer('RawProfile(')
          ..write('id: $id, ')
          ..write('label: $label, ')
          ..write('currentGroupName: $currentGroupName, ')
          ..write('url: $url, ')
          ..write('lastUpdateDate: $lastUpdateDate, ')
          ..write('overwriteType: $overwriteType, ')
          ..write('scriptId: $scriptId, ')
          ..write('autoUpdateDurationMillis: $autoUpdateDurationMillis, ')
          ..write('subscriptionInfo: $subscriptionInfo, ')
          ..write('autoUpdate: $autoUpdate, ')
          ..write('selectedMap: $selectedMap, ')
          ..write('unfoldSet: $unfoldSet, ')
          ..write('order: $order')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    label,
    currentGroupName,
    url,
    lastUpdateDate,
    overwriteType,
    scriptId,
    autoUpdateDurationMillis,
    subscriptionInfo,
    autoUpdate,
    selectedMap,
    unfoldSet,
    order,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is RawProfile &&
          other.id == this.id &&
          other.label == this.label &&
          other.currentGroupName == this.currentGroupName &&
          other.url == this.url &&
          other.lastUpdateDate == this.lastUpdateDate &&
          other.overwriteType == this.overwriteType &&
          other.scriptId == this.scriptId &&
          other.autoUpdateDurationMillis == this.autoUpdateDurationMillis &&
          other.subscriptionInfo == this.subscriptionInfo &&
          other.autoUpdate == this.autoUpdate &&
          other.selectedMap == this.selectedMap &&
          other.unfoldSet == this.unfoldSet &&
          other.order == this.order);
}

class ProfilesCompanion extends UpdateCompanion<RawProfile> {
  final Value<int> id;
  final Value<String> label;
  final Value<String?> currentGroupName;
  final Value<String> url;
  final Value<DateTime?> lastUpdateDate;
  final Value<OverwriteType> overwriteType;
  final Value<int?> scriptId;
  final Value<int> autoUpdateDurationMillis;
  final Value<SubscriptionInfo?> subscriptionInfo;
  final Value<bool> autoUpdate;
  final Value<Map<String, String>> selectedMap;
  final Value<Set<String>> unfoldSet;
  final Value<int?> order;
  const ProfilesCompanion({
    this.id = const Value.absent(),
    this.label = const Value.absent(),
    this.currentGroupName = const Value.absent(),
    this.url = const Value.absent(),
    this.lastUpdateDate = const Value.absent(),
    this.overwriteType = const Value.absent(),
    this.scriptId = const Value.absent(),
    this.autoUpdateDurationMillis = const Value.absent(),
    this.subscriptionInfo = const Value.absent(),
    this.autoUpdate = const Value.absent(),
    this.selectedMap = const Value.absent(),
    this.unfoldSet = const Value.absent(),
    this.order = const Value.absent(),
  });
  ProfilesCompanion.insert({
    this.id = const Value.absent(),
    required String label,
    this.currentGroupName = const Value.absent(),
    required String url,
    this.lastUpdateDate = const Value.absent(),
    required OverwriteType overwriteType,
    this.scriptId = const Value.absent(),
    required int autoUpdateDurationMillis,
    this.subscriptionInfo = const Value.absent(),
    required bool autoUpdate,
    required Map<String, String> selectedMap,
    required Set<String> unfoldSet,
    this.order = const Value.absent(),
  }) : label = Value(label),
       url = Value(url),
       overwriteType = Value(overwriteType),
       autoUpdateDurationMillis = Value(autoUpdateDurationMillis),
       autoUpdate = Value(autoUpdate),
       selectedMap = Value(selectedMap),
       unfoldSet = Value(unfoldSet);
  static Insertable<RawProfile> custom({
    Expression<int>? id,
    Expression<String>? label,
    Expression<String>? currentGroupName,
    Expression<String>? url,
    Expression<DateTime>? lastUpdateDate,
    Expression<String>? overwriteType,
    Expression<int>? scriptId,
    Expression<int>? autoUpdateDurationMillis,
    Expression<String>? subscriptionInfo,
    Expression<bool>? autoUpdate,
    Expression<String>? selectedMap,
    Expression<String>? unfoldSet,
    Expression<int>? order,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (label != null) 'label': label,
      if (currentGroupName != null) 'current_group_name': currentGroupName,
      if (url != null) 'url': url,
      if (lastUpdateDate != null) 'last_update_date': lastUpdateDate,
      if (overwriteType != null) 'overwrite_type': overwriteType,
      if (scriptId != null) 'script_id': scriptId,
      if (autoUpdateDurationMillis != null)
        'auto_update_duration_millis': autoUpdateDurationMillis,
      if (subscriptionInfo != null) 'subscription_info': subscriptionInfo,
      if (autoUpdate != null) 'auto_update': autoUpdate,
      if (selectedMap != null) 'selected_map': selectedMap,
      if (unfoldSet != null) 'unfold_set': unfoldSet,
      if (order != null) 'order': order,
    });
  }

  ProfilesCompanion copyWith({
    Value<int>? id,
    Value<String>? label,
    Value<String?>? currentGroupName,
    Value<String>? url,
    Value<DateTime?>? lastUpdateDate,
    Value<OverwriteType>? overwriteType,
    Value<int?>? scriptId,
    Value<int>? autoUpdateDurationMillis,
    Value<SubscriptionInfo?>? subscriptionInfo,
    Value<bool>? autoUpdate,
    Value<Map<String, String>>? selectedMap,
    Value<Set<String>>? unfoldSet,
    Value<int?>? order,
  }) {
    return ProfilesCompanion(
      id: id ?? this.id,
      label: label ?? this.label,
      currentGroupName: currentGroupName ?? this.currentGroupName,
      url: url ?? this.url,
      lastUpdateDate: lastUpdateDate ?? this.lastUpdateDate,
      overwriteType: overwriteType ?? this.overwriteType,
      scriptId: scriptId ?? this.scriptId,
      autoUpdateDurationMillis:
          autoUpdateDurationMillis ?? this.autoUpdateDurationMillis,
      subscriptionInfo: subscriptionInfo ?? this.subscriptionInfo,
      autoUpdate: autoUpdate ?? this.autoUpdate,
      selectedMap: selectedMap ?? this.selectedMap,
      unfoldSet: unfoldSet ?? this.unfoldSet,
      order: order ?? this.order,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (label.present) {
      map['label'] = Variable<String>(label.value);
    }
    if (currentGroupName.present) {
      map['current_group_name'] = Variable<String>(currentGroupName.value);
    }
    if (url.present) {
      map['url'] = Variable<String>(url.value);
    }
    if (lastUpdateDate.present) {
      map['last_update_date'] = Variable<DateTime>(lastUpdateDate.value);
    }
    if (overwriteType.present) {
      map['overwrite_type'] = Variable<String>(
        $ProfilesTable.$converteroverwriteType.toSql(overwriteType.value),
      );
    }
    if (scriptId.present) {
      map['script_id'] = Variable<int>(scriptId.value);
    }
    if (autoUpdateDurationMillis.present) {
      map['auto_update_duration_millis'] = Variable<int>(
        autoUpdateDurationMillis.value,
      );
    }
    if (subscriptionInfo.present) {
      map['subscription_info'] = Variable<String>(
        $ProfilesTable.$convertersubscriptionInfo.toSql(subscriptionInfo.value),
      );
    }
    if (autoUpdate.present) {
      map['auto_update'] = Variable<bool>(autoUpdate.value);
    }
    if (selectedMap.present) {
      map['selected_map'] = Variable<String>(
        $ProfilesTable.$converterselectedMap.toSql(selectedMap.value),
      );
    }
    if (unfoldSet.present) {
      map['unfold_set'] = Variable<String>(
        $ProfilesTable.$converterunfoldSet.toSql(unfoldSet.value),
      );
    }
    if (order.present) {
      map['order'] = Variable<int>(order.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ProfilesCompanion(')
          ..write('id: $id, ')
          ..write('label: $label, ')
          ..write('currentGroupName: $currentGroupName, ')
          ..write('url: $url, ')
          ..write('lastUpdateDate: $lastUpdateDate, ')
          ..write('overwriteType: $overwriteType, ')
          ..write('scriptId: $scriptId, ')
          ..write('autoUpdateDurationMillis: $autoUpdateDurationMillis, ')
          ..write('subscriptionInfo: $subscriptionInfo, ')
          ..write('autoUpdate: $autoUpdate, ')
          ..write('selectedMap: $selectedMap, ')
          ..write('unfoldSet: $unfoldSet, ')
          ..write('order: $order')
          ..write(')'))
        .toString();
  }
}

class $ScriptsTable extends Scripts with TableInfo<$ScriptsTable, RawScript> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ScriptsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _labelMeta = const VerificationMeta('label');
  @override
  late final GeneratedColumn<String> label = GeneratedColumn<String>(
    'label',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _lastUpdateTimeMeta = const VerificationMeta(
    'lastUpdateTime',
  );
  @override
  late final GeneratedColumn<DateTime> lastUpdateTime =
      GeneratedColumn<DateTime>(
        'last_update_time',
        aliasedName,
        false,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: true,
      );
  @override
  List<GeneratedColumn> get $columns => [id, label, lastUpdateTime];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'scripts';
  @override
  VerificationContext validateIntegrity(
    Insertable<RawScript> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('label')) {
      context.handle(
        _labelMeta,
        label.isAcceptableOrUnknown(data['label']!, _labelMeta),
      );
    } else if (isInserting) {
      context.missing(_labelMeta);
    }
    if (data.containsKey('last_update_time')) {
      context.handle(
        _lastUpdateTimeMeta,
        lastUpdateTime.isAcceptableOrUnknown(
          data['last_update_time']!,
          _lastUpdateTimeMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_lastUpdateTimeMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  RawScript map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return RawScript(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      label: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}label'],
      )!,
      lastUpdateTime: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}last_update_time'],
      )!,
    );
  }

  @override
  $ScriptsTable createAlias(String alias) {
    return $ScriptsTable(attachedDatabase, alias);
  }
}

class RawScript extends DataClass implements Insertable<RawScript> {
  final int id;
  final String label;
  final DateTime lastUpdateTime;
  const RawScript({
    required this.id,
    required this.label,
    required this.lastUpdateTime,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['label'] = Variable<String>(label);
    map['last_update_time'] = Variable<DateTime>(lastUpdateTime);
    return map;
  }

  ScriptsCompanion toCompanion(bool nullToAbsent) {
    return ScriptsCompanion(
      id: Value(id),
      label: Value(label),
      lastUpdateTime: Value(lastUpdateTime),
    );
  }

  factory RawScript.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return RawScript(
      id: serializer.fromJson<int>(json['id']),
      label: serializer.fromJson<String>(json['label']),
      lastUpdateTime: serializer.fromJson<DateTime>(json['lastUpdateTime']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'label': serializer.toJson<String>(label),
      'lastUpdateTime': serializer.toJson<DateTime>(lastUpdateTime),
    };
  }

  RawScript copyWith({int? id, String? label, DateTime? lastUpdateTime}) =>
      RawScript(
        id: id ?? this.id,
        label: label ?? this.label,
        lastUpdateTime: lastUpdateTime ?? this.lastUpdateTime,
      );
  RawScript copyWithCompanion(ScriptsCompanion data) {
    return RawScript(
      id: data.id.present ? data.id.value : this.id,
      label: data.label.present ? data.label.value : this.label,
      lastUpdateTime: data.lastUpdateTime.present
          ? data.lastUpdateTime.value
          : this.lastUpdateTime,
    );
  }

  @override
  String toString() {
    return (StringBuffer('RawScript(')
          ..write('id: $id, ')
          ..write('label: $label, ')
          ..write('lastUpdateTime: $lastUpdateTime')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, label, lastUpdateTime);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is RawScript &&
          other.id == this.id &&
          other.label == this.label &&
          other.lastUpdateTime == this.lastUpdateTime);
}

class ScriptsCompanion extends UpdateCompanion<RawScript> {
  final Value<int> id;
  final Value<String> label;
  final Value<DateTime> lastUpdateTime;
  const ScriptsCompanion({
    this.id = const Value.absent(),
    this.label = const Value.absent(),
    this.lastUpdateTime = const Value.absent(),
  });
  ScriptsCompanion.insert({
    this.id = const Value.absent(),
    required String label,
    required DateTime lastUpdateTime,
  }) : label = Value(label),
       lastUpdateTime = Value(lastUpdateTime);
  static Insertable<RawScript> custom({
    Expression<int>? id,
    Expression<String>? label,
    Expression<DateTime>? lastUpdateTime,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (label != null) 'label': label,
      if (lastUpdateTime != null) 'last_update_time': lastUpdateTime,
    });
  }

  ScriptsCompanion copyWith({
    Value<int>? id,
    Value<String>? label,
    Value<DateTime>? lastUpdateTime,
  }) {
    return ScriptsCompanion(
      id: id ?? this.id,
      label: label ?? this.label,
      lastUpdateTime: lastUpdateTime ?? this.lastUpdateTime,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (label.present) {
      map['label'] = Variable<String>(label.value);
    }
    if (lastUpdateTime.present) {
      map['last_update_time'] = Variable<DateTime>(lastUpdateTime.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ScriptsCompanion(')
          ..write('id: $id, ')
          ..write('label: $label, ')
          ..write('lastUpdateTime: $lastUpdateTime')
          ..write(')'))
        .toString();
  }
}

class $RulesTable extends Rules with TableInfo<$RulesTable, RawRule> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $RulesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  @override
  late final GeneratedColumnWithTypeConverter<RuleAction, String> ruleAction =
      GeneratedColumn<String>(
        'rule_action',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<RuleAction>($RulesTable.$converterruleAction);
  static const VerificationMeta _contentMeta = const VerificationMeta(
    'content',
  );
  @override
  late final GeneratedColumn<String> content = GeneratedColumn<String>(
    'content',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _ruleTargetMeta = const VerificationMeta(
    'ruleTarget',
  );
  @override
  late final GeneratedColumn<String> ruleTarget = GeneratedColumn<String>(
    'rule_target',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _ruleProviderMeta = const VerificationMeta(
    'ruleProvider',
  );
  @override
  late final GeneratedColumn<String> ruleProvider = GeneratedColumn<String>(
    'rule_provider',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _subRuleMeta = const VerificationMeta(
    'subRule',
  );
  @override
  late final GeneratedColumn<String> subRule = GeneratedColumn<String>(
    'sub_rule',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _noResolveMeta = const VerificationMeta(
    'noResolve',
  );
  @override
  late final GeneratedColumn<bool> noResolve = GeneratedColumn<bool>(
    'no_resolve',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("no_resolve" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _srcMeta = const VerificationMeta('src');
  @override
  late final GeneratedColumn<bool> src = GeneratedColumn<bool>(
    'src',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("src" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    ruleAction,
    content,
    ruleTarget,
    ruleProvider,
    subRule,
    noResolve,
    src,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'rules';
  @override
  VerificationContext validateIntegrity(
    Insertable<RawRule> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('content')) {
      context.handle(
        _contentMeta,
        content.isAcceptableOrUnknown(data['content']!, _contentMeta),
      );
    }
    if (data.containsKey('rule_target')) {
      context.handle(
        _ruleTargetMeta,
        ruleTarget.isAcceptableOrUnknown(data['rule_target']!, _ruleTargetMeta),
      );
    }
    if (data.containsKey('rule_provider')) {
      context.handle(
        _ruleProviderMeta,
        ruleProvider.isAcceptableOrUnknown(
          data['rule_provider']!,
          _ruleProviderMeta,
        ),
      );
    }
    if (data.containsKey('sub_rule')) {
      context.handle(
        _subRuleMeta,
        subRule.isAcceptableOrUnknown(data['sub_rule']!, _subRuleMeta),
      );
    }
    if (data.containsKey('no_resolve')) {
      context.handle(
        _noResolveMeta,
        noResolve.isAcceptableOrUnknown(data['no_resolve']!, _noResolveMeta),
      );
    }
    if (data.containsKey('src')) {
      context.handle(
        _srcMeta,
        src.isAcceptableOrUnknown(data['src']!, _srcMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  RawRule map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return RawRule(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      ruleAction: $RulesTable.$converterruleAction.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}rule_action'],
        )!,
      ),
      content: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}content'],
      ),
      ruleTarget: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}rule_target'],
      ),
      ruleProvider: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}rule_provider'],
      ),
      subRule: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}sub_rule'],
      ),
      noResolve: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}no_resolve'],
      )!,
      src: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}src'],
      )!,
    );
  }

  @override
  $RulesTable createAlias(String alias) {
    return $RulesTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<RuleAction, String, String> $converterruleAction =
      const EnumNameConverter<RuleAction>(RuleAction.values);
}

class RawRule extends DataClass implements Insertable<RawRule> {
  final int id;
  final RuleAction ruleAction;
  final String? content;
  final String? ruleTarget;
  final String? ruleProvider;
  final String? subRule;
  final bool noResolve;
  final bool src;
  const RawRule({
    required this.id,
    required this.ruleAction,
    this.content,
    this.ruleTarget,
    this.ruleProvider,
    this.subRule,
    required this.noResolve,
    required this.src,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    {
      map['rule_action'] = Variable<String>(
        $RulesTable.$converterruleAction.toSql(ruleAction),
      );
    }
    if (!nullToAbsent || content != null) {
      map['content'] = Variable<String>(content);
    }
    if (!nullToAbsent || ruleTarget != null) {
      map['rule_target'] = Variable<String>(ruleTarget);
    }
    if (!nullToAbsent || ruleProvider != null) {
      map['rule_provider'] = Variable<String>(ruleProvider);
    }
    if (!nullToAbsent || subRule != null) {
      map['sub_rule'] = Variable<String>(subRule);
    }
    map['no_resolve'] = Variable<bool>(noResolve);
    map['src'] = Variable<bool>(src);
    return map;
  }

  RulesCompanion toCompanion(bool nullToAbsent) {
    return RulesCompanion(
      id: Value(id),
      ruleAction: Value(ruleAction),
      content: content == null && nullToAbsent
          ? const Value.absent()
          : Value(content),
      ruleTarget: ruleTarget == null && nullToAbsent
          ? const Value.absent()
          : Value(ruleTarget),
      ruleProvider: ruleProvider == null && nullToAbsent
          ? const Value.absent()
          : Value(ruleProvider),
      subRule: subRule == null && nullToAbsent
          ? const Value.absent()
          : Value(subRule),
      noResolve: Value(noResolve),
      src: Value(src),
    );
  }

  factory RawRule.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return RawRule(
      id: serializer.fromJson<int>(json['id']),
      ruleAction: $RulesTable.$converterruleAction.fromJson(
        serializer.fromJson<String>(json['ruleAction']),
      ),
      content: serializer.fromJson<String?>(json['content']),
      ruleTarget: serializer.fromJson<String?>(json['ruleTarget']),
      ruleProvider: serializer.fromJson<String?>(json['ruleProvider']),
      subRule: serializer.fromJson<String?>(json['subRule']),
      noResolve: serializer.fromJson<bool>(json['noResolve']),
      src: serializer.fromJson<bool>(json['src']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'ruleAction': serializer.toJson<String>(
        $RulesTable.$converterruleAction.toJson(ruleAction),
      ),
      'content': serializer.toJson<String?>(content),
      'ruleTarget': serializer.toJson<String?>(ruleTarget),
      'ruleProvider': serializer.toJson<String?>(ruleProvider),
      'subRule': serializer.toJson<String?>(subRule),
      'noResolve': serializer.toJson<bool>(noResolve),
      'src': serializer.toJson<bool>(src),
    };
  }

  RawRule copyWith({
    int? id,
    RuleAction? ruleAction,
    Value<String?> content = const Value.absent(),
    Value<String?> ruleTarget = const Value.absent(),
    Value<String?> ruleProvider = const Value.absent(),
    Value<String?> subRule = const Value.absent(),
    bool? noResolve,
    bool? src,
  }) => RawRule(
    id: id ?? this.id,
    ruleAction: ruleAction ?? this.ruleAction,
    content: content.present ? content.value : this.content,
    ruleTarget: ruleTarget.present ? ruleTarget.value : this.ruleTarget,
    ruleProvider: ruleProvider.present ? ruleProvider.value : this.ruleProvider,
    subRule: subRule.present ? subRule.value : this.subRule,
    noResolve: noResolve ?? this.noResolve,
    src: src ?? this.src,
  );
  RawRule copyWithCompanion(RulesCompanion data) {
    return RawRule(
      id: data.id.present ? data.id.value : this.id,
      ruleAction: data.ruleAction.present
          ? data.ruleAction.value
          : this.ruleAction,
      content: data.content.present ? data.content.value : this.content,
      ruleTarget: data.ruleTarget.present
          ? data.ruleTarget.value
          : this.ruleTarget,
      ruleProvider: data.ruleProvider.present
          ? data.ruleProvider.value
          : this.ruleProvider,
      subRule: data.subRule.present ? data.subRule.value : this.subRule,
      noResolve: data.noResolve.present ? data.noResolve.value : this.noResolve,
      src: data.src.present ? data.src.value : this.src,
    );
  }

  @override
  String toString() {
    return (StringBuffer('RawRule(')
          ..write('id: $id, ')
          ..write('ruleAction: $ruleAction, ')
          ..write('content: $content, ')
          ..write('ruleTarget: $ruleTarget, ')
          ..write('ruleProvider: $ruleProvider, ')
          ..write('subRule: $subRule, ')
          ..write('noResolve: $noResolve, ')
          ..write('src: $src')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    ruleAction,
    content,
    ruleTarget,
    ruleProvider,
    subRule,
    noResolve,
    src,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is RawRule &&
          other.id == this.id &&
          other.ruleAction == this.ruleAction &&
          other.content == this.content &&
          other.ruleTarget == this.ruleTarget &&
          other.ruleProvider == this.ruleProvider &&
          other.subRule == this.subRule &&
          other.noResolve == this.noResolve &&
          other.src == this.src);
}

class RulesCompanion extends UpdateCompanion<RawRule> {
  final Value<int> id;
  final Value<RuleAction> ruleAction;
  final Value<String?> content;
  final Value<String?> ruleTarget;
  final Value<String?> ruleProvider;
  final Value<String?> subRule;
  final Value<bool> noResolve;
  final Value<bool> src;
  const RulesCompanion({
    this.id = const Value.absent(),
    this.ruleAction = const Value.absent(),
    this.content = const Value.absent(),
    this.ruleTarget = const Value.absent(),
    this.ruleProvider = const Value.absent(),
    this.subRule = const Value.absent(),
    this.noResolve = const Value.absent(),
    this.src = const Value.absent(),
  });
  RulesCompanion.insert({
    this.id = const Value.absent(),
    required RuleAction ruleAction,
    this.content = const Value.absent(),
    this.ruleTarget = const Value.absent(),
    this.ruleProvider = const Value.absent(),
    this.subRule = const Value.absent(),
    this.noResolve = const Value.absent(),
    this.src = const Value.absent(),
  }) : ruleAction = Value(ruleAction);
  static Insertable<RawRule> custom({
    Expression<int>? id,
    Expression<String>? ruleAction,
    Expression<String>? content,
    Expression<String>? ruleTarget,
    Expression<String>? ruleProvider,
    Expression<String>? subRule,
    Expression<bool>? noResolve,
    Expression<bool>? src,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (ruleAction != null) 'rule_action': ruleAction,
      if (content != null) 'content': content,
      if (ruleTarget != null) 'rule_target': ruleTarget,
      if (ruleProvider != null) 'rule_provider': ruleProvider,
      if (subRule != null) 'sub_rule': subRule,
      if (noResolve != null) 'no_resolve': noResolve,
      if (src != null) 'src': src,
    });
  }

  RulesCompanion copyWith({
    Value<int>? id,
    Value<RuleAction>? ruleAction,
    Value<String?>? content,
    Value<String?>? ruleTarget,
    Value<String?>? ruleProvider,
    Value<String?>? subRule,
    Value<bool>? noResolve,
    Value<bool>? src,
  }) {
    return RulesCompanion(
      id: id ?? this.id,
      ruleAction: ruleAction ?? this.ruleAction,
      content: content ?? this.content,
      ruleTarget: ruleTarget ?? this.ruleTarget,
      ruleProvider: ruleProvider ?? this.ruleProvider,
      subRule: subRule ?? this.subRule,
      noResolve: noResolve ?? this.noResolve,
      src: src ?? this.src,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (ruleAction.present) {
      map['rule_action'] = Variable<String>(
        $RulesTable.$converterruleAction.toSql(ruleAction.value),
      );
    }
    if (content.present) {
      map['content'] = Variable<String>(content.value);
    }
    if (ruleTarget.present) {
      map['rule_target'] = Variable<String>(ruleTarget.value);
    }
    if (ruleProvider.present) {
      map['rule_provider'] = Variable<String>(ruleProvider.value);
    }
    if (subRule.present) {
      map['sub_rule'] = Variable<String>(subRule.value);
    }
    if (noResolve.present) {
      map['no_resolve'] = Variable<bool>(noResolve.value);
    }
    if (src.present) {
      map['src'] = Variable<bool>(src.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('RulesCompanion(')
          ..write('id: $id, ')
          ..write('ruleAction: $ruleAction, ')
          ..write('content: $content, ')
          ..write('ruleTarget: $ruleTarget, ')
          ..write('ruleProvider: $ruleProvider, ')
          ..write('subRule: $subRule, ')
          ..write('noResolve: $noResolve, ')
          ..write('src: $src')
          ..write(')'))
        .toString();
  }
}

class $ProfileRuleLinksTable extends ProfileRuleLinks
    with TableInfo<$ProfileRuleLinksTable, RawProfileRuleLink> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ProfileRuleLinksTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _profileIdMeta = const VerificationMeta(
    'profileId',
  );
  @override
  late final GeneratedColumn<int> profileId = GeneratedColumn<int>(
    'profile_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES profiles (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _ruleIdMeta = const VerificationMeta('ruleId');
  @override
  late final GeneratedColumn<int> ruleId = GeneratedColumn<int>(
    'rule_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES rules (id) ON DELETE CASCADE',
    ),
  );
  @override
  late final GeneratedColumnWithTypeConverter<RuleScene?, String> scene =
      GeneratedColumn<String>(
        'scene',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      ).withConverter<RuleScene?>($ProfileRuleLinksTable.$converterscenen);
  static const VerificationMeta _orderMeta = const VerificationMeta('order');
  @override
  late final GeneratedColumn<String> order = GeneratedColumn<String>(
    'order',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [id, profileId, ruleId, scene, order];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'profile_rule_mapping';
  @override
  VerificationContext validateIntegrity(
    Insertable<RawProfileRuleLink> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('profile_id')) {
      context.handle(
        _profileIdMeta,
        profileId.isAcceptableOrUnknown(data['profile_id']!, _profileIdMeta),
      );
    }
    if (data.containsKey('rule_id')) {
      context.handle(
        _ruleIdMeta,
        ruleId.isAcceptableOrUnknown(data['rule_id']!, _ruleIdMeta),
      );
    } else if (isInserting) {
      context.missing(_ruleIdMeta);
    }
    if (data.containsKey('order')) {
      context.handle(
        _orderMeta,
        order.isAcceptableOrUnknown(data['order']!, _orderMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  RawProfileRuleLink map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return RawProfileRuleLink(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      profileId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}profile_id'],
      ),
      ruleId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}rule_id'],
      )!,
      scene: $ProfileRuleLinksTable.$converterscenen.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}scene'],
        ),
      ),
      order: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}order'],
      ),
    );
  }

  @override
  $ProfileRuleLinksTable createAlias(String alias) {
    return $ProfileRuleLinksTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<RuleScene, String, String> $converterscene =
      const EnumNameConverter<RuleScene>(RuleScene.values);
  static JsonTypeConverter2<RuleScene?, String?, String?> $converterscenen =
      JsonTypeConverter2.asNullable($converterscene);
}

class RawProfileRuleLink extends DataClass
    implements Insertable<RawProfileRuleLink> {
  final String id;
  final int? profileId;
  final int ruleId;
  final RuleScene? scene;
  final String? order;
  const RawProfileRuleLink({
    required this.id,
    this.profileId,
    required this.ruleId,
    this.scene,
    this.order,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    if (!nullToAbsent || profileId != null) {
      map['profile_id'] = Variable<int>(profileId);
    }
    map['rule_id'] = Variable<int>(ruleId);
    if (!nullToAbsent || scene != null) {
      map['scene'] = Variable<String>(
        $ProfileRuleLinksTable.$converterscenen.toSql(scene),
      );
    }
    if (!nullToAbsent || order != null) {
      map['order'] = Variable<String>(order);
    }
    return map;
  }

  ProfileRuleLinksCompanion toCompanion(bool nullToAbsent) {
    return ProfileRuleLinksCompanion(
      id: Value(id),
      profileId: profileId == null && nullToAbsent
          ? const Value.absent()
          : Value(profileId),
      ruleId: Value(ruleId),
      scene: scene == null && nullToAbsent
          ? const Value.absent()
          : Value(scene),
      order: order == null && nullToAbsent
          ? const Value.absent()
          : Value(order),
    );
  }

  factory RawProfileRuleLink.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return RawProfileRuleLink(
      id: serializer.fromJson<String>(json['id']),
      profileId: serializer.fromJson<int?>(json['profileId']),
      ruleId: serializer.fromJson<int>(json['ruleId']),
      scene: $ProfileRuleLinksTable.$converterscenen.fromJson(
        serializer.fromJson<String?>(json['scene']),
      ),
      order: serializer.fromJson<String?>(json['order']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'profileId': serializer.toJson<int?>(profileId),
      'ruleId': serializer.toJson<int>(ruleId),
      'scene': serializer.toJson<String?>(
        $ProfileRuleLinksTable.$converterscenen.toJson(scene),
      ),
      'order': serializer.toJson<String?>(order),
    };
  }

  RawProfileRuleLink copyWith({
    String? id,
    Value<int?> profileId = const Value.absent(),
    int? ruleId,
    Value<RuleScene?> scene = const Value.absent(),
    Value<String?> order = const Value.absent(),
  }) => RawProfileRuleLink(
    id: id ?? this.id,
    profileId: profileId.present ? profileId.value : this.profileId,
    ruleId: ruleId ?? this.ruleId,
    scene: scene.present ? scene.value : this.scene,
    order: order.present ? order.value : this.order,
  );
  RawProfileRuleLink copyWithCompanion(ProfileRuleLinksCompanion data) {
    return RawProfileRuleLink(
      id: data.id.present ? data.id.value : this.id,
      profileId: data.profileId.present ? data.profileId.value : this.profileId,
      ruleId: data.ruleId.present ? data.ruleId.value : this.ruleId,
      scene: data.scene.present ? data.scene.value : this.scene,
      order: data.order.present ? data.order.value : this.order,
    );
  }

  @override
  String toString() {
    return (StringBuffer('RawProfileRuleLink(')
          ..write('id: $id, ')
          ..write('profileId: $profileId, ')
          ..write('ruleId: $ruleId, ')
          ..write('scene: $scene, ')
          ..write('order: $order')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, profileId, ruleId, scene, order);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is RawProfileRuleLink &&
          other.id == this.id &&
          other.profileId == this.profileId &&
          other.ruleId == this.ruleId &&
          other.scene == this.scene &&
          other.order == this.order);
}

class ProfileRuleLinksCompanion extends UpdateCompanion<RawProfileRuleLink> {
  final Value<String> id;
  final Value<int?> profileId;
  final Value<int> ruleId;
  final Value<RuleScene?> scene;
  final Value<String?> order;
  final Value<int> rowid;
  const ProfileRuleLinksCompanion({
    this.id = const Value.absent(),
    this.profileId = const Value.absent(),
    this.ruleId = const Value.absent(),
    this.scene = const Value.absent(),
    this.order = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ProfileRuleLinksCompanion.insert({
    required String id,
    this.profileId = const Value.absent(),
    required int ruleId,
    this.scene = const Value.absent(),
    this.order = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       ruleId = Value(ruleId);
  static Insertable<RawProfileRuleLink> custom({
    Expression<String>? id,
    Expression<int>? profileId,
    Expression<int>? ruleId,
    Expression<String>? scene,
    Expression<String>? order,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (profileId != null) 'profile_id': profileId,
      if (ruleId != null) 'rule_id': ruleId,
      if (scene != null) 'scene': scene,
      if (order != null) 'order': order,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ProfileRuleLinksCompanion copyWith({
    Value<String>? id,
    Value<int?>? profileId,
    Value<int>? ruleId,
    Value<RuleScene?>? scene,
    Value<String?>? order,
    Value<int>? rowid,
  }) {
    return ProfileRuleLinksCompanion(
      id: id ?? this.id,
      profileId: profileId ?? this.profileId,
      ruleId: ruleId ?? this.ruleId,
      scene: scene ?? this.scene,
      order: order ?? this.order,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (profileId.present) {
      map['profile_id'] = Variable<int>(profileId.value);
    }
    if (ruleId.present) {
      map['rule_id'] = Variable<int>(ruleId.value);
    }
    if (scene.present) {
      map['scene'] = Variable<String>(
        $ProfileRuleLinksTable.$converterscenen.toSql(scene.value),
      );
    }
    if (order.present) {
      map['order'] = Variable<String>(order.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ProfileRuleLinksCompanion(')
          ..write('id: $id, ')
          ..write('profileId: $profileId, ')
          ..write('ruleId: $ruleId, ')
          ..write('scene: $scene, ')
          ..write('order: $order, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ProxyGroupsTable extends ProxyGroups
    with TableInfo<$ProxyGroupsTable, RawProxyGroup> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ProxyGroupsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _profileIdMeta = const VerificationMeta(
    'profileId',
  );
  @override
  late final GeneratedColumn<int> profileId = GeneratedColumn<int>(
    'profile_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES profiles (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<String> type = GeneratedColumn<String>(
    'type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  late final GeneratedColumnWithTypeConverter<List<String>?, String> proxies =
      GeneratedColumn<String>(
        'proxies',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      ).withConverter<List<String>?>($ProxyGroupsTable.$converterproxiesn);
  @override
  late final GeneratedColumnWithTypeConverter<List<String>?, String> use =
      GeneratedColumn<String>(
        'use',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      ).withConverter<List<String>?>($ProxyGroupsTable.$converterusen);
  static const VerificationMeta _urlMeta = const VerificationMeta('url');
  @override
  late final GeneratedColumn<String> url = GeneratedColumn<String>(
    'url',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _intervalMeta = const VerificationMeta(
    'interval',
  );
  @override
  late final GeneratedColumn<int> interval = GeneratedColumn<int>(
    'interval',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _timeoutMeta = const VerificationMeta(
    'timeout',
  );
  @override
  late final GeneratedColumn<int> timeout = GeneratedColumn<int>(
    'timeout',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _maxFailedTimesMeta = const VerificationMeta(
    'maxFailedTimes',
  );
  @override
  late final GeneratedColumn<int> maxFailedTimes = GeneratedColumn<int>(
    'max_failed_times',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _lazyMeta = const VerificationMeta('lazy');
  @override
  late final GeneratedColumn<bool> lazy = GeneratedColumn<bool>(
    'lazy',
    aliasedName,
    true,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("lazy" IN (0, 1))',
    ),
  );
  static const VerificationMeta _disableUDPMeta = const VerificationMeta(
    'disableUDP',
  );
  @override
  late final GeneratedColumn<bool> disableUDP = GeneratedColumn<bool>(
    'disable_u_d_p',
    aliasedName,
    true,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("disable_u_d_p" IN (0, 1))',
    ),
  );
  static const VerificationMeta _filterMeta = const VerificationMeta('filter');
  @override
  late final GeneratedColumn<String> filter = GeneratedColumn<String>(
    'filter',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _excludeFilterMeta = const VerificationMeta(
    'excludeFilter',
  );
  @override
  late final GeneratedColumn<String> excludeFilter = GeneratedColumn<String>(
    'exclude_filter',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _excludeTypeMeta = const VerificationMeta(
    'excludeType',
  );
  @override
  late final GeneratedColumn<String> excludeType = GeneratedColumn<String>(
    'exclude_type',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _expectedStatusMeta = const VerificationMeta(
    'expectedStatus',
  );
  @override
  late final GeneratedColumn<String> expectedStatus = GeneratedColumn<String>(
    'expected_status',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _includeAllMeta = const VerificationMeta(
    'includeAll',
  );
  @override
  late final GeneratedColumn<bool> includeAll = GeneratedColumn<bool>(
    'include_all',
    aliasedName,
    true,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("include_all" IN (0, 1))',
    ),
  );
  static const VerificationMeta _includeAllProxiesMeta = const VerificationMeta(
    'includeAllProxies',
  );
  @override
  late final GeneratedColumn<bool> includeAllProxies = GeneratedColumn<bool>(
    'include_all_proxies',
    aliasedName,
    true,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("include_all_proxies" IN (0, 1))',
    ),
  );
  static const VerificationMeta _includeAllProvidersMeta =
      const VerificationMeta('includeAllProviders');
  @override
  late final GeneratedColumn<bool> includeAllProviders = GeneratedColumn<bool>(
    'include_all_providers',
    aliasedName,
    true,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("include_all_providers" IN (0, 1))',
    ),
  );
  static const VerificationMeta _hiddenMeta = const VerificationMeta('hidden');
  @override
  late final GeneratedColumn<bool> hidden = GeneratedColumn<bool>(
    'hidden',
    aliasedName,
    true,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("hidden" IN (0, 1))',
    ),
  );
  static const VerificationMeta _iconMeta = const VerificationMeta('icon');
  @override
  late final GeneratedColumn<String> icon = GeneratedColumn<String>(
    'icon',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _orderMeta = const VerificationMeta('order');
  @override
  late final GeneratedColumn<String> order = GeneratedColumn<String>(
    'order',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    profileId,
    name,
    type,
    proxies,
    use,
    url,
    interval,
    timeout,
    maxFailedTimes,
    lazy,
    disableUDP,
    filter,
    excludeFilter,
    excludeType,
    expectedStatus,
    includeAll,
    includeAllProxies,
    includeAllProviders,
    hidden,
    icon,
    order,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'proxy_groups';
  @override
  VerificationContext validateIntegrity(
    Insertable<RawProxyGroup> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('profile_id')) {
      context.handle(
        _profileIdMeta,
        profileId.isAcceptableOrUnknown(data['profile_id']!, _profileIdMeta),
      );
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('type')) {
      context.handle(
        _typeMeta,
        type.isAcceptableOrUnknown(data['type']!, _typeMeta),
      );
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    if (data.containsKey('url')) {
      context.handle(
        _urlMeta,
        url.isAcceptableOrUnknown(data['url']!, _urlMeta),
      );
    }
    if (data.containsKey('interval')) {
      context.handle(
        _intervalMeta,
        interval.isAcceptableOrUnknown(data['interval']!, _intervalMeta),
      );
    }
    if (data.containsKey('timeout')) {
      context.handle(
        _timeoutMeta,
        timeout.isAcceptableOrUnknown(data['timeout']!, _timeoutMeta),
      );
    }
    if (data.containsKey('max_failed_times')) {
      context.handle(
        _maxFailedTimesMeta,
        maxFailedTimes.isAcceptableOrUnknown(
          data['max_failed_times']!,
          _maxFailedTimesMeta,
        ),
      );
    }
    if (data.containsKey('lazy')) {
      context.handle(
        _lazyMeta,
        lazy.isAcceptableOrUnknown(data['lazy']!, _lazyMeta),
      );
    }
    if (data.containsKey('disable_u_d_p')) {
      context.handle(
        _disableUDPMeta,
        disableUDP.isAcceptableOrUnknown(
          data['disable_u_d_p']!,
          _disableUDPMeta,
        ),
      );
    }
    if (data.containsKey('filter')) {
      context.handle(
        _filterMeta,
        filter.isAcceptableOrUnknown(data['filter']!, _filterMeta),
      );
    }
    if (data.containsKey('exclude_filter')) {
      context.handle(
        _excludeFilterMeta,
        excludeFilter.isAcceptableOrUnknown(
          data['exclude_filter']!,
          _excludeFilterMeta,
        ),
      );
    }
    if (data.containsKey('exclude_type')) {
      context.handle(
        _excludeTypeMeta,
        excludeType.isAcceptableOrUnknown(
          data['exclude_type']!,
          _excludeTypeMeta,
        ),
      );
    }
    if (data.containsKey('expected_status')) {
      context.handle(
        _expectedStatusMeta,
        expectedStatus.isAcceptableOrUnknown(
          data['expected_status']!,
          _expectedStatusMeta,
        ),
      );
    }
    if (data.containsKey('include_all')) {
      context.handle(
        _includeAllMeta,
        includeAll.isAcceptableOrUnknown(data['include_all']!, _includeAllMeta),
      );
    }
    if (data.containsKey('include_all_proxies')) {
      context.handle(
        _includeAllProxiesMeta,
        includeAllProxies.isAcceptableOrUnknown(
          data['include_all_proxies']!,
          _includeAllProxiesMeta,
        ),
      );
    }
    if (data.containsKey('include_all_providers')) {
      context.handle(
        _includeAllProvidersMeta,
        includeAllProviders.isAcceptableOrUnknown(
          data['include_all_providers']!,
          _includeAllProvidersMeta,
        ),
      );
    }
    if (data.containsKey('hidden')) {
      context.handle(
        _hiddenMeta,
        hidden.isAcceptableOrUnknown(data['hidden']!, _hiddenMeta),
      );
    }
    if (data.containsKey('icon')) {
      context.handle(
        _iconMeta,
        icon.isAcceptableOrUnknown(data['icon']!, _iconMeta),
      );
    }
    if (data.containsKey('order')) {
      context.handle(
        _orderMeta,
        order.isAcceptableOrUnknown(data['order']!, _orderMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  RawProxyGroup map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return RawProxyGroup(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      profileId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}profile_id'],
      ),
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      type: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}type'],
      )!,
      proxies: $ProxyGroupsTable.$converterproxiesn.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}proxies'],
        ),
      ),
      use: $ProxyGroupsTable.$converterusen.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}use'],
        ),
      ),
      url: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}url'],
      ),
      interval: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}interval'],
      ),
      timeout: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}timeout'],
      ),
      maxFailedTimes: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}max_failed_times'],
      ),
      lazy: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}lazy'],
      ),
      disableUDP: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}disable_u_d_p'],
      ),
      filter: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}filter'],
      ),
      excludeFilter: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}exclude_filter'],
      ),
      excludeType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}exclude_type'],
      ),
      expectedStatus: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}expected_status'],
      ),
      includeAll: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}include_all'],
      ),
      includeAllProxies: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}include_all_proxies'],
      ),
      includeAllProviders: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}include_all_providers'],
      ),
      hidden: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}hidden'],
      ),
      icon: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}icon'],
      ),
      order: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}order'],
      ),
    );
  }

  @override
  $ProxyGroupsTable createAlias(String alias) {
    return $ProxyGroupsTable(attachedDatabase, alias);
  }

  static TypeConverter<List<String>, String> $converterproxies =
      const StringListConverter();
  static TypeConverter<List<String>?, String?> $converterproxiesn =
      NullAwareTypeConverter.wrap($converterproxies);
  static TypeConverter<List<String>, String> $converteruse =
      const StringListConverter();
  static TypeConverter<List<String>?, String?> $converterusen =
      NullAwareTypeConverter.wrap($converteruse);
}

class RawProxyGroup extends DataClass implements Insertable<RawProxyGroup> {
  final int id;
  final int? profileId;
  final String name;
  final String type;
  final List<String>? proxies;
  final List<String>? use;
  final String? url;
  final int? interval;
  final int? timeout;
  final int? maxFailedTimes;
  final bool? lazy;
  final bool? disableUDP;
  final String? filter;
  final String? excludeFilter;
  final String? excludeType;
  final String? expectedStatus;
  final bool? includeAll;
  final bool? includeAllProxies;
  final bool? includeAllProviders;
  final bool? hidden;
  final String? icon;
  final String? order;
  const RawProxyGroup({
    required this.id,
    this.profileId,
    required this.name,
    required this.type,
    this.proxies,
    this.use,
    this.url,
    this.interval,
    this.timeout,
    this.maxFailedTimes,
    this.lazy,
    this.disableUDP,
    this.filter,
    this.excludeFilter,
    this.excludeType,
    this.expectedStatus,
    this.includeAll,
    this.includeAllProxies,
    this.includeAllProviders,
    this.hidden,
    this.icon,
    this.order,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || profileId != null) {
      map['profile_id'] = Variable<int>(profileId);
    }
    map['name'] = Variable<String>(name);
    map['type'] = Variable<String>(type);
    if (!nullToAbsent || proxies != null) {
      map['proxies'] = Variable<String>(
        $ProxyGroupsTable.$converterproxiesn.toSql(proxies),
      );
    }
    if (!nullToAbsent || use != null) {
      map['use'] = Variable<String>(
        $ProxyGroupsTable.$converterusen.toSql(use),
      );
    }
    if (!nullToAbsent || url != null) {
      map['url'] = Variable<String>(url);
    }
    if (!nullToAbsent || interval != null) {
      map['interval'] = Variable<int>(interval);
    }
    if (!nullToAbsent || timeout != null) {
      map['timeout'] = Variable<int>(timeout);
    }
    if (!nullToAbsent || maxFailedTimes != null) {
      map['max_failed_times'] = Variable<int>(maxFailedTimes);
    }
    if (!nullToAbsent || lazy != null) {
      map['lazy'] = Variable<bool>(lazy);
    }
    if (!nullToAbsent || disableUDP != null) {
      map['disable_u_d_p'] = Variable<bool>(disableUDP);
    }
    if (!nullToAbsent || filter != null) {
      map['filter'] = Variable<String>(filter);
    }
    if (!nullToAbsent || excludeFilter != null) {
      map['exclude_filter'] = Variable<String>(excludeFilter);
    }
    if (!nullToAbsent || excludeType != null) {
      map['exclude_type'] = Variable<String>(excludeType);
    }
    if (!nullToAbsent || expectedStatus != null) {
      map['expected_status'] = Variable<String>(expectedStatus);
    }
    if (!nullToAbsent || includeAll != null) {
      map['include_all'] = Variable<bool>(includeAll);
    }
    if (!nullToAbsent || includeAllProxies != null) {
      map['include_all_proxies'] = Variable<bool>(includeAllProxies);
    }
    if (!nullToAbsent || includeAllProviders != null) {
      map['include_all_providers'] = Variable<bool>(includeAllProviders);
    }
    if (!nullToAbsent || hidden != null) {
      map['hidden'] = Variable<bool>(hidden);
    }
    if (!nullToAbsent || icon != null) {
      map['icon'] = Variable<String>(icon);
    }
    if (!nullToAbsent || order != null) {
      map['order'] = Variable<String>(order);
    }
    return map;
  }

  ProxyGroupsCompanion toCompanion(bool nullToAbsent) {
    return ProxyGroupsCompanion(
      id: Value(id),
      profileId: profileId == null && nullToAbsent
          ? const Value.absent()
          : Value(profileId),
      name: Value(name),
      type: Value(type),
      proxies: proxies == null && nullToAbsent
          ? const Value.absent()
          : Value(proxies),
      use: use == null && nullToAbsent ? const Value.absent() : Value(use),
      url: url == null && nullToAbsent ? const Value.absent() : Value(url),
      interval: interval == null && nullToAbsent
          ? const Value.absent()
          : Value(interval),
      timeout: timeout == null && nullToAbsent
          ? const Value.absent()
          : Value(timeout),
      maxFailedTimes: maxFailedTimes == null && nullToAbsent
          ? const Value.absent()
          : Value(maxFailedTimes),
      lazy: lazy == null && nullToAbsent ? const Value.absent() : Value(lazy),
      disableUDP: disableUDP == null && nullToAbsent
          ? const Value.absent()
          : Value(disableUDP),
      filter: filter == null && nullToAbsent
          ? const Value.absent()
          : Value(filter),
      excludeFilter: excludeFilter == null && nullToAbsent
          ? const Value.absent()
          : Value(excludeFilter),
      excludeType: excludeType == null && nullToAbsent
          ? const Value.absent()
          : Value(excludeType),
      expectedStatus: expectedStatus == null && nullToAbsent
          ? const Value.absent()
          : Value(expectedStatus),
      includeAll: includeAll == null && nullToAbsent
          ? const Value.absent()
          : Value(includeAll),
      includeAllProxies: includeAllProxies == null && nullToAbsent
          ? const Value.absent()
          : Value(includeAllProxies),
      includeAllProviders: includeAllProviders == null && nullToAbsent
          ? const Value.absent()
          : Value(includeAllProviders),
      hidden: hidden == null && nullToAbsent
          ? const Value.absent()
          : Value(hidden),
      icon: icon == null && nullToAbsent ? const Value.absent() : Value(icon),
      order: order == null && nullToAbsent
          ? const Value.absent()
          : Value(order),
    );
  }

  factory RawProxyGroup.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return RawProxyGroup(
      id: serializer.fromJson<int>(json['id']),
      profileId: serializer.fromJson<int?>(json['profileId']),
      name: serializer.fromJson<String>(json['name']),
      type: serializer.fromJson<String>(json['type']),
      proxies: serializer.fromJson<List<String>?>(json['proxies']),
      use: serializer.fromJson<List<String>?>(json['use']),
      url: serializer.fromJson<String?>(json['url']),
      interval: serializer.fromJson<int?>(json['interval']),
      timeout: serializer.fromJson<int?>(json['timeout']),
      maxFailedTimes: serializer.fromJson<int?>(json['maxFailedTimes']),
      lazy: serializer.fromJson<bool?>(json['lazy']),
      disableUDP: serializer.fromJson<bool?>(json['disableUDP']),
      filter: serializer.fromJson<String?>(json['filter']),
      excludeFilter: serializer.fromJson<String?>(json['excludeFilter']),
      excludeType: serializer.fromJson<String?>(json['excludeType']),
      expectedStatus: serializer.fromJson<String?>(json['expectedStatus']),
      includeAll: serializer.fromJson<bool?>(json['includeAll']),
      includeAllProxies: serializer.fromJson<bool?>(json['includeAllProxies']),
      includeAllProviders: serializer.fromJson<bool?>(
        json['includeAllProviders'],
      ),
      hidden: serializer.fromJson<bool?>(json['hidden']),
      icon: serializer.fromJson<String?>(json['icon']),
      order: serializer.fromJson<String?>(json['order']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'profileId': serializer.toJson<int?>(profileId),
      'name': serializer.toJson<String>(name),
      'type': serializer.toJson<String>(type),
      'proxies': serializer.toJson<List<String>?>(proxies),
      'use': serializer.toJson<List<String>?>(use),
      'url': serializer.toJson<String?>(url),
      'interval': serializer.toJson<int?>(interval),
      'timeout': serializer.toJson<int?>(timeout),
      'maxFailedTimes': serializer.toJson<int?>(maxFailedTimes),
      'lazy': serializer.toJson<bool?>(lazy),
      'disableUDP': serializer.toJson<bool?>(disableUDP),
      'filter': serializer.toJson<String?>(filter),
      'excludeFilter': serializer.toJson<String?>(excludeFilter),
      'excludeType': serializer.toJson<String?>(excludeType),
      'expectedStatus': serializer.toJson<String?>(expectedStatus),
      'includeAll': serializer.toJson<bool?>(includeAll),
      'includeAllProxies': serializer.toJson<bool?>(includeAllProxies),
      'includeAllProviders': serializer.toJson<bool?>(includeAllProviders),
      'hidden': serializer.toJson<bool?>(hidden),
      'icon': serializer.toJson<String?>(icon),
      'order': serializer.toJson<String?>(order),
    };
  }

  RawProxyGroup copyWith({
    int? id,
    Value<int?> profileId = const Value.absent(),
    String? name,
    String? type,
    Value<List<String>?> proxies = const Value.absent(),
    Value<List<String>?> use = const Value.absent(),
    Value<String?> url = const Value.absent(),
    Value<int?> interval = const Value.absent(),
    Value<int?> timeout = const Value.absent(),
    Value<int?> maxFailedTimes = const Value.absent(),
    Value<bool?> lazy = const Value.absent(),
    Value<bool?> disableUDP = const Value.absent(),
    Value<String?> filter = const Value.absent(),
    Value<String?> excludeFilter = const Value.absent(),
    Value<String?> excludeType = const Value.absent(),
    Value<String?> expectedStatus = const Value.absent(),
    Value<bool?> includeAll = const Value.absent(),
    Value<bool?> includeAllProxies = const Value.absent(),
    Value<bool?> includeAllProviders = const Value.absent(),
    Value<bool?> hidden = const Value.absent(),
    Value<String?> icon = const Value.absent(),
    Value<String?> order = const Value.absent(),
  }) => RawProxyGroup(
    id: id ?? this.id,
    profileId: profileId.present ? profileId.value : this.profileId,
    name: name ?? this.name,
    type: type ?? this.type,
    proxies: proxies.present ? proxies.value : this.proxies,
    use: use.present ? use.value : this.use,
    url: url.present ? url.value : this.url,
    interval: interval.present ? interval.value : this.interval,
    timeout: timeout.present ? timeout.value : this.timeout,
    maxFailedTimes: maxFailedTimes.present
        ? maxFailedTimes.value
        : this.maxFailedTimes,
    lazy: lazy.present ? lazy.value : this.lazy,
    disableUDP: disableUDP.present ? disableUDP.value : this.disableUDP,
    filter: filter.present ? filter.value : this.filter,
    excludeFilter: excludeFilter.present
        ? excludeFilter.value
        : this.excludeFilter,
    excludeType: excludeType.present ? excludeType.value : this.excludeType,
    expectedStatus: expectedStatus.present
        ? expectedStatus.value
        : this.expectedStatus,
    includeAll: includeAll.present ? includeAll.value : this.includeAll,
    includeAllProxies: includeAllProxies.present
        ? includeAllProxies.value
        : this.includeAllProxies,
    includeAllProviders: includeAllProviders.present
        ? includeAllProviders.value
        : this.includeAllProviders,
    hidden: hidden.present ? hidden.value : this.hidden,
    icon: icon.present ? icon.value : this.icon,
    order: order.present ? order.value : this.order,
  );
  RawProxyGroup copyWithCompanion(ProxyGroupsCompanion data) {
    return RawProxyGroup(
      id: data.id.present ? data.id.value : this.id,
      profileId: data.profileId.present ? data.profileId.value : this.profileId,
      name: data.name.present ? data.name.value : this.name,
      type: data.type.present ? data.type.value : this.type,
      proxies: data.proxies.present ? data.proxies.value : this.proxies,
      use: data.use.present ? data.use.value : this.use,
      url: data.url.present ? data.url.value : this.url,
      interval: data.interval.present ? data.interval.value : this.interval,
      timeout: data.timeout.present ? data.timeout.value : this.timeout,
      maxFailedTimes: data.maxFailedTimes.present
          ? data.maxFailedTimes.value
          : this.maxFailedTimes,
      lazy: data.lazy.present ? data.lazy.value : this.lazy,
      disableUDP: data.disableUDP.present
          ? data.disableUDP.value
          : this.disableUDP,
      filter: data.filter.present ? data.filter.value : this.filter,
      excludeFilter: data.excludeFilter.present
          ? data.excludeFilter.value
          : this.excludeFilter,
      excludeType: data.excludeType.present
          ? data.excludeType.value
          : this.excludeType,
      expectedStatus: data.expectedStatus.present
          ? data.expectedStatus.value
          : this.expectedStatus,
      includeAll: data.includeAll.present
          ? data.includeAll.value
          : this.includeAll,
      includeAllProxies: data.includeAllProxies.present
          ? data.includeAllProxies.value
          : this.includeAllProxies,
      includeAllProviders: data.includeAllProviders.present
          ? data.includeAllProviders.value
          : this.includeAllProviders,
      hidden: data.hidden.present ? data.hidden.value : this.hidden,
      icon: data.icon.present ? data.icon.value : this.icon,
      order: data.order.present ? data.order.value : this.order,
    );
  }

  @override
  String toString() {
    return (StringBuffer('RawProxyGroup(')
          ..write('id: $id, ')
          ..write('profileId: $profileId, ')
          ..write('name: $name, ')
          ..write('type: $type, ')
          ..write('proxies: $proxies, ')
          ..write('use: $use, ')
          ..write('url: $url, ')
          ..write('interval: $interval, ')
          ..write('timeout: $timeout, ')
          ..write('maxFailedTimes: $maxFailedTimes, ')
          ..write('lazy: $lazy, ')
          ..write('disableUDP: $disableUDP, ')
          ..write('filter: $filter, ')
          ..write('excludeFilter: $excludeFilter, ')
          ..write('excludeType: $excludeType, ')
          ..write('expectedStatus: $expectedStatus, ')
          ..write('includeAll: $includeAll, ')
          ..write('includeAllProxies: $includeAllProxies, ')
          ..write('includeAllProviders: $includeAllProviders, ')
          ..write('hidden: $hidden, ')
          ..write('icon: $icon, ')
          ..write('order: $order')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hashAll([
    id,
    profileId,
    name,
    type,
    proxies,
    use,
    url,
    interval,
    timeout,
    maxFailedTimes,
    lazy,
    disableUDP,
    filter,
    excludeFilter,
    excludeType,
    expectedStatus,
    includeAll,
    includeAllProxies,
    includeAllProviders,
    hidden,
    icon,
    order,
  ]);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is RawProxyGroup &&
          other.id == this.id &&
          other.profileId == this.profileId &&
          other.name == this.name &&
          other.type == this.type &&
          other.proxies == this.proxies &&
          other.use == this.use &&
          other.url == this.url &&
          other.interval == this.interval &&
          other.timeout == this.timeout &&
          other.maxFailedTimes == this.maxFailedTimes &&
          other.lazy == this.lazy &&
          other.disableUDP == this.disableUDP &&
          other.filter == this.filter &&
          other.excludeFilter == this.excludeFilter &&
          other.excludeType == this.excludeType &&
          other.expectedStatus == this.expectedStatus &&
          other.includeAll == this.includeAll &&
          other.includeAllProxies == this.includeAllProxies &&
          other.includeAllProviders == this.includeAllProviders &&
          other.hidden == this.hidden &&
          other.icon == this.icon &&
          other.order == this.order);
}

class ProxyGroupsCompanion extends UpdateCompanion<RawProxyGroup> {
  final Value<int> id;
  final Value<int?> profileId;
  final Value<String> name;
  final Value<String> type;
  final Value<List<String>?> proxies;
  final Value<List<String>?> use;
  final Value<String?> url;
  final Value<int?> interval;
  final Value<int?> timeout;
  final Value<int?> maxFailedTimes;
  final Value<bool?> lazy;
  final Value<bool?> disableUDP;
  final Value<String?> filter;
  final Value<String?> excludeFilter;
  final Value<String?> excludeType;
  final Value<String?> expectedStatus;
  final Value<bool?> includeAll;
  final Value<bool?> includeAllProxies;
  final Value<bool?> includeAllProviders;
  final Value<bool?> hidden;
  final Value<String?> icon;
  final Value<String?> order;
  const ProxyGroupsCompanion({
    this.id = const Value.absent(),
    this.profileId = const Value.absent(),
    this.name = const Value.absent(),
    this.type = const Value.absent(),
    this.proxies = const Value.absent(),
    this.use = const Value.absent(),
    this.url = const Value.absent(),
    this.interval = const Value.absent(),
    this.timeout = const Value.absent(),
    this.maxFailedTimes = const Value.absent(),
    this.lazy = const Value.absent(),
    this.disableUDP = const Value.absent(),
    this.filter = const Value.absent(),
    this.excludeFilter = const Value.absent(),
    this.excludeType = const Value.absent(),
    this.expectedStatus = const Value.absent(),
    this.includeAll = const Value.absent(),
    this.includeAllProxies = const Value.absent(),
    this.includeAllProviders = const Value.absent(),
    this.hidden = const Value.absent(),
    this.icon = const Value.absent(),
    this.order = const Value.absent(),
  });
  ProxyGroupsCompanion.insert({
    this.id = const Value.absent(),
    this.profileId = const Value.absent(),
    required String name,
    required String type,
    this.proxies = const Value.absent(),
    this.use = const Value.absent(),
    this.url = const Value.absent(),
    this.interval = const Value.absent(),
    this.timeout = const Value.absent(),
    this.maxFailedTimes = const Value.absent(),
    this.lazy = const Value.absent(),
    this.disableUDP = const Value.absent(),
    this.filter = const Value.absent(),
    this.excludeFilter = const Value.absent(),
    this.excludeType = const Value.absent(),
    this.expectedStatus = const Value.absent(),
    this.includeAll = const Value.absent(),
    this.includeAllProxies = const Value.absent(),
    this.includeAllProviders = const Value.absent(),
    this.hidden = const Value.absent(),
    this.icon = const Value.absent(),
    this.order = const Value.absent(),
  }) : name = Value(name),
       type = Value(type);
  static Insertable<RawProxyGroup> custom({
    Expression<int>? id,
    Expression<int>? profileId,
    Expression<String>? name,
    Expression<String>? type,
    Expression<String>? proxies,
    Expression<String>? use,
    Expression<String>? url,
    Expression<int>? interval,
    Expression<int>? timeout,
    Expression<int>? maxFailedTimes,
    Expression<bool>? lazy,
    Expression<bool>? disableUDP,
    Expression<String>? filter,
    Expression<String>? excludeFilter,
    Expression<String>? excludeType,
    Expression<String>? expectedStatus,
    Expression<bool>? includeAll,
    Expression<bool>? includeAllProxies,
    Expression<bool>? includeAllProviders,
    Expression<bool>? hidden,
    Expression<String>? icon,
    Expression<String>? order,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (profileId != null) 'profile_id': profileId,
      if (name != null) 'name': name,
      if (type != null) 'type': type,
      if (proxies != null) 'proxies': proxies,
      if (use != null) 'use': use,
      if (url != null) 'url': url,
      if (interval != null) 'interval': interval,
      if (timeout != null) 'timeout': timeout,
      if (maxFailedTimes != null) 'max_failed_times': maxFailedTimes,
      if (lazy != null) 'lazy': lazy,
      if (disableUDP != null) 'disable_u_d_p': disableUDP,
      if (filter != null) 'filter': filter,
      if (excludeFilter != null) 'exclude_filter': excludeFilter,
      if (excludeType != null) 'exclude_type': excludeType,
      if (expectedStatus != null) 'expected_status': expectedStatus,
      if (includeAll != null) 'include_all': includeAll,
      if (includeAllProxies != null) 'include_all_proxies': includeAllProxies,
      if (includeAllProviders != null)
        'include_all_providers': includeAllProviders,
      if (hidden != null) 'hidden': hidden,
      if (icon != null) 'icon': icon,
      if (order != null) 'order': order,
    });
  }

  ProxyGroupsCompanion copyWith({
    Value<int>? id,
    Value<int?>? profileId,
    Value<String>? name,
    Value<String>? type,
    Value<List<String>?>? proxies,
    Value<List<String>?>? use,
    Value<String?>? url,
    Value<int?>? interval,
    Value<int?>? timeout,
    Value<int?>? maxFailedTimes,
    Value<bool?>? lazy,
    Value<bool?>? disableUDP,
    Value<String?>? filter,
    Value<String?>? excludeFilter,
    Value<String?>? excludeType,
    Value<String?>? expectedStatus,
    Value<bool?>? includeAll,
    Value<bool?>? includeAllProxies,
    Value<bool?>? includeAllProviders,
    Value<bool?>? hidden,
    Value<String?>? icon,
    Value<String?>? order,
  }) {
    return ProxyGroupsCompanion(
      id: id ?? this.id,
      profileId: profileId ?? this.profileId,
      name: name ?? this.name,
      type: type ?? this.type,
      proxies: proxies ?? this.proxies,
      use: use ?? this.use,
      url: url ?? this.url,
      interval: interval ?? this.interval,
      timeout: timeout ?? this.timeout,
      maxFailedTimes: maxFailedTimes ?? this.maxFailedTimes,
      lazy: lazy ?? this.lazy,
      disableUDP: disableUDP ?? this.disableUDP,
      filter: filter ?? this.filter,
      excludeFilter: excludeFilter ?? this.excludeFilter,
      excludeType: excludeType ?? this.excludeType,
      expectedStatus: expectedStatus ?? this.expectedStatus,
      includeAll: includeAll ?? this.includeAll,
      includeAllProxies: includeAllProxies ?? this.includeAllProxies,
      includeAllProviders: includeAllProviders ?? this.includeAllProviders,
      hidden: hidden ?? this.hidden,
      icon: icon ?? this.icon,
      order: order ?? this.order,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (profileId.present) {
      map['profile_id'] = Variable<int>(profileId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (proxies.present) {
      map['proxies'] = Variable<String>(
        $ProxyGroupsTable.$converterproxiesn.toSql(proxies.value),
      );
    }
    if (use.present) {
      map['use'] = Variable<String>(
        $ProxyGroupsTable.$converterusen.toSql(use.value),
      );
    }
    if (url.present) {
      map['url'] = Variable<String>(url.value);
    }
    if (interval.present) {
      map['interval'] = Variable<int>(interval.value);
    }
    if (timeout.present) {
      map['timeout'] = Variable<int>(timeout.value);
    }
    if (maxFailedTimes.present) {
      map['max_failed_times'] = Variable<int>(maxFailedTimes.value);
    }
    if (lazy.present) {
      map['lazy'] = Variable<bool>(lazy.value);
    }
    if (disableUDP.present) {
      map['disable_u_d_p'] = Variable<bool>(disableUDP.value);
    }
    if (filter.present) {
      map['filter'] = Variable<String>(filter.value);
    }
    if (excludeFilter.present) {
      map['exclude_filter'] = Variable<String>(excludeFilter.value);
    }
    if (excludeType.present) {
      map['exclude_type'] = Variable<String>(excludeType.value);
    }
    if (expectedStatus.present) {
      map['expected_status'] = Variable<String>(expectedStatus.value);
    }
    if (includeAll.present) {
      map['include_all'] = Variable<bool>(includeAll.value);
    }
    if (includeAllProxies.present) {
      map['include_all_proxies'] = Variable<bool>(includeAllProxies.value);
    }
    if (includeAllProviders.present) {
      map['include_all_providers'] = Variable<bool>(includeAllProviders.value);
    }
    if (hidden.present) {
      map['hidden'] = Variable<bool>(hidden.value);
    }
    if (icon.present) {
      map['icon'] = Variable<String>(icon.value);
    }
    if (order.present) {
      map['order'] = Variable<String>(order.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ProxyGroupsCompanion(')
          ..write('id: $id, ')
          ..write('profileId: $profileId, ')
          ..write('name: $name, ')
          ..write('type: $type, ')
          ..write('proxies: $proxies, ')
          ..write('use: $use, ')
          ..write('url: $url, ')
          ..write('interval: $interval, ')
          ..write('timeout: $timeout, ')
          ..write('maxFailedTimes: $maxFailedTimes, ')
          ..write('lazy: $lazy, ')
          ..write('disableUDP: $disableUDP, ')
          ..write('filter: $filter, ')
          ..write('excludeFilter: $excludeFilter, ')
          ..write('excludeType: $excludeType, ')
          ..write('expectedStatus: $expectedStatus, ')
          ..write('includeAll: $includeAll, ')
          ..write('includeAllProxies: $includeAllProxies, ')
          ..write('includeAllProviders: $includeAllProviders, ')
          ..write('hidden: $hidden, ')
          ..write('icon: $icon, ')
          ..write('order: $order')
          ..write(')'))
        .toString();
  }
}

class $IconRecordsTable extends IconRecords
    with TableInfo<$IconRecordsTable, IconRecord> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $IconRecordsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _urlMeta = const VerificationMeta('url');
  @override
  late final GeneratedColumn<String> url = GeneratedColumn<String>(
    'url',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _lastAccessedMeta = const VerificationMeta(
    'lastAccessed',
  );
  @override
  late final GeneratedColumn<int> lastAccessed = GeneratedColumn<int>(
    'last_accessed',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [url, lastAccessed];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'icon_records';
  @override
  VerificationContext validateIntegrity(
    Insertable<IconRecord> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('url')) {
      context.handle(
        _urlMeta,
        url.isAcceptableOrUnknown(data['url']!, _urlMeta),
      );
    } else if (isInserting) {
      context.missing(_urlMeta);
    }
    if (data.containsKey('last_accessed')) {
      context.handle(
        _lastAccessedMeta,
        lastAccessed.isAcceptableOrUnknown(
          data['last_accessed']!,
          _lastAccessedMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_lastAccessedMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {url};
  @override
  IconRecord map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return IconRecord(
      url: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}url'],
      )!,
      lastAccessed: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}last_accessed'],
      )!,
    );
  }

  @override
  $IconRecordsTable createAlias(String alias) {
    return $IconRecordsTable(attachedDatabase, alias);
  }
}

class IconRecord extends DataClass implements Insertable<IconRecord> {
  final String url;
  final int lastAccessed;
  const IconRecord({required this.url, required this.lastAccessed});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['url'] = Variable<String>(url);
    map['last_accessed'] = Variable<int>(lastAccessed);
    return map;
  }

  IconRecordsCompanion toCompanion(bool nullToAbsent) {
    return IconRecordsCompanion(
      url: Value(url),
      lastAccessed: Value(lastAccessed),
    );
  }

  factory IconRecord.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return IconRecord(
      url: serializer.fromJson<String>(json['url']),
      lastAccessed: serializer.fromJson<int>(json['lastAccessed']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'url': serializer.toJson<String>(url),
      'lastAccessed': serializer.toJson<int>(lastAccessed),
    };
  }

  IconRecord copyWith({String? url, int? lastAccessed}) => IconRecord(
    url: url ?? this.url,
    lastAccessed: lastAccessed ?? this.lastAccessed,
  );
  IconRecord copyWithCompanion(IconRecordsCompanion data) {
    return IconRecord(
      url: data.url.present ? data.url.value : this.url,
      lastAccessed: data.lastAccessed.present
          ? data.lastAccessed.value
          : this.lastAccessed,
    );
  }

  @override
  String toString() {
    return (StringBuffer('IconRecord(')
          ..write('url: $url, ')
          ..write('lastAccessed: $lastAccessed')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(url, lastAccessed);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is IconRecord &&
          other.url == this.url &&
          other.lastAccessed == this.lastAccessed);
}

class IconRecordsCompanion extends UpdateCompanion<IconRecord> {
  final Value<String> url;
  final Value<int> lastAccessed;
  final Value<int> rowid;
  const IconRecordsCompanion({
    this.url = const Value.absent(),
    this.lastAccessed = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  IconRecordsCompanion.insert({
    required String url,
    required int lastAccessed,
    this.rowid = const Value.absent(),
  }) : url = Value(url),
       lastAccessed = Value(lastAccessed);
  static Insertable<IconRecord> custom({
    Expression<String>? url,
    Expression<int>? lastAccessed,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (url != null) 'url': url,
      if (lastAccessed != null) 'last_accessed': lastAccessed,
      if (rowid != null) 'rowid': rowid,
    });
  }

  IconRecordsCompanion copyWith({
    Value<String>? url,
    Value<int>? lastAccessed,
    Value<int>? rowid,
  }) {
    return IconRecordsCompanion(
      url: url ?? this.url,
      lastAccessed: lastAccessed ?? this.lastAccessed,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (url.present) {
      map['url'] = Variable<String>(url.value);
    }
    if (lastAccessed.present) {
      map['last_accessed'] = Variable<int>(lastAccessed.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('IconRecordsCompanion(')
          ..write('url: $url, ')
          ..write('lastAccessed: $lastAccessed, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ProxyNodesTable extends ProxyNodes
    with TableInfo<$ProxyNodesTable, RawProxyNode> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ProxyNodesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _displayNameMeta = const VerificationMeta(
    'displayName',
  );
  @override
  late final GeneratedColumn<String> displayName = GeneratedColumn<String>(
    'display_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<String> type = GeneratedColumn<String>(
    'type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  late final GeneratedColumnWithTypeConverter<Map<String, Object?>, String>
  config = GeneratedColumn<String>(
    'config',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  ).withConverter<Map<String, Object?>>($ProxyNodesTable.$converterconfig);
  @override
  late final GeneratedColumnWithTypeConverter<Map<String, Object?>?, String>
  sourceSnapshot =
      GeneratedColumn<String>(
        'source_snapshot',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      ).withConverter<Map<String, Object?>?>(
        $ProxyNodesTable.$convertersourceSnapshot,
      );
  static const VerificationMeta _sourceKindMeta = const VerificationMeta(
    'sourceKind',
  );
  @override
  late final GeneratedColumn<String> sourceKind = GeneratedColumn<String>(
    'source_kind',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _sourceProfileIdMeta = const VerificationMeta(
    'sourceProfileId',
  );
  @override
  late final GeneratedColumn<int> sourceProfileId = GeneratedColumn<int>(
    'source_profile_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES profiles (id) ON DELETE SET NULL',
    ),
  );
  static const VerificationMeta _sourceProviderMeta = const VerificationMeta(
    'sourceProvider',
  );
  @override
  late final GeneratedColumn<String> sourceProvider = GeneratedColumn<String>(
    'source_provider',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _sourceKeyMeta = const VerificationMeta(
    'sourceKey',
  );
  @override
  late final GeneratedColumn<String> sourceKey = GeneratedColumn<String>(
    'source_key',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  late final GeneratedColumnWithTypeConverter<Map<String, Object?>?, String>
  overlaySet = GeneratedColumn<String>(
    'overlay_set',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  ).withConverter<Map<String, Object?>?>($ProxyNodesTable.$converteroverlaySet);
  @override
  late final GeneratedColumnWithTypeConverter<List<String>?, String>
  overlayRemove = GeneratedColumn<String>(
    'overlay_remove',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  ).withConverter<List<String>?>($ProxyNodesTable.$converteroverlayRemoven);
  @override
  late final GeneratedColumnWithTypeConverter<Map<String, Object?>?, String>
  metadata = GeneratedColumn<String>(
    'metadata',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  ).withConverter<Map<String, Object?>?>($ProxyNodesTable.$convertermetadata);
  static const VerificationMeta _fingerprintMeta = const VerificationMeta(
    'fingerprint',
  );
  @override
  late final GeneratedColumn<String> fingerprint = GeneratedColumn<String>(
    'fingerprint',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _orderMeta = const VerificationMeta('order');
  @override
  late final GeneratedColumn<int> order = GeneratedColumn<int>(
    'order',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    displayName,
    type,
    config,
    sourceSnapshot,
    sourceKind,
    sourceProfileId,
    sourceProvider,
    sourceKey,
    overlaySet,
    overlayRemove,
    metadata,
    fingerprint,
    status,
    createdAt,
    updatedAt,
    order,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'proxy_nodes';
  @override
  VerificationContext validateIntegrity(
    Insertable<RawProxyNode> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('display_name')) {
      context.handle(
        _displayNameMeta,
        displayName.isAcceptableOrUnknown(
          data['display_name']!,
          _displayNameMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_displayNameMeta);
    }
    if (data.containsKey('type')) {
      context.handle(
        _typeMeta,
        type.isAcceptableOrUnknown(data['type']!, _typeMeta),
      );
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    if (data.containsKey('source_kind')) {
      context.handle(
        _sourceKindMeta,
        sourceKind.isAcceptableOrUnknown(data['source_kind']!, _sourceKindMeta),
      );
    }
    if (data.containsKey('source_profile_id')) {
      context.handle(
        _sourceProfileIdMeta,
        sourceProfileId.isAcceptableOrUnknown(
          data['source_profile_id']!,
          _sourceProfileIdMeta,
        ),
      );
    }
    if (data.containsKey('source_provider')) {
      context.handle(
        _sourceProviderMeta,
        sourceProvider.isAcceptableOrUnknown(
          data['source_provider']!,
          _sourceProviderMeta,
        ),
      );
    }
    if (data.containsKey('source_key')) {
      context.handle(
        _sourceKeyMeta,
        sourceKey.isAcceptableOrUnknown(data['source_key']!, _sourceKeyMeta),
      );
    }
    if (data.containsKey('fingerprint')) {
      context.handle(
        _fingerprintMeta,
        fingerprint.isAcceptableOrUnknown(
          data['fingerprint']!,
          _fingerprintMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_fingerprintMeta);
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    } else if (isInserting) {
      context.missing(_statusMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    if (data.containsKey('order')) {
      context.handle(
        _orderMeta,
        order.isAcceptableOrUnknown(data['order']!, _orderMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  RawProxyNode map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return RawProxyNode(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      displayName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}display_name'],
      )!,
      type: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}type'],
      )!,
      config: $ProxyNodesTable.$converterconfig.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}config'],
        )!,
      ),
      sourceSnapshot: $ProxyNodesTable.$convertersourceSnapshot.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}source_snapshot'],
        ),
      ),
      sourceKind: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}source_kind'],
      ),
      sourceProfileId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}source_profile_id'],
      ),
      sourceProvider: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}source_provider'],
      ),
      sourceKey: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}source_key'],
      ),
      overlaySet: $ProxyNodesTable.$converteroverlaySet.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}overlay_set'],
        ),
      ),
      overlayRemove: $ProxyNodesTable.$converteroverlayRemoven.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}overlay_remove'],
        ),
      ),
      metadata: $ProxyNodesTable.$convertermetadata.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}metadata'],
        ),
      ),
      fingerprint: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}fingerprint'],
      )!,
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      ),
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      ),
      order: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}order'],
      ),
    );
  }

  @override
  $ProxyNodesTable createAlias(String alias) {
    return $ProxyNodesTable(attachedDatabase, alias);
  }

  static TypeConverter<Map<String, Object?>, String> $converterconfig =
      const JsonMapConverter();
  static TypeConverter<Map<String, Object?>?, String?>
  $convertersourceSnapshot = const JsonMapNullableConverter();
  static TypeConverter<Map<String, Object?>?, String?> $converteroverlaySet =
      const JsonMapNullableConverter();
  static TypeConverter<List<String>, String> $converteroverlayRemove =
      const StringListConverter();
  static TypeConverter<List<String>?, String?> $converteroverlayRemoven =
      NullAwareTypeConverter.wrap($converteroverlayRemove);
  static TypeConverter<Map<String, Object?>?, String?> $convertermetadata =
      const JsonMapNullableConverter();
}

class RawProxyNode extends DataClass implements Insertable<RawProxyNode> {
  final int id;
  final String displayName;
  final String type;
  final Map<String, Object?> config;
  final Map<String, Object?>? sourceSnapshot;
  final String? sourceKind;
  final int? sourceProfileId;
  final String? sourceProvider;
  final String? sourceKey;
  final Map<String, Object?>? overlaySet;
  final List<String>? overlayRemove;
  final Map<String, Object?>? metadata;
  final String fingerprint;
  final String status;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? order;
  const RawProxyNode({
    required this.id,
    required this.displayName,
    required this.type,
    required this.config,
    this.sourceSnapshot,
    this.sourceKind,
    this.sourceProfileId,
    this.sourceProvider,
    this.sourceKey,
    this.overlaySet,
    this.overlayRemove,
    this.metadata,
    required this.fingerprint,
    required this.status,
    this.createdAt,
    this.updatedAt,
    this.order,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['display_name'] = Variable<String>(displayName);
    map['type'] = Variable<String>(type);
    {
      map['config'] = Variable<String>(
        $ProxyNodesTable.$converterconfig.toSql(config),
      );
    }
    if (!nullToAbsent || sourceSnapshot != null) {
      map['source_snapshot'] = Variable<String>(
        $ProxyNodesTable.$convertersourceSnapshot.toSql(sourceSnapshot),
      );
    }
    if (!nullToAbsent || sourceKind != null) {
      map['source_kind'] = Variable<String>(sourceKind);
    }
    if (!nullToAbsent || sourceProfileId != null) {
      map['source_profile_id'] = Variable<int>(sourceProfileId);
    }
    if (!nullToAbsent || sourceProvider != null) {
      map['source_provider'] = Variable<String>(sourceProvider);
    }
    if (!nullToAbsent || sourceKey != null) {
      map['source_key'] = Variable<String>(sourceKey);
    }
    if (!nullToAbsent || overlaySet != null) {
      map['overlay_set'] = Variable<String>(
        $ProxyNodesTable.$converteroverlaySet.toSql(overlaySet),
      );
    }
    if (!nullToAbsent || overlayRemove != null) {
      map['overlay_remove'] = Variable<String>(
        $ProxyNodesTable.$converteroverlayRemoven.toSql(overlayRemove),
      );
    }
    if (!nullToAbsent || metadata != null) {
      map['metadata'] = Variable<String>(
        $ProxyNodesTable.$convertermetadata.toSql(metadata),
      );
    }
    map['fingerprint'] = Variable<String>(fingerprint);
    map['status'] = Variable<String>(status);
    if (!nullToAbsent || createdAt != null) {
      map['created_at'] = Variable<DateTime>(createdAt);
    }
    if (!nullToAbsent || updatedAt != null) {
      map['updated_at'] = Variable<DateTime>(updatedAt);
    }
    if (!nullToAbsent || order != null) {
      map['order'] = Variable<int>(order);
    }
    return map;
  }

  ProxyNodesCompanion toCompanion(bool nullToAbsent) {
    return ProxyNodesCompanion(
      id: Value(id),
      displayName: Value(displayName),
      type: Value(type),
      config: Value(config),
      sourceSnapshot: sourceSnapshot == null && nullToAbsent
          ? const Value.absent()
          : Value(sourceSnapshot),
      sourceKind: sourceKind == null && nullToAbsent
          ? const Value.absent()
          : Value(sourceKind),
      sourceProfileId: sourceProfileId == null && nullToAbsent
          ? const Value.absent()
          : Value(sourceProfileId),
      sourceProvider: sourceProvider == null && nullToAbsent
          ? const Value.absent()
          : Value(sourceProvider),
      sourceKey: sourceKey == null && nullToAbsent
          ? const Value.absent()
          : Value(sourceKey),
      overlaySet: overlaySet == null && nullToAbsent
          ? const Value.absent()
          : Value(overlaySet),
      overlayRemove: overlayRemove == null && nullToAbsent
          ? const Value.absent()
          : Value(overlayRemove),
      metadata: metadata == null && nullToAbsent
          ? const Value.absent()
          : Value(metadata),
      fingerprint: Value(fingerprint),
      status: Value(status),
      createdAt: createdAt == null && nullToAbsent
          ? const Value.absent()
          : Value(createdAt),
      updatedAt: updatedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(updatedAt),
      order: order == null && nullToAbsent
          ? const Value.absent()
          : Value(order),
    );
  }

  factory RawProxyNode.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return RawProxyNode(
      id: serializer.fromJson<int>(json['id']),
      displayName: serializer.fromJson<String>(json['displayName']),
      type: serializer.fromJson<String>(json['type']),
      config: serializer.fromJson<Map<String, Object?>>(json['config']),
      sourceSnapshot: serializer.fromJson<Map<String, Object?>?>(
        json['sourceSnapshot'],
      ),
      sourceKind: serializer.fromJson<String?>(json['sourceKind']),
      sourceProfileId: serializer.fromJson<int?>(json['sourceProfileId']),
      sourceProvider: serializer.fromJson<String?>(json['sourceProvider']),
      sourceKey: serializer.fromJson<String?>(json['sourceKey']),
      overlaySet: serializer.fromJson<Map<String, Object?>?>(
        json['overlaySet'],
      ),
      overlayRemove: serializer.fromJson<List<String>?>(json['overlayRemove']),
      metadata: serializer.fromJson<Map<String, Object?>?>(json['metadata']),
      fingerprint: serializer.fromJson<String>(json['fingerprint']),
      status: serializer.fromJson<String>(json['status']),
      createdAt: serializer.fromJson<DateTime?>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime?>(json['updatedAt']),
      order: serializer.fromJson<int?>(json['order']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'displayName': serializer.toJson<String>(displayName),
      'type': serializer.toJson<String>(type),
      'config': serializer.toJson<Map<String, Object?>>(config),
      'sourceSnapshot': serializer.toJson<Map<String, Object?>?>(
        sourceSnapshot,
      ),
      'sourceKind': serializer.toJson<String?>(sourceKind),
      'sourceProfileId': serializer.toJson<int?>(sourceProfileId),
      'sourceProvider': serializer.toJson<String?>(sourceProvider),
      'sourceKey': serializer.toJson<String?>(sourceKey),
      'overlaySet': serializer.toJson<Map<String, Object?>?>(overlaySet),
      'overlayRemove': serializer.toJson<List<String>?>(overlayRemove),
      'metadata': serializer.toJson<Map<String, Object?>?>(metadata),
      'fingerprint': serializer.toJson<String>(fingerprint),
      'status': serializer.toJson<String>(status),
      'createdAt': serializer.toJson<DateTime?>(createdAt),
      'updatedAt': serializer.toJson<DateTime?>(updatedAt),
      'order': serializer.toJson<int?>(order),
    };
  }

  RawProxyNode copyWith({
    int? id,
    String? displayName,
    String? type,
    Map<String, Object?>? config,
    Value<Map<String, Object?>?> sourceSnapshot = const Value.absent(),
    Value<String?> sourceKind = const Value.absent(),
    Value<int?> sourceProfileId = const Value.absent(),
    Value<String?> sourceProvider = const Value.absent(),
    Value<String?> sourceKey = const Value.absent(),
    Value<Map<String, Object?>?> overlaySet = const Value.absent(),
    Value<List<String>?> overlayRemove = const Value.absent(),
    Value<Map<String, Object?>?> metadata = const Value.absent(),
    String? fingerprint,
    String? status,
    Value<DateTime?> createdAt = const Value.absent(),
    Value<DateTime?> updatedAt = const Value.absent(),
    Value<int?> order = const Value.absent(),
  }) => RawProxyNode(
    id: id ?? this.id,
    displayName: displayName ?? this.displayName,
    type: type ?? this.type,
    config: config ?? this.config,
    sourceSnapshot: sourceSnapshot.present
        ? sourceSnapshot.value
        : this.sourceSnapshot,
    sourceKind: sourceKind.present ? sourceKind.value : this.sourceKind,
    sourceProfileId: sourceProfileId.present
        ? sourceProfileId.value
        : this.sourceProfileId,
    sourceProvider: sourceProvider.present
        ? sourceProvider.value
        : this.sourceProvider,
    sourceKey: sourceKey.present ? sourceKey.value : this.sourceKey,
    overlaySet: overlaySet.present ? overlaySet.value : this.overlaySet,
    overlayRemove: overlayRemove.present
        ? overlayRemove.value
        : this.overlayRemove,
    metadata: metadata.present ? metadata.value : this.metadata,
    fingerprint: fingerprint ?? this.fingerprint,
    status: status ?? this.status,
    createdAt: createdAt.present ? createdAt.value : this.createdAt,
    updatedAt: updatedAt.present ? updatedAt.value : this.updatedAt,
    order: order.present ? order.value : this.order,
  );
  RawProxyNode copyWithCompanion(ProxyNodesCompanion data) {
    return RawProxyNode(
      id: data.id.present ? data.id.value : this.id,
      displayName: data.displayName.present
          ? data.displayName.value
          : this.displayName,
      type: data.type.present ? data.type.value : this.type,
      config: data.config.present ? data.config.value : this.config,
      sourceSnapshot: data.sourceSnapshot.present
          ? data.sourceSnapshot.value
          : this.sourceSnapshot,
      sourceKind: data.sourceKind.present
          ? data.sourceKind.value
          : this.sourceKind,
      sourceProfileId: data.sourceProfileId.present
          ? data.sourceProfileId.value
          : this.sourceProfileId,
      sourceProvider: data.sourceProvider.present
          ? data.sourceProvider.value
          : this.sourceProvider,
      sourceKey: data.sourceKey.present ? data.sourceKey.value : this.sourceKey,
      overlaySet: data.overlaySet.present
          ? data.overlaySet.value
          : this.overlaySet,
      overlayRemove: data.overlayRemove.present
          ? data.overlayRemove.value
          : this.overlayRemove,
      metadata: data.metadata.present ? data.metadata.value : this.metadata,
      fingerprint: data.fingerprint.present
          ? data.fingerprint.value
          : this.fingerprint,
      status: data.status.present ? data.status.value : this.status,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      order: data.order.present ? data.order.value : this.order,
    );
  }

  @override
  String toString() {
    return (StringBuffer('RawProxyNode(')
          ..write('id: $id, ')
          ..write('displayName: $displayName, ')
          ..write('type: $type, ')
          ..write('config: $config, ')
          ..write('sourceSnapshot: $sourceSnapshot, ')
          ..write('sourceKind: $sourceKind, ')
          ..write('sourceProfileId: $sourceProfileId, ')
          ..write('sourceProvider: $sourceProvider, ')
          ..write('sourceKey: $sourceKey, ')
          ..write('overlaySet: $overlaySet, ')
          ..write('overlayRemove: $overlayRemove, ')
          ..write('metadata: $metadata, ')
          ..write('fingerprint: $fingerprint, ')
          ..write('status: $status, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('order: $order')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    displayName,
    type,
    config,
    sourceSnapshot,
    sourceKind,
    sourceProfileId,
    sourceProvider,
    sourceKey,
    overlaySet,
    overlayRemove,
    metadata,
    fingerprint,
    status,
    createdAt,
    updatedAt,
    order,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is RawProxyNode &&
          other.id == this.id &&
          other.displayName == this.displayName &&
          other.type == this.type &&
          other.config == this.config &&
          other.sourceSnapshot == this.sourceSnapshot &&
          other.sourceKind == this.sourceKind &&
          other.sourceProfileId == this.sourceProfileId &&
          other.sourceProvider == this.sourceProvider &&
          other.sourceKey == this.sourceKey &&
          other.overlaySet == this.overlaySet &&
          other.overlayRemove == this.overlayRemove &&
          other.metadata == this.metadata &&
          other.fingerprint == this.fingerprint &&
          other.status == this.status &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.order == this.order);
}

class ProxyNodesCompanion extends UpdateCompanion<RawProxyNode> {
  final Value<int> id;
  final Value<String> displayName;
  final Value<String> type;
  final Value<Map<String, Object?>> config;
  final Value<Map<String, Object?>?> sourceSnapshot;
  final Value<String?> sourceKind;
  final Value<int?> sourceProfileId;
  final Value<String?> sourceProvider;
  final Value<String?> sourceKey;
  final Value<Map<String, Object?>?> overlaySet;
  final Value<List<String>?> overlayRemove;
  final Value<Map<String, Object?>?> metadata;
  final Value<String> fingerprint;
  final Value<String> status;
  final Value<DateTime?> createdAt;
  final Value<DateTime?> updatedAt;
  final Value<int?> order;
  const ProxyNodesCompanion({
    this.id = const Value.absent(),
    this.displayName = const Value.absent(),
    this.type = const Value.absent(),
    this.config = const Value.absent(),
    this.sourceSnapshot = const Value.absent(),
    this.sourceKind = const Value.absent(),
    this.sourceProfileId = const Value.absent(),
    this.sourceProvider = const Value.absent(),
    this.sourceKey = const Value.absent(),
    this.overlaySet = const Value.absent(),
    this.overlayRemove = const Value.absent(),
    this.metadata = const Value.absent(),
    this.fingerprint = const Value.absent(),
    this.status = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.order = const Value.absent(),
  });
  ProxyNodesCompanion.insert({
    this.id = const Value.absent(),
    required String displayName,
    required String type,
    required Map<String, Object?> config,
    this.sourceSnapshot = const Value.absent(),
    this.sourceKind = const Value.absent(),
    this.sourceProfileId = const Value.absent(),
    this.sourceProvider = const Value.absent(),
    this.sourceKey = const Value.absent(),
    this.overlaySet = const Value.absent(),
    this.overlayRemove = const Value.absent(),
    this.metadata = const Value.absent(),
    required String fingerprint,
    required String status,
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.order = const Value.absent(),
  }) : displayName = Value(displayName),
       type = Value(type),
       config = Value(config),
       fingerprint = Value(fingerprint),
       status = Value(status);
  static Insertable<RawProxyNode> custom({
    Expression<int>? id,
    Expression<String>? displayName,
    Expression<String>? type,
    Expression<String>? config,
    Expression<String>? sourceSnapshot,
    Expression<String>? sourceKind,
    Expression<int>? sourceProfileId,
    Expression<String>? sourceProvider,
    Expression<String>? sourceKey,
    Expression<String>? overlaySet,
    Expression<String>? overlayRemove,
    Expression<String>? metadata,
    Expression<String>? fingerprint,
    Expression<String>? status,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? order,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (displayName != null) 'display_name': displayName,
      if (type != null) 'type': type,
      if (config != null) 'config': config,
      if (sourceSnapshot != null) 'source_snapshot': sourceSnapshot,
      if (sourceKind != null) 'source_kind': sourceKind,
      if (sourceProfileId != null) 'source_profile_id': sourceProfileId,
      if (sourceProvider != null) 'source_provider': sourceProvider,
      if (sourceKey != null) 'source_key': sourceKey,
      if (overlaySet != null) 'overlay_set': overlaySet,
      if (overlayRemove != null) 'overlay_remove': overlayRemove,
      if (metadata != null) 'metadata': metadata,
      if (fingerprint != null) 'fingerprint': fingerprint,
      if (status != null) 'status': status,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (order != null) 'order': order,
    });
  }

  ProxyNodesCompanion copyWith({
    Value<int>? id,
    Value<String>? displayName,
    Value<String>? type,
    Value<Map<String, Object?>>? config,
    Value<Map<String, Object?>?>? sourceSnapshot,
    Value<String?>? sourceKind,
    Value<int?>? sourceProfileId,
    Value<String?>? sourceProvider,
    Value<String?>? sourceKey,
    Value<Map<String, Object?>?>? overlaySet,
    Value<List<String>?>? overlayRemove,
    Value<Map<String, Object?>?>? metadata,
    Value<String>? fingerprint,
    Value<String>? status,
    Value<DateTime?>? createdAt,
    Value<DateTime?>? updatedAt,
    Value<int?>? order,
  }) {
    return ProxyNodesCompanion(
      id: id ?? this.id,
      displayName: displayName ?? this.displayName,
      type: type ?? this.type,
      config: config ?? this.config,
      sourceSnapshot: sourceSnapshot ?? this.sourceSnapshot,
      sourceKind: sourceKind ?? this.sourceKind,
      sourceProfileId: sourceProfileId ?? this.sourceProfileId,
      sourceProvider: sourceProvider ?? this.sourceProvider,
      sourceKey: sourceKey ?? this.sourceKey,
      overlaySet: overlaySet ?? this.overlaySet,
      overlayRemove: overlayRemove ?? this.overlayRemove,
      metadata: metadata ?? this.metadata,
      fingerprint: fingerprint ?? this.fingerprint,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      order: order ?? this.order,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (displayName.present) {
      map['display_name'] = Variable<String>(displayName.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (config.present) {
      map['config'] = Variable<String>(
        $ProxyNodesTable.$converterconfig.toSql(config.value),
      );
    }
    if (sourceSnapshot.present) {
      map['source_snapshot'] = Variable<String>(
        $ProxyNodesTable.$convertersourceSnapshot.toSql(sourceSnapshot.value),
      );
    }
    if (sourceKind.present) {
      map['source_kind'] = Variable<String>(sourceKind.value);
    }
    if (sourceProfileId.present) {
      map['source_profile_id'] = Variable<int>(sourceProfileId.value);
    }
    if (sourceProvider.present) {
      map['source_provider'] = Variable<String>(sourceProvider.value);
    }
    if (sourceKey.present) {
      map['source_key'] = Variable<String>(sourceKey.value);
    }
    if (overlaySet.present) {
      map['overlay_set'] = Variable<String>(
        $ProxyNodesTable.$converteroverlaySet.toSql(overlaySet.value),
      );
    }
    if (overlayRemove.present) {
      map['overlay_remove'] = Variable<String>(
        $ProxyNodesTable.$converteroverlayRemoven.toSql(overlayRemove.value),
      );
    }
    if (metadata.present) {
      map['metadata'] = Variable<String>(
        $ProxyNodesTable.$convertermetadata.toSql(metadata.value),
      );
    }
    if (fingerprint.present) {
      map['fingerprint'] = Variable<String>(fingerprint.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (order.present) {
      map['order'] = Variable<int>(order.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ProxyNodesCompanion(')
          ..write('id: $id, ')
          ..write('displayName: $displayName, ')
          ..write('type: $type, ')
          ..write('config: $config, ')
          ..write('sourceSnapshot: $sourceSnapshot, ')
          ..write('sourceKind: $sourceKind, ')
          ..write('sourceProfileId: $sourceProfileId, ')
          ..write('sourceProvider: $sourceProvider, ')
          ..write('sourceKey: $sourceKey, ')
          ..write('overlaySet: $overlaySet, ')
          ..write('overlayRemove: $overlayRemove, ')
          ..write('metadata: $metadata, ')
          ..write('fingerprint: $fingerprint, ')
          ..write('status: $status, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('order: $order')
          ..write(')'))
        .toString();
  }
}

class $ProxyNodeBindingsTable extends ProxyNodeBindings
    with TableInfo<$ProxyNodeBindingsTable, RawProxyNodeBinding> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ProxyNodeBindingsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _profileIdMeta = const VerificationMeta(
    'profileId',
  );
  @override
  late final GeneratedColumn<int> profileId = GeneratedColumn<int>(
    'profile_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES profiles (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _nodeIdMeta = const VerificationMeta('nodeId');
  @override
  late final GeneratedColumn<int> nodeId = GeneratedColumn<int>(
    'node_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES proxy_nodes (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _aliasMeta = const VerificationMeta('alias');
  @override
  late final GeneratedColumn<String> alias = GeneratedColumn<String>(
    'alias',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _enabledMeta = const VerificationMeta(
    'enabled',
  );
  @override
  late final GeneratedColumn<bool> enabled = GeneratedColumn<bool>(
    'enabled',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("enabled" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _orderMeta = const VerificationMeta('order');
  @override
  late final GeneratedColumn<int> order = GeneratedColumn<int>(
    'order',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    profileId,
    nodeId,
    alias,
    enabled,
    order,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'profile_proxy_nodes';
  @override
  VerificationContext validateIntegrity(
    Insertable<RawProxyNodeBinding> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('profile_id')) {
      context.handle(
        _profileIdMeta,
        profileId.isAcceptableOrUnknown(data['profile_id']!, _profileIdMeta),
      );
    } else if (isInserting) {
      context.missing(_profileIdMeta);
    }
    if (data.containsKey('node_id')) {
      context.handle(
        _nodeIdMeta,
        nodeId.isAcceptableOrUnknown(data['node_id']!, _nodeIdMeta),
      );
    } else if (isInserting) {
      context.missing(_nodeIdMeta);
    }
    if (data.containsKey('alias')) {
      context.handle(
        _aliasMeta,
        alias.isAcceptableOrUnknown(data['alias']!, _aliasMeta),
      );
    }
    if (data.containsKey('enabled')) {
      context.handle(
        _enabledMeta,
        enabled.isAcceptableOrUnknown(data['enabled']!, _enabledMeta),
      );
    }
    if (data.containsKey('order')) {
      context.handle(
        _orderMeta,
        order.isAcceptableOrUnknown(data['order']!, _orderMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {profileId, nodeId};
  @override
  RawProxyNodeBinding map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return RawProxyNodeBinding(
      profileId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}profile_id'],
      )!,
      nodeId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}node_id'],
      )!,
      alias: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}alias'],
      ),
      enabled: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}enabled'],
      )!,
      order: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}order'],
      ),
    );
  }

  @override
  $ProxyNodeBindingsTable createAlias(String alias) {
    return $ProxyNodeBindingsTable(attachedDatabase, alias);
  }
}

class RawProxyNodeBinding extends DataClass
    implements Insertable<RawProxyNodeBinding> {
  final int profileId;
  final int nodeId;
  final String? alias;
  final bool enabled;
  final int? order;
  const RawProxyNodeBinding({
    required this.profileId,
    required this.nodeId,
    this.alias,
    required this.enabled,
    this.order,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['profile_id'] = Variable<int>(profileId);
    map['node_id'] = Variable<int>(nodeId);
    if (!nullToAbsent || alias != null) {
      map['alias'] = Variable<String>(alias);
    }
    map['enabled'] = Variable<bool>(enabled);
    if (!nullToAbsent || order != null) {
      map['order'] = Variable<int>(order);
    }
    return map;
  }

  ProxyNodeBindingsCompanion toCompanion(bool nullToAbsent) {
    return ProxyNodeBindingsCompanion(
      profileId: Value(profileId),
      nodeId: Value(nodeId),
      alias: alias == null && nullToAbsent
          ? const Value.absent()
          : Value(alias),
      enabled: Value(enabled),
      order: order == null && nullToAbsent
          ? const Value.absent()
          : Value(order),
    );
  }

  factory RawProxyNodeBinding.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return RawProxyNodeBinding(
      profileId: serializer.fromJson<int>(json['profileId']),
      nodeId: serializer.fromJson<int>(json['nodeId']),
      alias: serializer.fromJson<String?>(json['alias']),
      enabled: serializer.fromJson<bool>(json['enabled']),
      order: serializer.fromJson<int?>(json['order']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'profileId': serializer.toJson<int>(profileId),
      'nodeId': serializer.toJson<int>(nodeId),
      'alias': serializer.toJson<String?>(alias),
      'enabled': serializer.toJson<bool>(enabled),
      'order': serializer.toJson<int?>(order),
    };
  }

  RawProxyNodeBinding copyWith({
    int? profileId,
    int? nodeId,
    Value<String?> alias = const Value.absent(),
    bool? enabled,
    Value<int?> order = const Value.absent(),
  }) => RawProxyNodeBinding(
    profileId: profileId ?? this.profileId,
    nodeId: nodeId ?? this.nodeId,
    alias: alias.present ? alias.value : this.alias,
    enabled: enabled ?? this.enabled,
    order: order.present ? order.value : this.order,
  );
  RawProxyNodeBinding copyWithCompanion(ProxyNodeBindingsCompanion data) {
    return RawProxyNodeBinding(
      profileId: data.profileId.present ? data.profileId.value : this.profileId,
      nodeId: data.nodeId.present ? data.nodeId.value : this.nodeId,
      alias: data.alias.present ? data.alias.value : this.alias,
      enabled: data.enabled.present ? data.enabled.value : this.enabled,
      order: data.order.present ? data.order.value : this.order,
    );
  }

  @override
  String toString() {
    return (StringBuffer('RawProxyNodeBinding(')
          ..write('profileId: $profileId, ')
          ..write('nodeId: $nodeId, ')
          ..write('alias: $alias, ')
          ..write('enabled: $enabled, ')
          ..write('order: $order')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(profileId, nodeId, alias, enabled, order);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is RawProxyNodeBinding &&
          other.profileId == this.profileId &&
          other.nodeId == this.nodeId &&
          other.alias == this.alias &&
          other.enabled == this.enabled &&
          other.order == this.order);
}

class ProxyNodeBindingsCompanion extends UpdateCompanion<RawProxyNodeBinding> {
  final Value<int> profileId;
  final Value<int> nodeId;
  final Value<String?> alias;
  final Value<bool> enabled;
  final Value<int?> order;
  final Value<int> rowid;
  const ProxyNodeBindingsCompanion({
    this.profileId = const Value.absent(),
    this.nodeId = const Value.absent(),
    this.alias = const Value.absent(),
    this.enabled = const Value.absent(),
    this.order = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ProxyNodeBindingsCompanion.insert({
    required int profileId,
    required int nodeId,
    this.alias = const Value.absent(),
    this.enabled = const Value.absent(),
    this.order = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : profileId = Value(profileId),
       nodeId = Value(nodeId);
  static Insertable<RawProxyNodeBinding> custom({
    Expression<int>? profileId,
    Expression<int>? nodeId,
    Expression<String>? alias,
    Expression<bool>? enabled,
    Expression<int>? order,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (profileId != null) 'profile_id': profileId,
      if (nodeId != null) 'node_id': nodeId,
      if (alias != null) 'alias': alias,
      if (enabled != null) 'enabled': enabled,
      if (order != null) 'order': order,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ProxyNodeBindingsCompanion copyWith({
    Value<int>? profileId,
    Value<int>? nodeId,
    Value<String?>? alias,
    Value<bool>? enabled,
    Value<int?>? order,
    Value<int>? rowid,
  }) {
    return ProxyNodeBindingsCompanion(
      profileId: profileId ?? this.profileId,
      nodeId: nodeId ?? this.nodeId,
      alias: alias ?? this.alias,
      enabled: enabled ?? this.enabled,
      order: order ?? this.order,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (profileId.present) {
      map['profile_id'] = Variable<int>(profileId.value);
    }
    if (nodeId.present) {
      map['node_id'] = Variable<int>(nodeId.value);
    }
    if (alias.present) {
      map['alias'] = Variable<String>(alias.value);
    }
    if (enabled.present) {
      map['enabled'] = Variable<bool>(enabled.value);
    }
    if (order.present) {
      map['order'] = Variable<int>(order.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ProxyNodeBindingsCompanion(')
          ..write('profileId: $profileId, ')
          ..write('nodeId: $nodeId, ')
          ..write('alias: $alias, ')
          ..write('enabled: $enabled, ')
          ..write('order: $order, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ProxyChainsTable extends ProxyChains
    with TableInfo<$ProxyChainsTable, RawProxyChain> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ProxyChainsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _branchLimitMeta = const VerificationMeta(
    'branchLimit',
  );
  @override
  late final GeneratedColumn<int> branchLimit = GeneratedColumn<int>(
    'branch_limit',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(64),
  );
  static const VerificationMeta _orderMeta = const VerificationMeta('order');
  @override
  late final GeneratedColumn<int> order = GeneratedColumn<int>(
    'order',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    description,
    branchLimit,
    order,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'proxy_chains';
  @override
  VerificationContext validateIntegrity(
    Insertable<RawProxyChain> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    }
    if (data.containsKey('branch_limit')) {
      context.handle(
        _branchLimitMeta,
        branchLimit.isAcceptableOrUnknown(
          data['branch_limit']!,
          _branchLimitMeta,
        ),
      );
    }
    if (data.containsKey('order')) {
      context.handle(
        _orderMeta,
        order.isAcceptableOrUnknown(data['order']!, _orderMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  RawProxyChain map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return RawProxyChain(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      ),
      branchLimit: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}branch_limit'],
      )!,
      order: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}order'],
      ),
    );
  }

  @override
  $ProxyChainsTable createAlias(String alias) {
    return $ProxyChainsTable(attachedDatabase, alias);
  }
}

class RawProxyChain extends DataClass implements Insertable<RawProxyChain> {
  final int id;
  final String name;
  final String? description;
  final int branchLimit;
  final int? order;
  const RawProxyChain({
    required this.id,
    required this.name,
    this.description,
    required this.branchLimit,
    this.order,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    map['branch_limit'] = Variable<int>(branchLimit);
    if (!nullToAbsent || order != null) {
      map['order'] = Variable<int>(order);
    }
    return map;
  }

  ProxyChainsCompanion toCompanion(bool nullToAbsent) {
    return ProxyChainsCompanion(
      id: Value(id),
      name: Value(name),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      branchLimit: Value(branchLimit),
      order: order == null && nullToAbsent
          ? const Value.absent()
          : Value(order),
    );
  }

  factory RawProxyChain.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return RawProxyChain(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      description: serializer.fromJson<String?>(json['description']),
      branchLimit: serializer.fromJson<int>(json['branchLimit']),
      order: serializer.fromJson<int?>(json['order']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'description': serializer.toJson<String?>(description),
      'branchLimit': serializer.toJson<int>(branchLimit),
      'order': serializer.toJson<int?>(order),
    };
  }

  RawProxyChain copyWith({
    int? id,
    String? name,
    Value<String?> description = const Value.absent(),
    int? branchLimit,
    Value<int?> order = const Value.absent(),
  }) => RawProxyChain(
    id: id ?? this.id,
    name: name ?? this.name,
    description: description.present ? description.value : this.description,
    branchLimit: branchLimit ?? this.branchLimit,
    order: order.present ? order.value : this.order,
  );
  RawProxyChain copyWithCompanion(ProxyChainsCompanion data) {
    return RawProxyChain(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      description: data.description.present
          ? data.description.value
          : this.description,
      branchLimit: data.branchLimit.present
          ? data.branchLimit.value
          : this.branchLimit,
      order: data.order.present ? data.order.value : this.order,
    );
  }

  @override
  String toString() {
    return (StringBuffer('RawProxyChain(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('branchLimit: $branchLimit, ')
          ..write('order: $order')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, description, branchLimit, order);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is RawProxyChain &&
          other.id == this.id &&
          other.name == this.name &&
          other.description == this.description &&
          other.branchLimit == this.branchLimit &&
          other.order == this.order);
}

class ProxyChainsCompanion extends UpdateCompanion<RawProxyChain> {
  final Value<int> id;
  final Value<String> name;
  final Value<String?> description;
  final Value<int> branchLimit;
  final Value<int?> order;
  const ProxyChainsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.description = const Value.absent(),
    this.branchLimit = const Value.absent(),
    this.order = const Value.absent(),
  });
  ProxyChainsCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    this.description = const Value.absent(),
    this.branchLimit = const Value.absent(),
    this.order = const Value.absent(),
  }) : name = Value(name);
  static Insertable<RawProxyChain> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? description,
    Expression<int>? branchLimit,
    Expression<int>? order,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (description != null) 'description': description,
      if (branchLimit != null) 'branch_limit': branchLimit,
      if (order != null) 'order': order,
    });
  }

  ProxyChainsCompanion copyWith({
    Value<int>? id,
    Value<String>? name,
    Value<String?>? description,
    Value<int>? branchLimit,
    Value<int?>? order,
  }) {
    return ProxyChainsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      branchLimit: branchLimit ?? this.branchLimit,
      order: order ?? this.order,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (branchLimit.present) {
      map['branch_limit'] = Variable<int>(branchLimit.value);
    }
    if (order.present) {
      map['order'] = Variable<int>(order.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ProxyChainsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('branchLimit: $branchLimit, ')
          ..write('order: $order')
          ..write(')'))
        .toString();
  }
}

class $ProxyChainHopsTable extends ProxyChainHops
    with TableInfo<$ProxyChainHopsTable, RawProxyChainHop> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ProxyChainHopsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _chainIdMeta = const VerificationMeta(
    'chainId',
  );
  @override
  late final GeneratedColumn<int> chainId = GeneratedColumn<int>(
    'chain_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES proxy_chains (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _orderMeta = const VerificationMeta('order');
  @override
  late final GeneratedColumn<int> order = GeneratedColumn<int>(
    'order',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _targetKindMeta = const VerificationMeta(
    'targetKind',
  );
  @override
  late final GeneratedColumn<String> targetKind = GeneratedColumn<String>(
    'target_kind',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nodeIdMeta = const VerificationMeta('nodeId');
  @override
  late final GeneratedColumn<int> nodeId = GeneratedColumn<int>(
    'node_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES proxy_nodes (id) ON DELETE SET NULL',
    ),
  );
  static const VerificationMeta _groupIdMeta = const VerificationMeta(
    'groupId',
  );
  @override
  late final GeneratedColumn<int> groupId = GeneratedColumn<int>(
    'group_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES proxy_groups (id) ON DELETE SET NULL',
    ),
  );
  static const VerificationMeta _profileIdMeta = const VerificationMeta(
    'profileId',
  );
  @override
  late final GeneratedColumn<int> profileId = GeneratedColumn<int>(
    'profile_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES profiles (id) ON DELETE SET NULL',
    ),
  );
  static const VerificationMeta _groupNameMeta = const VerificationMeta(
    'groupName',
  );
  @override
  late final GeneratedColumn<String> groupName = GeneratedColumn<String>(
    'group_name',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  late final GeneratedColumnWithTypeConverter<Map<String, Object?>?, String>
  localEndpoint =
      GeneratedColumn<String>(
        'local_endpoint',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      ).withConverter<Map<String, Object?>?>(
        $ProxyChainHopsTable.$converterlocalEndpoint,
      );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    chainId,
    order,
    targetKind,
    nodeId,
    groupId,
    profileId,
    groupName,
    localEndpoint,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'proxy_chain_hops';
  @override
  VerificationContext validateIntegrity(
    Insertable<RawProxyChainHop> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('chain_id')) {
      context.handle(
        _chainIdMeta,
        chainId.isAcceptableOrUnknown(data['chain_id']!, _chainIdMeta),
      );
    } else if (isInserting) {
      context.missing(_chainIdMeta);
    }
    if (data.containsKey('order')) {
      context.handle(
        _orderMeta,
        order.isAcceptableOrUnknown(data['order']!, _orderMeta),
      );
    } else if (isInserting) {
      context.missing(_orderMeta);
    }
    if (data.containsKey('target_kind')) {
      context.handle(
        _targetKindMeta,
        targetKind.isAcceptableOrUnknown(data['target_kind']!, _targetKindMeta),
      );
    } else if (isInserting) {
      context.missing(_targetKindMeta);
    }
    if (data.containsKey('node_id')) {
      context.handle(
        _nodeIdMeta,
        nodeId.isAcceptableOrUnknown(data['node_id']!, _nodeIdMeta),
      );
    }
    if (data.containsKey('group_id')) {
      context.handle(
        _groupIdMeta,
        groupId.isAcceptableOrUnknown(data['group_id']!, _groupIdMeta),
      );
    }
    if (data.containsKey('profile_id')) {
      context.handle(
        _profileIdMeta,
        profileId.isAcceptableOrUnknown(data['profile_id']!, _profileIdMeta),
      );
    }
    if (data.containsKey('group_name')) {
      context.handle(
        _groupNameMeta,
        groupName.isAcceptableOrUnknown(data['group_name']!, _groupNameMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  RawProxyChainHop map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return RawProxyChainHop(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      chainId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}chain_id'],
      )!,
      order: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}order'],
      )!,
      targetKind: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}target_kind'],
      )!,
      nodeId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}node_id'],
      ),
      groupId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}group_id'],
      ),
      profileId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}profile_id'],
      ),
      groupName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}group_name'],
      ),
      localEndpoint: $ProxyChainHopsTable.$converterlocalEndpoint.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}local_endpoint'],
        ),
      ),
    );
  }

  @override
  $ProxyChainHopsTable createAlias(String alias) {
    return $ProxyChainHopsTable(attachedDatabase, alias);
  }

  static TypeConverter<Map<String, Object?>?, String?> $converterlocalEndpoint =
      const JsonMapNullableConverter();
}

class RawProxyChainHop extends DataClass
    implements Insertable<RawProxyChainHop> {
  final int id;
  final int chainId;
  final int order;
  final String targetKind;
  final int? nodeId;
  final int? groupId;
  final int? profileId;
  final String? groupName;
  final Map<String, Object?>? localEndpoint;
  const RawProxyChainHop({
    required this.id,
    required this.chainId,
    required this.order,
    required this.targetKind,
    this.nodeId,
    this.groupId,
    this.profileId,
    this.groupName,
    this.localEndpoint,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['chain_id'] = Variable<int>(chainId);
    map['order'] = Variable<int>(order);
    map['target_kind'] = Variable<String>(targetKind);
    if (!nullToAbsent || nodeId != null) {
      map['node_id'] = Variable<int>(nodeId);
    }
    if (!nullToAbsent || groupId != null) {
      map['group_id'] = Variable<int>(groupId);
    }
    if (!nullToAbsent || profileId != null) {
      map['profile_id'] = Variable<int>(profileId);
    }
    if (!nullToAbsent || groupName != null) {
      map['group_name'] = Variable<String>(groupName);
    }
    if (!nullToAbsent || localEndpoint != null) {
      map['local_endpoint'] = Variable<String>(
        $ProxyChainHopsTable.$converterlocalEndpoint.toSql(localEndpoint),
      );
    }
    return map;
  }

  ProxyChainHopsCompanion toCompanion(bool nullToAbsent) {
    return ProxyChainHopsCompanion(
      id: Value(id),
      chainId: Value(chainId),
      order: Value(order),
      targetKind: Value(targetKind),
      nodeId: nodeId == null && nullToAbsent
          ? const Value.absent()
          : Value(nodeId),
      groupId: groupId == null && nullToAbsent
          ? const Value.absent()
          : Value(groupId),
      profileId: profileId == null && nullToAbsent
          ? const Value.absent()
          : Value(profileId),
      groupName: groupName == null && nullToAbsent
          ? const Value.absent()
          : Value(groupName),
      localEndpoint: localEndpoint == null && nullToAbsent
          ? const Value.absent()
          : Value(localEndpoint),
    );
  }

  factory RawProxyChainHop.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return RawProxyChainHop(
      id: serializer.fromJson<int>(json['id']),
      chainId: serializer.fromJson<int>(json['chainId']),
      order: serializer.fromJson<int>(json['order']),
      targetKind: serializer.fromJson<String>(json['targetKind']),
      nodeId: serializer.fromJson<int?>(json['nodeId']),
      groupId: serializer.fromJson<int?>(json['groupId']),
      profileId: serializer.fromJson<int?>(json['profileId']),
      groupName: serializer.fromJson<String?>(json['groupName']),
      localEndpoint: serializer.fromJson<Map<String, Object?>?>(
        json['localEndpoint'],
      ),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'chainId': serializer.toJson<int>(chainId),
      'order': serializer.toJson<int>(order),
      'targetKind': serializer.toJson<String>(targetKind),
      'nodeId': serializer.toJson<int?>(nodeId),
      'groupId': serializer.toJson<int?>(groupId),
      'profileId': serializer.toJson<int?>(profileId),
      'groupName': serializer.toJson<String?>(groupName),
      'localEndpoint': serializer.toJson<Map<String, Object?>?>(localEndpoint),
    };
  }

  RawProxyChainHop copyWith({
    int? id,
    int? chainId,
    int? order,
    String? targetKind,
    Value<int?> nodeId = const Value.absent(),
    Value<int?> groupId = const Value.absent(),
    Value<int?> profileId = const Value.absent(),
    Value<String?> groupName = const Value.absent(),
    Value<Map<String, Object?>?> localEndpoint = const Value.absent(),
  }) => RawProxyChainHop(
    id: id ?? this.id,
    chainId: chainId ?? this.chainId,
    order: order ?? this.order,
    targetKind: targetKind ?? this.targetKind,
    nodeId: nodeId.present ? nodeId.value : this.nodeId,
    groupId: groupId.present ? groupId.value : this.groupId,
    profileId: profileId.present ? profileId.value : this.profileId,
    groupName: groupName.present ? groupName.value : this.groupName,
    localEndpoint: localEndpoint.present
        ? localEndpoint.value
        : this.localEndpoint,
  );
  RawProxyChainHop copyWithCompanion(ProxyChainHopsCompanion data) {
    return RawProxyChainHop(
      id: data.id.present ? data.id.value : this.id,
      chainId: data.chainId.present ? data.chainId.value : this.chainId,
      order: data.order.present ? data.order.value : this.order,
      targetKind: data.targetKind.present
          ? data.targetKind.value
          : this.targetKind,
      nodeId: data.nodeId.present ? data.nodeId.value : this.nodeId,
      groupId: data.groupId.present ? data.groupId.value : this.groupId,
      profileId: data.profileId.present ? data.profileId.value : this.profileId,
      groupName: data.groupName.present ? data.groupName.value : this.groupName,
      localEndpoint: data.localEndpoint.present
          ? data.localEndpoint.value
          : this.localEndpoint,
    );
  }

  @override
  String toString() {
    return (StringBuffer('RawProxyChainHop(')
          ..write('id: $id, ')
          ..write('chainId: $chainId, ')
          ..write('order: $order, ')
          ..write('targetKind: $targetKind, ')
          ..write('nodeId: $nodeId, ')
          ..write('groupId: $groupId, ')
          ..write('profileId: $profileId, ')
          ..write('groupName: $groupName, ')
          ..write('localEndpoint: $localEndpoint')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    chainId,
    order,
    targetKind,
    nodeId,
    groupId,
    profileId,
    groupName,
    localEndpoint,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is RawProxyChainHop &&
          other.id == this.id &&
          other.chainId == this.chainId &&
          other.order == this.order &&
          other.targetKind == this.targetKind &&
          other.nodeId == this.nodeId &&
          other.groupId == this.groupId &&
          other.profileId == this.profileId &&
          other.groupName == this.groupName &&
          other.localEndpoint == this.localEndpoint);
}

class ProxyChainHopsCompanion extends UpdateCompanion<RawProxyChainHop> {
  final Value<int> id;
  final Value<int> chainId;
  final Value<int> order;
  final Value<String> targetKind;
  final Value<int?> nodeId;
  final Value<int?> groupId;
  final Value<int?> profileId;
  final Value<String?> groupName;
  final Value<Map<String, Object?>?> localEndpoint;
  const ProxyChainHopsCompanion({
    this.id = const Value.absent(),
    this.chainId = const Value.absent(),
    this.order = const Value.absent(),
    this.targetKind = const Value.absent(),
    this.nodeId = const Value.absent(),
    this.groupId = const Value.absent(),
    this.profileId = const Value.absent(),
    this.groupName = const Value.absent(),
    this.localEndpoint = const Value.absent(),
  });
  ProxyChainHopsCompanion.insert({
    this.id = const Value.absent(),
    required int chainId,
    required int order,
    required String targetKind,
    this.nodeId = const Value.absent(),
    this.groupId = const Value.absent(),
    this.profileId = const Value.absent(),
    this.groupName = const Value.absent(),
    this.localEndpoint = const Value.absent(),
  }) : chainId = Value(chainId),
       order = Value(order),
       targetKind = Value(targetKind);
  static Insertable<RawProxyChainHop> custom({
    Expression<int>? id,
    Expression<int>? chainId,
    Expression<int>? order,
    Expression<String>? targetKind,
    Expression<int>? nodeId,
    Expression<int>? groupId,
    Expression<int>? profileId,
    Expression<String>? groupName,
    Expression<String>? localEndpoint,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (chainId != null) 'chain_id': chainId,
      if (order != null) 'order': order,
      if (targetKind != null) 'target_kind': targetKind,
      if (nodeId != null) 'node_id': nodeId,
      if (groupId != null) 'group_id': groupId,
      if (profileId != null) 'profile_id': profileId,
      if (groupName != null) 'group_name': groupName,
      if (localEndpoint != null) 'local_endpoint': localEndpoint,
    });
  }

  ProxyChainHopsCompanion copyWith({
    Value<int>? id,
    Value<int>? chainId,
    Value<int>? order,
    Value<String>? targetKind,
    Value<int?>? nodeId,
    Value<int?>? groupId,
    Value<int?>? profileId,
    Value<String?>? groupName,
    Value<Map<String, Object?>?>? localEndpoint,
  }) {
    return ProxyChainHopsCompanion(
      id: id ?? this.id,
      chainId: chainId ?? this.chainId,
      order: order ?? this.order,
      targetKind: targetKind ?? this.targetKind,
      nodeId: nodeId ?? this.nodeId,
      groupId: groupId ?? this.groupId,
      profileId: profileId ?? this.profileId,
      groupName: groupName ?? this.groupName,
      localEndpoint: localEndpoint ?? this.localEndpoint,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (chainId.present) {
      map['chain_id'] = Variable<int>(chainId.value);
    }
    if (order.present) {
      map['order'] = Variable<int>(order.value);
    }
    if (targetKind.present) {
      map['target_kind'] = Variable<String>(targetKind.value);
    }
    if (nodeId.present) {
      map['node_id'] = Variable<int>(nodeId.value);
    }
    if (groupId.present) {
      map['group_id'] = Variable<int>(groupId.value);
    }
    if (profileId.present) {
      map['profile_id'] = Variable<int>(profileId.value);
    }
    if (groupName.present) {
      map['group_name'] = Variable<String>(groupName.value);
    }
    if (localEndpoint.present) {
      map['local_endpoint'] = Variable<String>(
        $ProxyChainHopsTable.$converterlocalEndpoint.toSql(localEndpoint.value),
      );
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ProxyChainHopsCompanion(')
          ..write('id: $id, ')
          ..write('chainId: $chainId, ')
          ..write('order: $order, ')
          ..write('targetKind: $targetKind, ')
          ..write('nodeId: $nodeId, ')
          ..write('groupId: $groupId, ')
          ..write('profileId: $profileId, ')
          ..write('groupName: $groupName, ')
          ..write('localEndpoint: $localEndpoint')
          ..write(')'))
        .toString();
  }
}

class $ProxyChainBindingsTable extends ProxyChainBindings
    with TableInfo<$ProxyChainBindingsTable, RawProxyChainBinding> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ProxyChainBindingsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _profileIdMeta = const VerificationMeta(
    'profileId',
  );
  @override
  late final GeneratedColumn<int> profileId = GeneratedColumn<int>(
    'profile_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES profiles (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _chainIdMeta = const VerificationMeta(
    'chainId',
  );
  @override
  late final GeneratedColumn<int> chainId = GeneratedColumn<int>(
    'chain_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES proxy_chains (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _enabledMeta = const VerificationMeta(
    'enabled',
  );
  @override
  late final GeneratedColumn<bool> enabled = GeneratedColumn<bool>(
    'enabled',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("enabled" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _isDefaultMeta = const VerificationMeta(
    'isDefault',
  );
  @override
  late final GeneratedColumn<bool> isDefault = GeneratedColumn<bool>(
    'is_default',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_default" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _selectorNameMeta = const VerificationMeta(
    'selectorName',
  );
  @override
  late final GeneratedColumn<String> selectorName = GeneratedColumn<String>(
    'selector_name',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _orderMeta = const VerificationMeta('order');
  @override
  late final GeneratedColumn<int> order = GeneratedColumn<int>(
    'order',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    profileId,
    chainId,
    enabled,
    isDefault,
    selectorName,
    order,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'profile_proxy_chains';
  @override
  VerificationContext validateIntegrity(
    Insertable<RawProxyChainBinding> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('profile_id')) {
      context.handle(
        _profileIdMeta,
        profileId.isAcceptableOrUnknown(data['profile_id']!, _profileIdMeta),
      );
    } else if (isInserting) {
      context.missing(_profileIdMeta);
    }
    if (data.containsKey('chain_id')) {
      context.handle(
        _chainIdMeta,
        chainId.isAcceptableOrUnknown(data['chain_id']!, _chainIdMeta),
      );
    } else if (isInserting) {
      context.missing(_chainIdMeta);
    }
    if (data.containsKey('enabled')) {
      context.handle(
        _enabledMeta,
        enabled.isAcceptableOrUnknown(data['enabled']!, _enabledMeta),
      );
    }
    if (data.containsKey('is_default')) {
      context.handle(
        _isDefaultMeta,
        isDefault.isAcceptableOrUnknown(data['is_default']!, _isDefaultMeta),
      );
    }
    if (data.containsKey('selector_name')) {
      context.handle(
        _selectorNameMeta,
        selectorName.isAcceptableOrUnknown(
          data['selector_name']!,
          _selectorNameMeta,
        ),
      );
    }
    if (data.containsKey('order')) {
      context.handle(
        _orderMeta,
        order.isAcceptableOrUnknown(data['order']!, _orderMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {profileId, chainId};
  @override
  RawProxyChainBinding map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return RawProxyChainBinding(
      profileId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}profile_id'],
      )!,
      chainId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}chain_id'],
      )!,
      enabled: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}enabled'],
      )!,
      isDefault: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_default'],
      )!,
      selectorName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}selector_name'],
      ),
      order: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}order'],
      ),
    );
  }

  @override
  $ProxyChainBindingsTable createAlias(String alias) {
    return $ProxyChainBindingsTable(attachedDatabase, alias);
  }
}

class RawProxyChainBinding extends DataClass
    implements Insertable<RawProxyChainBinding> {
  final int profileId;
  final int chainId;
  final bool enabled;
  final bool isDefault;
  final String? selectorName;
  final int? order;
  const RawProxyChainBinding({
    required this.profileId,
    required this.chainId,
    required this.enabled,
    required this.isDefault,
    this.selectorName,
    this.order,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['profile_id'] = Variable<int>(profileId);
    map['chain_id'] = Variable<int>(chainId);
    map['enabled'] = Variable<bool>(enabled);
    map['is_default'] = Variable<bool>(isDefault);
    if (!nullToAbsent || selectorName != null) {
      map['selector_name'] = Variable<String>(selectorName);
    }
    if (!nullToAbsent || order != null) {
      map['order'] = Variable<int>(order);
    }
    return map;
  }

  ProxyChainBindingsCompanion toCompanion(bool nullToAbsent) {
    return ProxyChainBindingsCompanion(
      profileId: Value(profileId),
      chainId: Value(chainId),
      enabled: Value(enabled),
      isDefault: Value(isDefault),
      selectorName: selectorName == null && nullToAbsent
          ? const Value.absent()
          : Value(selectorName),
      order: order == null && nullToAbsent
          ? const Value.absent()
          : Value(order),
    );
  }

  factory RawProxyChainBinding.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return RawProxyChainBinding(
      profileId: serializer.fromJson<int>(json['profileId']),
      chainId: serializer.fromJson<int>(json['chainId']),
      enabled: serializer.fromJson<bool>(json['enabled']),
      isDefault: serializer.fromJson<bool>(json['isDefault']),
      selectorName: serializer.fromJson<String?>(json['selectorName']),
      order: serializer.fromJson<int?>(json['order']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'profileId': serializer.toJson<int>(profileId),
      'chainId': serializer.toJson<int>(chainId),
      'enabled': serializer.toJson<bool>(enabled),
      'isDefault': serializer.toJson<bool>(isDefault),
      'selectorName': serializer.toJson<String?>(selectorName),
      'order': serializer.toJson<int?>(order),
    };
  }

  RawProxyChainBinding copyWith({
    int? profileId,
    int? chainId,
    bool? enabled,
    bool? isDefault,
    Value<String?> selectorName = const Value.absent(),
    Value<int?> order = const Value.absent(),
  }) => RawProxyChainBinding(
    profileId: profileId ?? this.profileId,
    chainId: chainId ?? this.chainId,
    enabled: enabled ?? this.enabled,
    isDefault: isDefault ?? this.isDefault,
    selectorName: selectorName.present ? selectorName.value : this.selectorName,
    order: order.present ? order.value : this.order,
  );
  RawProxyChainBinding copyWithCompanion(ProxyChainBindingsCompanion data) {
    return RawProxyChainBinding(
      profileId: data.profileId.present ? data.profileId.value : this.profileId,
      chainId: data.chainId.present ? data.chainId.value : this.chainId,
      enabled: data.enabled.present ? data.enabled.value : this.enabled,
      isDefault: data.isDefault.present ? data.isDefault.value : this.isDefault,
      selectorName: data.selectorName.present
          ? data.selectorName.value
          : this.selectorName,
      order: data.order.present ? data.order.value : this.order,
    );
  }

  @override
  String toString() {
    return (StringBuffer('RawProxyChainBinding(')
          ..write('profileId: $profileId, ')
          ..write('chainId: $chainId, ')
          ..write('enabled: $enabled, ')
          ..write('isDefault: $isDefault, ')
          ..write('selectorName: $selectorName, ')
          ..write('order: $order')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(profileId, chainId, enabled, isDefault, selectorName, order);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is RawProxyChainBinding &&
          other.profileId == this.profileId &&
          other.chainId == this.chainId &&
          other.enabled == this.enabled &&
          other.isDefault == this.isDefault &&
          other.selectorName == this.selectorName &&
          other.order == this.order);
}

class ProxyChainBindingsCompanion
    extends UpdateCompanion<RawProxyChainBinding> {
  final Value<int> profileId;
  final Value<int> chainId;
  final Value<bool> enabled;
  final Value<bool> isDefault;
  final Value<String?> selectorName;
  final Value<int?> order;
  final Value<int> rowid;
  const ProxyChainBindingsCompanion({
    this.profileId = const Value.absent(),
    this.chainId = const Value.absent(),
    this.enabled = const Value.absent(),
    this.isDefault = const Value.absent(),
    this.selectorName = const Value.absent(),
    this.order = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ProxyChainBindingsCompanion.insert({
    required int profileId,
    required int chainId,
    this.enabled = const Value.absent(),
    this.isDefault = const Value.absent(),
    this.selectorName = const Value.absent(),
    this.order = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : profileId = Value(profileId),
       chainId = Value(chainId);
  static Insertable<RawProxyChainBinding> custom({
    Expression<int>? profileId,
    Expression<int>? chainId,
    Expression<bool>? enabled,
    Expression<bool>? isDefault,
    Expression<String>? selectorName,
    Expression<int>? order,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (profileId != null) 'profile_id': profileId,
      if (chainId != null) 'chain_id': chainId,
      if (enabled != null) 'enabled': enabled,
      if (isDefault != null) 'is_default': isDefault,
      if (selectorName != null) 'selector_name': selectorName,
      if (order != null) 'order': order,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ProxyChainBindingsCompanion copyWith({
    Value<int>? profileId,
    Value<int>? chainId,
    Value<bool>? enabled,
    Value<bool>? isDefault,
    Value<String?>? selectorName,
    Value<int?>? order,
    Value<int>? rowid,
  }) {
    return ProxyChainBindingsCompanion(
      profileId: profileId ?? this.profileId,
      chainId: chainId ?? this.chainId,
      enabled: enabled ?? this.enabled,
      isDefault: isDefault ?? this.isDefault,
      selectorName: selectorName ?? this.selectorName,
      order: order ?? this.order,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (profileId.present) {
      map['profile_id'] = Variable<int>(profileId.value);
    }
    if (chainId.present) {
      map['chain_id'] = Variable<int>(chainId.value);
    }
    if (enabled.present) {
      map['enabled'] = Variable<bool>(enabled.value);
    }
    if (isDefault.present) {
      map['is_default'] = Variable<bool>(isDefault.value);
    }
    if (selectorName.present) {
      map['selector_name'] = Variable<String>(selectorName.value);
    }
    if (order.present) {
      map['order'] = Variable<int>(order.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ProxyChainBindingsCompanion(')
          ..write('profileId: $profileId, ')
          ..write('chainId: $chainId, ')
          ..write('enabled: $enabled, ')
          ..write('isDefault: $isDefault, ')
          ..write('selectorName: $selectorName, ')
          ..write('order: $order, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ProxyNodeAssetsTable extends ProxyNodeAssets
    with TableInfo<$ProxyNodeAssetsTable, RawProxyNodeAsset> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ProxyNodeAssetsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _nodeIdMeta = const VerificationMeta('nodeId');
  @override
  late final GeneratedColumn<int> nodeId = GeneratedColumn<int>(
    'node_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES proxy_nodes (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _fieldPathMeta = const VerificationMeta(
    'fieldPath',
  );
  @override
  late final GeneratedColumn<String> fieldPath = GeneratedColumn<String>(
    'field_path',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _fileNameMeta = const VerificationMeta(
    'fileName',
  );
  @override
  late final GeneratedColumn<String> fileName = GeneratedColumn<String>(
    'file_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _relativePathMeta = const VerificationMeta(
    'relativePath',
  );
  @override
  late final GeneratedColumn<String> relativePath = GeneratedColumn<String>(
    'relative_path',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _sha256Meta = const VerificationMeta('sha256');
  @override
  late final GeneratedColumn<String> sha256 = GeneratedColumn<String>(
    'sha256',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _sizeMeta = const VerificationMeta('size');
  @override
  late final GeneratedColumn<int> size = GeneratedColumn<int>(
    'size',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    nodeId,
    fieldPath,
    fileName,
    relativePath,
    sha256,
    size,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'proxy_node_assets';
  @override
  VerificationContext validateIntegrity(
    Insertable<RawProxyNodeAsset> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('node_id')) {
      context.handle(
        _nodeIdMeta,
        nodeId.isAcceptableOrUnknown(data['node_id']!, _nodeIdMeta),
      );
    } else if (isInserting) {
      context.missing(_nodeIdMeta);
    }
    if (data.containsKey('field_path')) {
      context.handle(
        _fieldPathMeta,
        fieldPath.isAcceptableOrUnknown(data['field_path']!, _fieldPathMeta),
      );
    } else if (isInserting) {
      context.missing(_fieldPathMeta);
    }
    if (data.containsKey('file_name')) {
      context.handle(
        _fileNameMeta,
        fileName.isAcceptableOrUnknown(data['file_name']!, _fileNameMeta),
      );
    } else if (isInserting) {
      context.missing(_fileNameMeta);
    }
    if (data.containsKey('relative_path')) {
      context.handle(
        _relativePathMeta,
        relativePath.isAcceptableOrUnknown(
          data['relative_path']!,
          _relativePathMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_relativePathMeta);
    }
    if (data.containsKey('sha256')) {
      context.handle(
        _sha256Meta,
        sha256.isAcceptableOrUnknown(data['sha256']!, _sha256Meta),
      );
    } else if (isInserting) {
      context.missing(_sha256Meta);
    }
    if (data.containsKey('size')) {
      context.handle(
        _sizeMeta,
        size.isAcceptableOrUnknown(data['size']!, _sizeMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  RawProxyNodeAsset map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return RawProxyNodeAsset(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      nodeId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}node_id'],
      )!,
      fieldPath: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}field_path'],
      )!,
      fileName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}file_name'],
      )!,
      relativePath: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}relative_path'],
      )!,
      sha256: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}sha256'],
      )!,
      size: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}size'],
      ),
    );
  }

  @override
  $ProxyNodeAssetsTable createAlias(String alias) {
    return $ProxyNodeAssetsTable(attachedDatabase, alias);
  }
}

class RawProxyNodeAsset extends DataClass
    implements Insertable<RawProxyNodeAsset> {
  final int id;
  final int nodeId;
  final String fieldPath;
  final String fileName;
  final String relativePath;
  final String sha256;
  final int? size;
  const RawProxyNodeAsset({
    required this.id,
    required this.nodeId,
    required this.fieldPath,
    required this.fileName,
    required this.relativePath,
    required this.sha256,
    this.size,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['node_id'] = Variable<int>(nodeId);
    map['field_path'] = Variable<String>(fieldPath);
    map['file_name'] = Variable<String>(fileName);
    map['relative_path'] = Variable<String>(relativePath);
    map['sha256'] = Variable<String>(sha256);
    if (!nullToAbsent || size != null) {
      map['size'] = Variable<int>(size);
    }
    return map;
  }

  ProxyNodeAssetsCompanion toCompanion(bool nullToAbsent) {
    return ProxyNodeAssetsCompanion(
      id: Value(id),
      nodeId: Value(nodeId),
      fieldPath: Value(fieldPath),
      fileName: Value(fileName),
      relativePath: Value(relativePath),
      sha256: Value(sha256),
      size: size == null && nullToAbsent ? const Value.absent() : Value(size),
    );
  }

  factory RawProxyNodeAsset.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return RawProxyNodeAsset(
      id: serializer.fromJson<int>(json['id']),
      nodeId: serializer.fromJson<int>(json['nodeId']),
      fieldPath: serializer.fromJson<String>(json['fieldPath']),
      fileName: serializer.fromJson<String>(json['fileName']),
      relativePath: serializer.fromJson<String>(json['relativePath']),
      sha256: serializer.fromJson<String>(json['sha256']),
      size: serializer.fromJson<int?>(json['size']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'nodeId': serializer.toJson<int>(nodeId),
      'fieldPath': serializer.toJson<String>(fieldPath),
      'fileName': serializer.toJson<String>(fileName),
      'relativePath': serializer.toJson<String>(relativePath),
      'sha256': serializer.toJson<String>(sha256),
      'size': serializer.toJson<int?>(size),
    };
  }

  RawProxyNodeAsset copyWith({
    int? id,
    int? nodeId,
    String? fieldPath,
    String? fileName,
    String? relativePath,
    String? sha256,
    Value<int?> size = const Value.absent(),
  }) => RawProxyNodeAsset(
    id: id ?? this.id,
    nodeId: nodeId ?? this.nodeId,
    fieldPath: fieldPath ?? this.fieldPath,
    fileName: fileName ?? this.fileName,
    relativePath: relativePath ?? this.relativePath,
    sha256: sha256 ?? this.sha256,
    size: size.present ? size.value : this.size,
  );
  RawProxyNodeAsset copyWithCompanion(ProxyNodeAssetsCompanion data) {
    return RawProxyNodeAsset(
      id: data.id.present ? data.id.value : this.id,
      nodeId: data.nodeId.present ? data.nodeId.value : this.nodeId,
      fieldPath: data.fieldPath.present ? data.fieldPath.value : this.fieldPath,
      fileName: data.fileName.present ? data.fileName.value : this.fileName,
      relativePath: data.relativePath.present
          ? data.relativePath.value
          : this.relativePath,
      sha256: data.sha256.present ? data.sha256.value : this.sha256,
      size: data.size.present ? data.size.value : this.size,
    );
  }

  @override
  String toString() {
    return (StringBuffer('RawProxyNodeAsset(')
          ..write('id: $id, ')
          ..write('nodeId: $nodeId, ')
          ..write('fieldPath: $fieldPath, ')
          ..write('fileName: $fileName, ')
          ..write('relativePath: $relativePath, ')
          ..write('sha256: $sha256, ')
          ..write('size: $size')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, nodeId, fieldPath, fileName, relativePath, sha256, size);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is RawProxyNodeAsset &&
          other.id == this.id &&
          other.nodeId == this.nodeId &&
          other.fieldPath == this.fieldPath &&
          other.fileName == this.fileName &&
          other.relativePath == this.relativePath &&
          other.sha256 == this.sha256 &&
          other.size == this.size);
}

class ProxyNodeAssetsCompanion extends UpdateCompanion<RawProxyNodeAsset> {
  final Value<int> id;
  final Value<int> nodeId;
  final Value<String> fieldPath;
  final Value<String> fileName;
  final Value<String> relativePath;
  final Value<String> sha256;
  final Value<int?> size;
  const ProxyNodeAssetsCompanion({
    this.id = const Value.absent(),
    this.nodeId = const Value.absent(),
    this.fieldPath = const Value.absent(),
    this.fileName = const Value.absent(),
    this.relativePath = const Value.absent(),
    this.sha256 = const Value.absent(),
    this.size = const Value.absent(),
  });
  ProxyNodeAssetsCompanion.insert({
    this.id = const Value.absent(),
    required int nodeId,
    required String fieldPath,
    required String fileName,
    required String relativePath,
    required String sha256,
    this.size = const Value.absent(),
  }) : nodeId = Value(nodeId),
       fieldPath = Value(fieldPath),
       fileName = Value(fileName),
       relativePath = Value(relativePath),
       sha256 = Value(sha256);
  static Insertable<RawProxyNodeAsset> custom({
    Expression<int>? id,
    Expression<int>? nodeId,
    Expression<String>? fieldPath,
    Expression<String>? fileName,
    Expression<String>? relativePath,
    Expression<String>? sha256,
    Expression<int>? size,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (nodeId != null) 'node_id': nodeId,
      if (fieldPath != null) 'field_path': fieldPath,
      if (fileName != null) 'file_name': fileName,
      if (relativePath != null) 'relative_path': relativePath,
      if (sha256 != null) 'sha256': sha256,
      if (size != null) 'size': size,
    });
  }

  ProxyNodeAssetsCompanion copyWith({
    Value<int>? id,
    Value<int>? nodeId,
    Value<String>? fieldPath,
    Value<String>? fileName,
    Value<String>? relativePath,
    Value<String>? sha256,
    Value<int?>? size,
  }) {
    return ProxyNodeAssetsCompanion(
      id: id ?? this.id,
      nodeId: nodeId ?? this.nodeId,
      fieldPath: fieldPath ?? this.fieldPath,
      fileName: fileName ?? this.fileName,
      relativePath: relativePath ?? this.relativePath,
      sha256: sha256 ?? this.sha256,
      size: size ?? this.size,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (nodeId.present) {
      map['node_id'] = Variable<int>(nodeId.value);
    }
    if (fieldPath.present) {
      map['field_path'] = Variable<String>(fieldPath.value);
    }
    if (fileName.present) {
      map['file_name'] = Variable<String>(fileName.value);
    }
    if (relativePath.present) {
      map['relative_path'] = Variable<String>(relativePath.value);
    }
    if (sha256.present) {
      map['sha256'] = Variable<String>(sha256.value);
    }
    if (size.present) {
      map['size'] = Variable<int>(size.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ProxyNodeAssetsCompanion(')
          ..write('id: $id, ')
          ..write('nodeId: $nodeId, ')
          ..write('fieldPath: $fieldPath, ')
          ..write('fileName: $fileName, ')
          ..write('relativePath: $relativePath, ')
          ..write('sha256: $sha256, ')
          ..write('size: $size')
          ..write(')'))
        .toString();
  }
}

class $ProxyGroupMembersTable extends ProxyGroupMembers
    with TableInfo<$ProxyGroupMembersTable, RawProxyGroupMember> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ProxyGroupMembersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _groupIdMeta = const VerificationMeta(
    'groupId',
  );
  @override
  late final GeneratedColumn<int> groupId = GeneratedColumn<int>(
    'group_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES proxy_groups (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _nodeIdMeta = const VerificationMeta('nodeId');
  @override
  late final GeneratedColumn<int> nodeId = GeneratedColumn<int>(
    'node_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES proxy_nodes (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _literalNameMeta = const VerificationMeta(
    'literalName',
  );
  @override
  late final GeneratedColumn<String> literalName = GeneratedColumn<String>(
    'literal_name',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _orderMeta = const VerificationMeta('order');
  @override
  late final GeneratedColumn<int> order = GeneratedColumn<int>(
    'order',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    groupId,
    nodeId,
    literalName,
    order,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'proxy_group_members';
  @override
  VerificationContext validateIntegrity(
    Insertable<RawProxyGroupMember> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('group_id')) {
      context.handle(
        _groupIdMeta,
        groupId.isAcceptableOrUnknown(data['group_id']!, _groupIdMeta),
      );
    } else if (isInserting) {
      context.missing(_groupIdMeta);
    }
    if (data.containsKey('node_id')) {
      context.handle(
        _nodeIdMeta,
        nodeId.isAcceptableOrUnknown(data['node_id']!, _nodeIdMeta),
      );
    }
    if (data.containsKey('literal_name')) {
      context.handle(
        _literalNameMeta,
        literalName.isAcceptableOrUnknown(
          data['literal_name']!,
          _literalNameMeta,
        ),
      );
    }
    if (data.containsKey('order')) {
      context.handle(
        _orderMeta,
        order.isAcceptableOrUnknown(data['order']!, _orderMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  RawProxyGroupMember map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return RawProxyGroupMember(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      groupId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}group_id'],
      )!,
      nodeId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}node_id'],
      ),
      literalName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}literal_name'],
      ),
      order: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}order'],
      ),
    );
  }

  @override
  $ProxyGroupMembersTable createAlias(String alias) {
    return $ProxyGroupMembersTable(attachedDatabase, alias);
  }
}

class RawProxyGroupMember extends DataClass
    implements Insertable<RawProxyGroupMember> {
  final int id;
  final int groupId;
  final int? nodeId;
  final String? literalName;
  final int? order;
  const RawProxyGroupMember({
    required this.id,
    required this.groupId,
    this.nodeId,
    this.literalName,
    this.order,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['group_id'] = Variable<int>(groupId);
    if (!nullToAbsent || nodeId != null) {
      map['node_id'] = Variable<int>(nodeId);
    }
    if (!nullToAbsent || literalName != null) {
      map['literal_name'] = Variable<String>(literalName);
    }
    if (!nullToAbsent || order != null) {
      map['order'] = Variable<int>(order);
    }
    return map;
  }

  ProxyGroupMembersCompanion toCompanion(bool nullToAbsent) {
    return ProxyGroupMembersCompanion(
      id: Value(id),
      groupId: Value(groupId),
      nodeId: nodeId == null && nullToAbsent
          ? const Value.absent()
          : Value(nodeId),
      literalName: literalName == null && nullToAbsent
          ? const Value.absent()
          : Value(literalName),
      order: order == null && nullToAbsent
          ? const Value.absent()
          : Value(order),
    );
  }

  factory RawProxyGroupMember.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return RawProxyGroupMember(
      id: serializer.fromJson<int>(json['id']),
      groupId: serializer.fromJson<int>(json['groupId']),
      nodeId: serializer.fromJson<int?>(json['nodeId']),
      literalName: serializer.fromJson<String?>(json['literalName']),
      order: serializer.fromJson<int?>(json['order']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'groupId': serializer.toJson<int>(groupId),
      'nodeId': serializer.toJson<int?>(nodeId),
      'literalName': serializer.toJson<String?>(literalName),
      'order': serializer.toJson<int?>(order),
    };
  }

  RawProxyGroupMember copyWith({
    int? id,
    int? groupId,
    Value<int?> nodeId = const Value.absent(),
    Value<String?> literalName = const Value.absent(),
    Value<int?> order = const Value.absent(),
  }) => RawProxyGroupMember(
    id: id ?? this.id,
    groupId: groupId ?? this.groupId,
    nodeId: nodeId.present ? nodeId.value : this.nodeId,
    literalName: literalName.present ? literalName.value : this.literalName,
    order: order.present ? order.value : this.order,
  );
  RawProxyGroupMember copyWithCompanion(ProxyGroupMembersCompanion data) {
    return RawProxyGroupMember(
      id: data.id.present ? data.id.value : this.id,
      groupId: data.groupId.present ? data.groupId.value : this.groupId,
      nodeId: data.nodeId.present ? data.nodeId.value : this.nodeId,
      literalName: data.literalName.present
          ? data.literalName.value
          : this.literalName,
      order: data.order.present ? data.order.value : this.order,
    );
  }

  @override
  String toString() {
    return (StringBuffer('RawProxyGroupMember(')
          ..write('id: $id, ')
          ..write('groupId: $groupId, ')
          ..write('nodeId: $nodeId, ')
          ..write('literalName: $literalName, ')
          ..write('order: $order')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, groupId, nodeId, literalName, order);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is RawProxyGroupMember &&
          other.id == this.id &&
          other.groupId == this.groupId &&
          other.nodeId == this.nodeId &&
          other.literalName == this.literalName &&
          other.order == this.order);
}

class ProxyGroupMembersCompanion extends UpdateCompanion<RawProxyGroupMember> {
  final Value<int> id;
  final Value<int> groupId;
  final Value<int?> nodeId;
  final Value<String?> literalName;
  final Value<int?> order;
  const ProxyGroupMembersCompanion({
    this.id = const Value.absent(),
    this.groupId = const Value.absent(),
    this.nodeId = const Value.absent(),
    this.literalName = const Value.absent(),
    this.order = const Value.absent(),
  });
  ProxyGroupMembersCompanion.insert({
    this.id = const Value.absent(),
    required int groupId,
    this.nodeId = const Value.absent(),
    this.literalName = const Value.absent(),
    this.order = const Value.absent(),
  }) : groupId = Value(groupId);
  static Insertable<RawProxyGroupMember> custom({
    Expression<int>? id,
    Expression<int>? groupId,
    Expression<int>? nodeId,
    Expression<String>? literalName,
    Expression<int>? order,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (groupId != null) 'group_id': groupId,
      if (nodeId != null) 'node_id': nodeId,
      if (literalName != null) 'literal_name': literalName,
      if (order != null) 'order': order,
    });
  }

  ProxyGroupMembersCompanion copyWith({
    Value<int>? id,
    Value<int>? groupId,
    Value<int?>? nodeId,
    Value<String?>? literalName,
    Value<int?>? order,
  }) {
    return ProxyGroupMembersCompanion(
      id: id ?? this.id,
      groupId: groupId ?? this.groupId,
      nodeId: nodeId ?? this.nodeId,
      literalName: literalName ?? this.literalName,
      order: order ?? this.order,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (groupId.present) {
      map['group_id'] = Variable<int>(groupId.value);
    }
    if (nodeId.present) {
      map['node_id'] = Variable<int>(nodeId.value);
    }
    if (literalName.present) {
      map['literal_name'] = Variable<String>(literalName.value);
    }
    if (order.present) {
      map['order'] = Variable<int>(order.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ProxyGroupMembersCompanion(')
          ..write('id: $id, ')
          ..write('groupId: $groupId, ')
          ..write('nodeId: $nodeId, ')
          ..write('literalName: $literalName, ')
          ..write('order: $order')
          ..write(')'))
        .toString();
  }
}

abstract class _$Database extends GeneratedDatabase {
  _$Database(QueryExecutor e) : super(e);
  $DatabaseManager get managers => $DatabaseManager(this);
  late final $ProfilesTable profiles = $ProfilesTable(this);
  late final $ScriptsTable scripts = $ScriptsTable(this);
  late final $RulesTable rules = $RulesTable(this);
  late final $ProfileRuleLinksTable profileRuleLinks = $ProfileRuleLinksTable(
    this,
  );
  late final $ProxyGroupsTable proxyGroups = $ProxyGroupsTable(this);
  late final $IconRecordsTable iconRecords = $IconRecordsTable(this);
  late final $ProxyNodesTable proxyNodes = $ProxyNodesTable(this);
  late final $ProxyNodeBindingsTable proxyNodeBindings =
      $ProxyNodeBindingsTable(this);
  late final $ProxyChainsTable proxyChains = $ProxyChainsTable(this);
  late final $ProxyChainHopsTable proxyChainHops = $ProxyChainHopsTable(this);
  late final $ProxyChainBindingsTable proxyChainBindings =
      $ProxyChainBindingsTable(this);
  late final $ProxyNodeAssetsTable proxyNodeAssets = $ProxyNodeAssetsTable(
    this,
  );
  late final $ProxyGroupMembersTable proxyGroupMembers =
      $ProxyGroupMembersTable(this);
  late final Index idxRuleTarget = Index(
    'idx_rule_target',
    'CREATE INDEX idx_rule_target ON rules (rule_target)',
  );
  late final Index idxProfileSceneOrder = Index(
    'idx_profile_scene_order',
    'CREATE INDEX idx_profile_scene_order ON profile_rule_mapping (profile_id, scene, "order")',
  );
  late final Index idxProfileNameOrder = Index(
    'idx_profile_name_order',
    'CREATE INDEX idx_profile_name_order ON proxy_groups (profile_id, name, "order")',
  );
  late final Index lastAccessedUrl = Index(
    'last_accessed_url',
    'CREATE INDEX last_accessed_url ON icon_records (last_accessed, url)',
  );
  late final Index idxProxyNodesFingerprint = Index(
    'idx_proxy_nodes_fingerprint',
    'CREATE INDEX idx_proxy_nodes_fingerprint ON proxy_nodes (fingerprint)',
  );
  late final Index idxProxyNodesSource = Index(
    'idx_proxy_nodes_source',
    'CREATE INDEX idx_proxy_nodes_source ON proxy_nodes (source_kind, source_key)',
  );
  late final Index idxProfileProxyNodesProfileOrder = Index(
    'idx_profile_proxy_nodes_profile_order',
    'CREATE INDEX idx_profile_proxy_nodes_profile_order ON profile_proxy_nodes (profile_id, "order")',
  );
  late final Index idxProxyChainsOrder = Index(
    'idx_proxy_chains_order',
    'CREATE INDEX idx_proxy_chains_order ON proxy_chains ("order")',
  );
  late final Index idxProxyChainHopsChainOrder = Index(
    'idx_proxy_chain_hops_chain_order',
    'CREATE INDEX idx_proxy_chain_hops_chain_order ON proxy_chain_hops (chain_id, "order")',
  );
  late final Index idxProfileProxyChainsProfileOrder = Index(
    'idx_profile_proxy_chains_profile_order',
    'CREATE INDEX idx_profile_proxy_chains_profile_order ON profile_proxy_chains (profile_id, "order")',
  );
  late final ProfilesDao profilesDao = ProfilesDao(this as Database);
  late final ScriptsDao scriptsDao = ScriptsDao(this as Database);
  late final RulesDao rulesDao = RulesDao(this as Database);
  late final ProxyGroupsDao proxyGroupsDao = ProxyGroupsDao(this as Database);
  late final IconRecordsDao iconRecordsDao = IconRecordsDao(this as Database);
  late final ProxyNodesDao proxyNodesDao = ProxyNodesDao(this as Database);
  late final ProxyNodeBindingsDao proxyNodeBindingsDao = ProxyNodeBindingsDao(
    this as Database,
  );
  late final ProxyChainsDao proxyChainsDao = ProxyChainsDao(this as Database);
  late final ProxyChainHopsDao proxyChainHopsDao = ProxyChainHopsDao(
    this as Database,
  );
  late final ProxyChainBindingsDao proxyChainBindingsDao =
      ProxyChainBindingsDao(this as Database);
  late final ProxyNodeAssetsDao proxyNodeAssetsDao = ProxyNodeAssetsDao(
    this as Database,
  );
  late final ProxyGroupMembersDao proxyGroupMembersDao = ProxyGroupMembersDao(
    this as Database,
  );
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    profiles,
    scripts,
    rules,
    profileRuleLinks,
    proxyGroups,
    iconRecords,
    proxyNodes,
    proxyNodeBindings,
    proxyChains,
    proxyChainHops,
    proxyChainBindings,
    proxyNodeAssets,
    proxyGroupMembers,
    idxRuleTarget,
    idxProfileSceneOrder,
    idxProfileNameOrder,
    lastAccessedUrl,
    idxProxyNodesFingerprint,
    idxProxyNodesSource,
    idxProfileProxyNodesProfileOrder,
    idxProxyChainsOrder,
    idxProxyChainHopsChainOrder,
    idxProfileProxyChainsProfileOrder,
  ];
  @override
  StreamQueryUpdateRules get streamUpdateRules => const StreamQueryUpdateRules([
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'profiles',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('profile_rule_mapping', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'rules',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('profile_rule_mapping', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'profiles',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('proxy_groups', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'profiles',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('proxy_nodes', kind: UpdateKind.update)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'profiles',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('profile_proxy_nodes', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'proxy_nodes',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('profile_proxy_nodes', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'proxy_chains',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('proxy_chain_hops', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'proxy_nodes',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('proxy_chain_hops', kind: UpdateKind.update)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'proxy_groups',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('proxy_chain_hops', kind: UpdateKind.update)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'profiles',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('proxy_chain_hops', kind: UpdateKind.update)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'profiles',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('profile_proxy_chains', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'proxy_chains',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('profile_proxy_chains', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'proxy_nodes',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('proxy_node_assets', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'proxy_groups',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('proxy_group_members', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'proxy_nodes',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('proxy_group_members', kind: UpdateKind.delete)],
    ),
  ]);
}

typedef $$ProfilesTableCreateCompanionBuilder =
    ProfilesCompanion Function({
      Value<int> id,
      required String label,
      Value<String?> currentGroupName,
      required String url,
      Value<DateTime?> lastUpdateDate,
      required OverwriteType overwriteType,
      Value<int?> scriptId,
      required int autoUpdateDurationMillis,
      Value<SubscriptionInfo?> subscriptionInfo,
      required bool autoUpdate,
      required Map<String, String> selectedMap,
      required Set<String> unfoldSet,
      Value<int?> order,
    });
typedef $$ProfilesTableUpdateCompanionBuilder =
    ProfilesCompanion Function({
      Value<int> id,
      Value<String> label,
      Value<String?> currentGroupName,
      Value<String> url,
      Value<DateTime?> lastUpdateDate,
      Value<OverwriteType> overwriteType,
      Value<int?> scriptId,
      Value<int> autoUpdateDurationMillis,
      Value<SubscriptionInfo?> subscriptionInfo,
      Value<bool> autoUpdate,
      Value<Map<String, String>> selectedMap,
      Value<Set<String>> unfoldSet,
      Value<int?> order,
    });

final class $$ProfilesTableReferences
    extends BaseReferences<_$Database, $ProfilesTable, RawProfile> {
  $$ProfilesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$ProfileRuleLinksTable, List<RawProfileRuleLink>>
  _profileRuleLinksRefsTable(_$Database db) => MultiTypedResultKey.fromTable(
    db.profileRuleLinks,
    aliasName: 'profiles__id__profile_rule_mapping__profile_id',
  );

  $$ProfileRuleLinksTableProcessedTableManager get profileRuleLinksRefs {
    final manager = $$ProfileRuleLinksTableTableManager(
      $_db,
      $_db.profileRuleLinks,
    ).filter((f) => f.profileId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _profileRuleLinksRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$ProxyGroupsTable, List<RawProxyGroup>>
  _proxyGroupsRefsTable(_$Database db) => MultiTypedResultKey.fromTable(
    db.proxyGroups,
    aliasName: 'profiles__id__proxy_groups__profile_id',
  );

  $$ProxyGroupsTableProcessedTableManager get proxyGroupsRefs {
    final manager = $$ProxyGroupsTableTableManager(
      $_db,
      $_db.proxyGroups,
    ).filter((f) => f.profileId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_proxyGroupsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$ProxyNodesTable, List<RawProxyNode>>
  _proxyNodesRefsTable(_$Database db) => MultiTypedResultKey.fromTable(
    db.proxyNodes,
    aliasName: 'profiles__id__proxy_nodes__source_profile_id',
  );

  $$ProxyNodesTableProcessedTableManager get proxyNodesRefs {
    final manager = $$ProxyNodesTableTableManager(
      $_db,
      $_db.proxyNodes,
    ).filter((f) => f.sourceProfileId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_proxyNodesRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$ProxyNodeBindingsTable, List<RawProxyNodeBinding>>
  _proxyNodeBindingsRefsTable(_$Database db) => MultiTypedResultKey.fromTable(
    db.proxyNodeBindings,
    aliasName: 'profiles__id__profile_proxy_nodes__profile_id',
  );

  $$ProxyNodeBindingsTableProcessedTableManager get proxyNodeBindingsRefs {
    final manager = $$ProxyNodeBindingsTableTableManager(
      $_db,
      $_db.proxyNodeBindings,
    ).filter((f) => f.profileId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _proxyNodeBindingsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$ProxyChainHopsTable, List<RawProxyChainHop>>
  _proxyChainHopsRefsTable(_$Database db) => MultiTypedResultKey.fromTable(
    db.proxyChainHops,
    aliasName: 'profiles__id__proxy_chain_hops__profile_id',
  );

  $$ProxyChainHopsTableProcessedTableManager get proxyChainHopsRefs {
    final manager = $$ProxyChainHopsTableTableManager(
      $_db,
      $_db.proxyChainHops,
    ).filter((f) => f.profileId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_proxyChainHopsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<
    $ProxyChainBindingsTable,
    List<RawProxyChainBinding>
  >
  _proxyChainBindingsRefsTable(_$Database db) => MultiTypedResultKey.fromTable(
    db.proxyChainBindings,
    aliasName: 'profiles__id__profile_proxy_chains__profile_id',
  );

  $$ProxyChainBindingsTableProcessedTableManager get proxyChainBindingsRefs {
    final manager = $$ProxyChainBindingsTableTableManager(
      $_db,
      $_db.proxyChainBindings,
    ).filter((f) => f.profileId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _proxyChainBindingsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$ProfilesTableFilterComposer
    extends Composer<_$Database, $ProfilesTable> {
  $$ProfilesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get label => $composableBuilder(
    column: $table.label,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get currentGroupName => $composableBuilder(
    column: $table.currentGroupName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get url => $composableBuilder(
    column: $table.url,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get lastUpdateDate => $composableBuilder(
    column: $table.lastUpdateDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<OverwriteType, OverwriteType, String>
  get overwriteType => $composableBuilder(
    column: $table.overwriteType,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<int> get scriptId => $composableBuilder(
    column: $table.scriptId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get autoUpdateDurationMillis => $composableBuilder(
    column: $table.autoUpdateDurationMillis,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<SubscriptionInfo?, SubscriptionInfo, String>
  get subscriptionInfo => $composableBuilder(
    column: $table.subscriptionInfo,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<bool> get autoUpdate => $composableBuilder(
    column: $table.autoUpdate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<
    Map<String, String>,
    Map<String, String>,
    String
  >
  get selectedMap => $composableBuilder(
    column: $table.selectedMap,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnWithTypeConverterFilters<Set<String>, Set<String>, String>
  get unfoldSet => $composableBuilder(
    column: $table.unfoldSet,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<int> get order => $composableBuilder(
    column: $table.order,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> profileRuleLinksRefs(
    Expression<bool> Function($$ProfileRuleLinksTableFilterComposer f) f,
  ) {
    final $$ProfileRuleLinksTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.profileRuleLinks,
      getReferencedColumn: (t) => t.profileId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProfileRuleLinksTableFilterComposer(
            $db: $db,
            $table: $db.profileRuleLinks,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> proxyGroupsRefs(
    Expression<bool> Function($$ProxyGroupsTableFilterComposer f) f,
  ) {
    final $$ProxyGroupsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.proxyGroups,
      getReferencedColumn: (t) => t.profileId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProxyGroupsTableFilterComposer(
            $db: $db,
            $table: $db.proxyGroups,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> proxyNodesRefs(
    Expression<bool> Function($$ProxyNodesTableFilterComposer f) f,
  ) {
    final $$ProxyNodesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.proxyNodes,
      getReferencedColumn: (t) => t.sourceProfileId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProxyNodesTableFilterComposer(
            $db: $db,
            $table: $db.proxyNodes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> proxyNodeBindingsRefs(
    Expression<bool> Function($$ProxyNodeBindingsTableFilterComposer f) f,
  ) {
    final $$ProxyNodeBindingsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.proxyNodeBindings,
      getReferencedColumn: (t) => t.profileId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProxyNodeBindingsTableFilterComposer(
            $db: $db,
            $table: $db.proxyNodeBindings,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> proxyChainHopsRefs(
    Expression<bool> Function($$ProxyChainHopsTableFilterComposer f) f,
  ) {
    final $$ProxyChainHopsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.proxyChainHops,
      getReferencedColumn: (t) => t.profileId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProxyChainHopsTableFilterComposer(
            $db: $db,
            $table: $db.proxyChainHops,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> proxyChainBindingsRefs(
    Expression<bool> Function($$ProxyChainBindingsTableFilterComposer f) f,
  ) {
    final $$ProxyChainBindingsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.proxyChainBindings,
      getReferencedColumn: (t) => t.profileId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProxyChainBindingsTableFilterComposer(
            $db: $db,
            $table: $db.proxyChainBindings,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$ProfilesTableOrderingComposer
    extends Composer<_$Database, $ProfilesTable> {
  $$ProfilesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get label => $composableBuilder(
    column: $table.label,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get currentGroupName => $composableBuilder(
    column: $table.currentGroupName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get url => $composableBuilder(
    column: $table.url,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get lastUpdateDate => $composableBuilder(
    column: $table.lastUpdateDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get overwriteType => $composableBuilder(
    column: $table.overwriteType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get scriptId => $composableBuilder(
    column: $table.scriptId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get autoUpdateDurationMillis => $composableBuilder(
    column: $table.autoUpdateDurationMillis,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get subscriptionInfo => $composableBuilder(
    column: $table.subscriptionInfo,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get autoUpdate => $composableBuilder(
    column: $table.autoUpdate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get selectedMap => $composableBuilder(
    column: $table.selectedMap,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get unfoldSet => $composableBuilder(
    column: $table.unfoldSet,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get order => $composableBuilder(
    column: $table.order,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ProfilesTableAnnotationComposer
    extends Composer<_$Database, $ProfilesTable> {
  $$ProfilesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get label =>
      $composableBuilder(column: $table.label, builder: (column) => column);

  GeneratedColumn<String> get currentGroupName => $composableBuilder(
    column: $table.currentGroupName,
    builder: (column) => column,
  );

  GeneratedColumn<String> get url =>
      $composableBuilder(column: $table.url, builder: (column) => column);

  GeneratedColumn<DateTime> get lastUpdateDate => $composableBuilder(
    column: $table.lastUpdateDate,
    builder: (column) => column,
  );

  GeneratedColumnWithTypeConverter<OverwriteType, String> get overwriteType =>
      $composableBuilder(
        column: $table.overwriteType,
        builder: (column) => column,
      );

  GeneratedColumn<int> get scriptId =>
      $composableBuilder(column: $table.scriptId, builder: (column) => column);

  GeneratedColumn<int> get autoUpdateDurationMillis => $composableBuilder(
    column: $table.autoUpdateDurationMillis,
    builder: (column) => column,
  );

  GeneratedColumnWithTypeConverter<SubscriptionInfo?, String>
  get subscriptionInfo => $composableBuilder(
    column: $table.subscriptionInfo,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get autoUpdate => $composableBuilder(
    column: $table.autoUpdate,
    builder: (column) => column,
  );

  GeneratedColumnWithTypeConverter<Map<String, String>, String>
  get selectedMap => $composableBuilder(
    column: $table.selectedMap,
    builder: (column) => column,
  );

  GeneratedColumnWithTypeConverter<Set<String>, String> get unfoldSet =>
      $composableBuilder(column: $table.unfoldSet, builder: (column) => column);

  GeneratedColumn<int> get order =>
      $composableBuilder(column: $table.order, builder: (column) => column);

  Expression<T> profileRuleLinksRefs<T extends Object>(
    Expression<T> Function($$ProfileRuleLinksTableAnnotationComposer a) f,
  ) {
    final $$ProfileRuleLinksTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.profileRuleLinks,
      getReferencedColumn: (t) => t.profileId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProfileRuleLinksTableAnnotationComposer(
            $db: $db,
            $table: $db.profileRuleLinks,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> proxyGroupsRefs<T extends Object>(
    Expression<T> Function($$ProxyGroupsTableAnnotationComposer a) f,
  ) {
    final $$ProxyGroupsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.proxyGroups,
      getReferencedColumn: (t) => t.profileId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProxyGroupsTableAnnotationComposer(
            $db: $db,
            $table: $db.proxyGroups,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> proxyNodesRefs<T extends Object>(
    Expression<T> Function($$ProxyNodesTableAnnotationComposer a) f,
  ) {
    final $$ProxyNodesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.proxyNodes,
      getReferencedColumn: (t) => t.sourceProfileId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProxyNodesTableAnnotationComposer(
            $db: $db,
            $table: $db.proxyNodes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> proxyNodeBindingsRefs<T extends Object>(
    Expression<T> Function($$ProxyNodeBindingsTableAnnotationComposer a) f,
  ) {
    final $$ProxyNodeBindingsTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.proxyNodeBindings,
          getReferencedColumn: (t) => t.profileId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$ProxyNodeBindingsTableAnnotationComposer(
                $db: $db,
                $table: $db.proxyNodeBindings,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<T> proxyChainHopsRefs<T extends Object>(
    Expression<T> Function($$ProxyChainHopsTableAnnotationComposer a) f,
  ) {
    final $$ProxyChainHopsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.proxyChainHops,
      getReferencedColumn: (t) => t.profileId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProxyChainHopsTableAnnotationComposer(
            $db: $db,
            $table: $db.proxyChainHops,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> proxyChainBindingsRefs<T extends Object>(
    Expression<T> Function($$ProxyChainBindingsTableAnnotationComposer a) f,
  ) {
    final $$ProxyChainBindingsTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.proxyChainBindings,
          getReferencedColumn: (t) => t.profileId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$ProxyChainBindingsTableAnnotationComposer(
                $db: $db,
                $table: $db.proxyChainBindings,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$ProfilesTableTableManager
    extends
        RootTableManager<
          _$Database,
          $ProfilesTable,
          RawProfile,
          $$ProfilesTableFilterComposer,
          $$ProfilesTableOrderingComposer,
          $$ProfilesTableAnnotationComposer,
          $$ProfilesTableCreateCompanionBuilder,
          $$ProfilesTableUpdateCompanionBuilder,
          (RawProfile, $$ProfilesTableReferences),
          RawProfile,
          PrefetchHooks Function({
            bool profileRuleLinksRefs,
            bool proxyGroupsRefs,
            bool proxyNodesRefs,
            bool proxyNodeBindingsRefs,
            bool proxyChainHopsRefs,
            bool proxyChainBindingsRefs,
          })
        > {
  $$ProfilesTableTableManager(_$Database db, $ProfilesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ProfilesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ProfilesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ProfilesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> label = const Value.absent(),
                Value<String?> currentGroupName = const Value.absent(),
                Value<String> url = const Value.absent(),
                Value<DateTime?> lastUpdateDate = const Value.absent(),
                Value<OverwriteType> overwriteType = const Value.absent(),
                Value<int?> scriptId = const Value.absent(),
                Value<int> autoUpdateDurationMillis = const Value.absent(),
                Value<SubscriptionInfo?> subscriptionInfo =
                    const Value.absent(),
                Value<bool> autoUpdate = const Value.absent(),
                Value<Map<String, String>> selectedMap = const Value.absent(),
                Value<Set<String>> unfoldSet = const Value.absent(),
                Value<int?> order = const Value.absent(),
              }) => ProfilesCompanion(
                id: id,
                label: label,
                currentGroupName: currentGroupName,
                url: url,
                lastUpdateDate: lastUpdateDate,
                overwriteType: overwriteType,
                scriptId: scriptId,
                autoUpdateDurationMillis: autoUpdateDurationMillis,
                subscriptionInfo: subscriptionInfo,
                autoUpdate: autoUpdate,
                selectedMap: selectedMap,
                unfoldSet: unfoldSet,
                order: order,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String label,
                Value<String?> currentGroupName = const Value.absent(),
                required String url,
                Value<DateTime?> lastUpdateDate = const Value.absent(),
                required OverwriteType overwriteType,
                Value<int?> scriptId = const Value.absent(),
                required int autoUpdateDurationMillis,
                Value<SubscriptionInfo?> subscriptionInfo =
                    const Value.absent(),
                required bool autoUpdate,
                required Map<String, String> selectedMap,
                required Set<String> unfoldSet,
                Value<int?> order = const Value.absent(),
              }) => ProfilesCompanion.insert(
                id: id,
                label: label,
                currentGroupName: currentGroupName,
                url: url,
                lastUpdateDate: lastUpdateDate,
                overwriteType: overwriteType,
                scriptId: scriptId,
                autoUpdateDurationMillis: autoUpdateDurationMillis,
                subscriptionInfo: subscriptionInfo,
                autoUpdate: autoUpdate,
                selectedMap: selectedMap,
                unfoldSet: unfoldSet,
                order: order,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$ProfilesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                profileRuleLinksRefs = false,
                proxyGroupsRefs = false,
                proxyNodesRefs = false,
                proxyNodeBindingsRefs = false,
                proxyChainHopsRefs = false,
                proxyChainBindingsRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (profileRuleLinksRefs) db.profileRuleLinks,
                    if (proxyGroupsRefs) db.proxyGroups,
                    if (proxyNodesRefs) db.proxyNodes,
                    if (proxyNodeBindingsRefs) db.proxyNodeBindings,
                    if (proxyChainHopsRefs) db.proxyChainHops,
                    if (proxyChainBindingsRefs) db.proxyChainBindings,
                  ],
                  addJoins: null,
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (profileRuleLinksRefs)
                        await $_getPrefetchedData<
                          RawProfile,
                          $ProfilesTable,
                          RawProfileRuleLink
                        >(
                          currentTable: table,
                          referencedTable: $$ProfilesTableReferences
                              ._profileRuleLinksRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$ProfilesTableReferences(
                                db,
                                table,
                                p0,
                              ).profileRuleLinksRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.profileId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (proxyGroupsRefs)
                        await $_getPrefetchedData<
                          RawProfile,
                          $ProfilesTable,
                          RawProxyGroup
                        >(
                          currentTable: table,
                          referencedTable: $$ProfilesTableReferences
                              ._proxyGroupsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$ProfilesTableReferences(
                                db,
                                table,
                                p0,
                              ).proxyGroupsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.profileId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (proxyNodesRefs)
                        await $_getPrefetchedData<
                          RawProfile,
                          $ProfilesTable,
                          RawProxyNode
                        >(
                          currentTable: table,
                          referencedTable: $$ProfilesTableReferences
                              ._proxyNodesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$ProfilesTableReferences(
                                db,
                                table,
                                p0,
                              ).proxyNodesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.sourceProfileId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (proxyNodeBindingsRefs)
                        await $_getPrefetchedData<
                          RawProfile,
                          $ProfilesTable,
                          RawProxyNodeBinding
                        >(
                          currentTable: table,
                          referencedTable: $$ProfilesTableReferences
                              ._proxyNodeBindingsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$ProfilesTableReferences(
                                db,
                                table,
                                p0,
                              ).proxyNodeBindingsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.profileId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (proxyChainHopsRefs)
                        await $_getPrefetchedData<
                          RawProfile,
                          $ProfilesTable,
                          RawProxyChainHop
                        >(
                          currentTable: table,
                          referencedTable: $$ProfilesTableReferences
                              ._proxyChainHopsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$ProfilesTableReferences(
                                db,
                                table,
                                p0,
                              ).proxyChainHopsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.profileId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (proxyChainBindingsRefs)
                        await $_getPrefetchedData<
                          RawProfile,
                          $ProfilesTable,
                          RawProxyChainBinding
                        >(
                          currentTable: table,
                          referencedTable: $$ProfilesTableReferences
                              ._proxyChainBindingsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$ProfilesTableReferences(
                                db,
                                table,
                                p0,
                              ).proxyChainBindingsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.profileId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$ProfilesTableProcessedTableManager =
    ProcessedTableManager<
      _$Database,
      $ProfilesTable,
      RawProfile,
      $$ProfilesTableFilterComposer,
      $$ProfilesTableOrderingComposer,
      $$ProfilesTableAnnotationComposer,
      $$ProfilesTableCreateCompanionBuilder,
      $$ProfilesTableUpdateCompanionBuilder,
      (RawProfile, $$ProfilesTableReferences),
      RawProfile,
      PrefetchHooks Function({
        bool profileRuleLinksRefs,
        bool proxyGroupsRefs,
        bool proxyNodesRefs,
        bool proxyNodeBindingsRefs,
        bool proxyChainHopsRefs,
        bool proxyChainBindingsRefs,
      })
    >;
typedef $$ScriptsTableCreateCompanionBuilder =
    ScriptsCompanion Function({
      Value<int> id,
      required String label,
      required DateTime lastUpdateTime,
    });
typedef $$ScriptsTableUpdateCompanionBuilder =
    ScriptsCompanion Function({
      Value<int> id,
      Value<String> label,
      Value<DateTime> lastUpdateTime,
    });

class $$ScriptsTableFilterComposer extends Composer<_$Database, $ScriptsTable> {
  $$ScriptsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get label => $composableBuilder(
    column: $table.label,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get lastUpdateTime => $composableBuilder(
    column: $table.lastUpdateTime,
    builder: (column) => ColumnFilters(column),
  );
}

class $$ScriptsTableOrderingComposer
    extends Composer<_$Database, $ScriptsTable> {
  $$ScriptsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get label => $composableBuilder(
    column: $table.label,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get lastUpdateTime => $composableBuilder(
    column: $table.lastUpdateTime,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ScriptsTableAnnotationComposer
    extends Composer<_$Database, $ScriptsTable> {
  $$ScriptsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get label =>
      $composableBuilder(column: $table.label, builder: (column) => column);

  GeneratedColumn<DateTime> get lastUpdateTime => $composableBuilder(
    column: $table.lastUpdateTime,
    builder: (column) => column,
  );
}

class $$ScriptsTableTableManager
    extends
        RootTableManager<
          _$Database,
          $ScriptsTable,
          RawScript,
          $$ScriptsTableFilterComposer,
          $$ScriptsTableOrderingComposer,
          $$ScriptsTableAnnotationComposer,
          $$ScriptsTableCreateCompanionBuilder,
          $$ScriptsTableUpdateCompanionBuilder,
          (RawScript, BaseReferences<_$Database, $ScriptsTable, RawScript>),
          RawScript,
          PrefetchHooks Function()
        > {
  $$ScriptsTableTableManager(_$Database db, $ScriptsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ScriptsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ScriptsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ScriptsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> label = const Value.absent(),
                Value<DateTime> lastUpdateTime = const Value.absent(),
              }) => ScriptsCompanion(
                id: id,
                label: label,
                lastUpdateTime: lastUpdateTime,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String label,
                required DateTime lastUpdateTime,
              }) => ScriptsCompanion.insert(
                id: id,
                label: label,
                lastUpdateTime: lastUpdateTime,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$ScriptsTableProcessedTableManager =
    ProcessedTableManager<
      _$Database,
      $ScriptsTable,
      RawScript,
      $$ScriptsTableFilterComposer,
      $$ScriptsTableOrderingComposer,
      $$ScriptsTableAnnotationComposer,
      $$ScriptsTableCreateCompanionBuilder,
      $$ScriptsTableUpdateCompanionBuilder,
      (RawScript, BaseReferences<_$Database, $ScriptsTable, RawScript>),
      RawScript,
      PrefetchHooks Function()
    >;
typedef $$RulesTableCreateCompanionBuilder =
    RulesCompanion Function({
      Value<int> id,
      required RuleAction ruleAction,
      Value<String?> content,
      Value<String?> ruleTarget,
      Value<String?> ruleProvider,
      Value<String?> subRule,
      Value<bool> noResolve,
      Value<bool> src,
    });
typedef $$RulesTableUpdateCompanionBuilder =
    RulesCompanion Function({
      Value<int> id,
      Value<RuleAction> ruleAction,
      Value<String?> content,
      Value<String?> ruleTarget,
      Value<String?> ruleProvider,
      Value<String?> subRule,
      Value<bool> noResolve,
      Value<bool> src,
    });

final class $$RulesTableReferences
    extends BaseReferences<_$Database, $RulesTable, RawRule> {
  $$RulesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$ProfileRuleLinksTable, List<RawProfileRuleLink>>
  _profileRuleLinksRefsTable(_$Database db) => MultiTypedResultKey.fromTable(
    db.profileRuleLinks,
    aliasName: 'rules__id__profile_rule_mapping__rule_id',
  );

  $$ProfileRuleLinksTableProcessedTableManager get profileRuleLinksRefs {
    final manager = $$ProfileRuleLinksTableTableManager(
      $_db,
      $_db.profileRuleLinks,
    ).filter((f) => f.ruleId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _profileRuleLinksRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$RulesTableFilterComposer extends Composer<_$Database, $RulesTable> {
  $$RulesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<RuleAction, RuleAction, String>
  get ruleAction => $composableBuilder(
    column: $table.ruleAction,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<String> get content => $composableBuilder(
    column: $table.content,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get ruleTarget => $composableBuilder(
    column: $table.ruleTarget,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get ruleProvider => $composableBuilder(
    column: $table.ruleProvider,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get subRule => $composableBuilder(
    column: $table.subRule,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get noResolve => $composableBuilder(
    column: $table.noResolve,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get src => $composableBuilder(
    column: $table.src,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> profileRuleLinksRefs(
    Expression<bool> Function($$ProfileRuleLinksTableFilterComposer f) f,
  ) {
    final $$ProfileRuleLinksTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.profileRuleLinks,
      getReferencedColumn: (t) => t.ruleId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProfileRuleLinksTableFilterComposer(
            $db: $db,
            $table: $db.profileRuleLinks,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$RulesTableOrderingComposer extends Composer<_$Database, $RulesTable> {
  $$RulesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get ruleAction => $composableBuilder(
    column: $table.ruleAction,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get content => $composableBuilder(
    column: $table.content,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get ruleTarget => $composableBuilder(
    column: $table.ruleTarget,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get ruleProvider => $composableBuilder(
    column: $table.ruleProvider,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get subRule => $composableBuilder(
    column: $table.subRule,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get noResolve => $composableBuilder(
    column: $table.noResolve,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get src => $composableBuilder(
    column: $table.src,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$RulesTableAnnotationComposer extends Composer<_$Database, $RulesTable> {
  $$RulesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumnWithTypeConverter<RuleAction, String> get ruleAction =>
      $composableBuilder(
        column: $table.ruleAction,
        builder: (column) => column,
      );

  GeneratedColumn<String> get content =>
      $composableBuilder(column: $table.content, builder: (column) => column);

  GeneratedColumn<String> get ruleTarget => $composableBuilder(
    column: $table.ruleTarget,
    builder: (column) => column,
  );

  GeneratedColumn<String> get ruleProvider => $composableBuilder(
    column: $table.ruleProvider,
    builder: (column) => column,
  );

  GeneratedColumn<String> get subRule =>
      $composableBuilder(column: $table.subRule, builder: (column) => column);

  GeneratedColumn<bool> get noResolve =>
      $composableBuilder(column: $table.noResolve, builder: (column) => column);

  GeneratedColumn<bool> get src =>
      $composableBuilder(column: $table.src, builder: (column) => column);

  Expression<T> profileRuleLinksRefs<T extends Object>(
    Expression<T> Function($$ProfileRuleLinksTableAnnotationComposer a) f,
  ) {
    final $$ProfileRuleLinksTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.profileRuleLinks,
      getReferencedColumn: (t) => t.ruleId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProfileRuleLinksTableAnnotationComposer(
            $db: $db,
            $table: $db.profileRuleLinks,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$RulesTableTableManager
    extends
        RootTableManager<
          _$Database,
          $RulesTable,
          RawRule,
          $$RulesTableFilterComposer,
          $$RulesTableOrderingComposer,
          $$RulesTableAnnotationComposer,
          $$RulesTableCreateCompanionBuilder,
          $$RulesTableUpdateCompanionBuilder,
          (RawRule, $$RulesTableReferences),
          RawRule,
          PrefetchHooks Function({bool profileRuleLinksRefs})
        > {
  $$RulesTableTableManager(_$Database db, $RulesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$RulesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$RulesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$RulesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<RuleAction> ruleAction = const Value.absent(),
                Value<String?> content = const Value.absent(),
                Value<String?> ruleTarget = const Value.absent(),
                Value<String?> ruleProvider = const Value.absent(),
                Value<String?> subRule = const Value.absent(),
                Value<bool> noResolve = const Value.absent(),
                Value<bool> src = const Value.absent(),
              }) => RulesCompanion(
                id: id,
                ruleAction: ruleAction,
                content: content,
                ruleTarget: ruleTarget,
                ruleProvider: ruleProvider,
                subRule: subRule,
                noResolve: noResolve,
                src: src,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required RuleAction ruleAction,
                Value<String?> content = const Value.absent(),
                Value<String?> ruleTarget = const Value.absent(),
                Value<String?> ruleProvider = const Value.absent(),
                Value<String?> subRule = const Value.absent(),
                Value<bool> noResolve = const Value.absent(),
                Value<bool> src = const Value.absent(),
              }) => RulesCompanion.insert(
                id: id,
                ruleAction: ruleAction,
                content: content,
                ruleTarget: ruleTarget,
                ruleProvider: ruleProvider,
                subRule: subRule,
                noResolve: noResolve,
                src: src,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) =>
                    (e.readTable(table), $$RulesTableReferences(db, table, e)),
              )
              .toList(),
          prefetchHooksCallback: ({profileRuleLinksRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (profileRuleLinksRefs) db.profileRuleLinks,
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (profileRuleLinksRefs)
                    await $_getPrefetchedData<
                      RawRule,
                      $RulesTable,
                      RawProfileRuleLink
                    >(
                      currentTable: table,
                      referencedTable: $$RulesTableReferences
                          ._profileRuleLinksRefsTable(db),
                      managerFromTypedResult: (p0) => $$RulesTableReferences(
                        db,
                        table,
                        p0,
                      ).profileRuleLinksRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where((e) => e.ruleId == item.id),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$RulesTableProcessedTableManager =
    ProcessedTableManager<
      _$Database,
      $RulesTable,
      RawRule,
      $$RulesTableFilterComposer,
      $$RulesTableOrderingComposer,
      $$RulesTableAnnotationComposer,
      $$RulesTableCreateCompanionBuilder,
      $$RulesTableUpdateCompanionBuilder,
      (RawRule, $$RulesTableReferences),
      RawRule,
      PrefetchHooks Function({bool profileRuleLinksRefs})
    >;
typedef $$ProfileRuleLinksTableCreateCompanionBuilder =
    ProfileRuleLinksCompanion Function({
      required String id,
      Value<int?> profileId,
      required int ruleId,
      Value<RuleScene?> scene,
      Value<String?> order,
      Value<int> rowid,
    });
typedef $$ProfileRuleLinksTableUpdateCompanionBuilder =
    ProfileRuleLinksCompanion Function({
      Value<String> id,
      Value<int?> profileId,
      Value<int> ruleId,
      Value<RuleScene?> scene,
      Value<String?> order,
      Value<int> rowid,
    });

final class $$ProfileRuleLinksTableReferences
    extends
        BaseReferences<_$Database, $ProfileRuleLinksTable, RawProfileRuleLink> {
  $$ProfileRuleLinksTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $ProfilesTable _profileIdTable(_$Database db) =>
      db.profiles.createAlias('profile_rule_mapping__profile_id__profiles__id');

  $$ProfilesTableProcessedTableManager? get profileId {
    final $_column = $_itemColumn<int>('profile_id');
    if ($_column == null) return null;
    final manager = $$ProfilesTableTableManager(
      $_db,
      $_db.profiles,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_profileIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $RulesTable _ruleIdTable(_$Database db) =>
      db.rules.createAlias('profile_rule_mapping__rule_id__rules__id');

  $$RulesTableProcessedTableManager get ruleId {
    final $_column = $_itemColumn<int>('rule_id')!;

    final manager = $$RulesTableTableManager(
      $_db,
      $_db.rules,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_ruleIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$ProfileRuleLinksTableFilterComposer
    extends Composer<_$Database, $ProfileRuleLinksTable> {
  $$ProfileRuleLinksTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<RuleScene?, RuleScene, String> get scene =>
      $composableBuilder(
        column: $table.scene,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  ColumnFilters<String> get order => $composableBuilder(
    column: $table.order,
    builder: (column) => ColumnFilters(column),
  );

  $$ProfilesTableFilterComposer get profileId {
    final $$ProfilesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.profileId,
      referencedTable: $db.profiles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProfilesTableFilterComposer(
            $db: $db,
            $table: $db.profiles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$RulesTableFilterComposer get ruleId {
    final $$RulesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.ruleId,
      referencedTable: $db.rules,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RulesTableFilterComposer(
            $db: $db,
            $table: $db.rules,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ProfileRuleLinksTableOrderingComposer
    extends Composer<_$Database, $ProfileRuleLinksTable> {
  $$ProfileRuleLinksTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get scene => $composableBuilder(
    column: $table.scene,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get order => $composableBuilder(
    column: $table.order,
    builder: (column) => ColumnOrderings(column),
  );

  $$ProfilesTableOrderingComposer get profileId {
    final $$ProfilesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.profileId,
      referencedTable: $db.profiles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProfilesTableOrderingComposer(
            $db: $db,
            $table: $db.profiles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$RulesTableOrderingComposer get ruleId {
    final $$RulesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.ruleId,
      referencedTable: $db.rules,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RulesTableOrderingComposer(
            $db: $db,
            $table: $db.rules,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ProfileRuleLinksTableAnnotationComposer
    extends Composer<_$Database, $ProfileRuleLinksTable> {
  $$ProfileRuleLinksTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumnWithTypeConverter<RuleScene?, String> get scene =>
      $composableBuilder(column: $table.scene, builder: (column) => column);

  GeneratedColumn<String> get order =>
      $composableBuilder(column: $table.order, builder: (column) => column);

  $$ProfilesTableAnnotationComposer get profileId {
    final $$ProfilesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.profileId,
      referencedTable: $db.profiles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProfilesTableAnnotationComposer(
            $db: $db,
            $table: $db.profiles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$RulesTableAnnotationComposer get ruleId {
    final $$RulesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.ruleId,
      referencedTable: $db.rules,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RulesTableAnnotationComposer(
            $db: $db,
            $table: $db.rules,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ProfileRuleLinksTableTableManager
    extends
        RootTableManager<
          _$Database,
          $ProfileRuleLinksTable,
          RawProfileRuleLink,
          $$ProfileRuleLinksTableFilterComposer,
          $$ProfileRuleLinksTableOrderingComposer,
          $$ProfileRuleLinksTableAnnotationComposer,
          $$ProfileRuleLinksTableCreateCompanionBuilder,
          $$ProfileRuleLinksTableUpdateCompanionBuilder,
          (RawProfileRuleLink, $$ProfileRuleLinksTableReferences),
          RawProfileRuleLink,
          PrefetchHooks Function({bool profileId, bool ruleId})
        > {
  $$ProfileRuleLinksTableTableManager(
    _$Database db,
    $ProfileRuleLinksTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ProfileRuleLinksTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ProfileRuleLinksTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ProfileRuleLinksTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<int?> profileId = const Value.absent(),
                Value<int> ruleId = const Value.absent(),
                Value<RuleScene?> scene = const Value.absent(),
                Value<String?> order = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ProfileRuleLinksCompanion(
                id: id,
                profileId: profileId,
                ruleId: ruleId,
                scene: scene,
                order: order,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                Value<int?> profileId = const Value.absent(),
                required int ruleId,
                Value<RuleScene?> scene = const Value.absent(),
                Value<String?> order = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ProfileRuleLinksCompanion.insert(
                id: id,
                profileId: profileId,
                ruleId: ruleId,
                scene: scene,
                order: order,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$ProfileRuleLinksTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({profileId = false, ruleId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (profileId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.profileId,
                                referencedTable:
                                    $$ProfileRuleLinksTableReferences
                                        ._profileIdTable(db),
                                referencedColumn:
                                    $$ProfileRuleLinksTableReferences
                                        ._profileIdTable(db)
                                        .id,
                              )
                              as T;
                    }
                    if (ruleId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.ruleId,
                                referencedTable:
                                    $$ProfileRuleLinksTableReferences
                                        ._ruleIdTable(db),
                                referencedColumn:
                                    $$ProfileRuleLinksTableReferences
                                        ._ruleIdTable(db)
                                        .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$ProfileRuleLinksTableProcessedTableManager =
    ProcessedTableManager<
      _$Database,
      $ProfileRuleLinksTable,
      RawProfileRuleLink,
      $$ProfileRuleLinksTableFilterComposer,
      $$ProfileRuleLinksTableOrderingComposer,
      $$ProfileRuleLinksTableAnnotationComposer,
      $$ProfileRuleLinksTableCreateCompanionBuilder,
      $$ProfileRuleLinksTableUpdateCompanionBuilder,
      (RawProfileRuleLink, $$ProfileRuleLinksTableReferences),
      RawProfileRuleLink,
      PrefetchHooks Function({bool profileId, bool ruleId})
    >;
typedef $$ProxyGroupsTableCreateCompanionBuilder =
    ProxyGroupsCompanion Function({
      Value<int> id,
      Value<int?> profileId,
      required String name,
      required String type,
      Value<List<String>?> proxies,
      Value<List<String>?> use,
      Value<String?> url,
      Value<int?> interval,
      Value<int?> timeout,
      Value<int?> maxFailedTimes,
      Value<bool?> lazy,
      Value<bool?> disableUDP,
      Value<String?> filter,
      Value<String?> excludeFilter,
      Value<String?> excludeType,
      Value<String?> expectedStatus,
      Value<bool?> includeAll,
      Value<bool?> includeAllProxies,
      Value<bool?> includeAllProviders,
      Value<bool?> hidden,
      Value<String?> icon,
      Value<String?> order,
    });
typedef $$ProxyGroupsTableUpdateCompanionBuilder =
    ProxyGroupsCompanion Function({
      Value<int> id,
      Value<int?> profileId,
      Value<String> name,
      Value<String> type,
      Value<List<String>?> proxies,
      Value<List<String>?> use,
      Value<String?> url,
      Value<int?> interval,
      Value<int?> timeout,
      Value<int?> maxFailedTimes,
      Value<bool?> lazy,
      Value<bool?> disableUDP,
      Value<String?> filter,
      Value<String?> excludeFilter,
      Value<String?> excludeType,
      Value<String?> expectedStatus,
      Value<bool?> includeAll,
      Value<bool?> includeAllProxies,
      Value<bool?> includeAllProviders,
      Value<bool?> hidden,
      Value<String?> icon,
      Value<String?> order,
    });

final class $$ProxyGroupsTableReferences
    extends BaseReferences<_$Database, $ProxyGroupsTable, RawProxyGroup> {
  $$ProxyGroupsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $ProfilesTable _profileIdTable(_$Database db) =>
      db.profiles.createAlias('proxy_groups__profile_id__profiles__id');

  $$ProfilesTableProcessedTableManager? get profileId {
    final $_column = $_itemColumn<int>('profile_id');
    if ($_column == null) return null;
    final manager = $$ProfilesTableTableManager(
      $_db,
      $_db.profiles,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_profileIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$ProxyChainHopsTable, List<RawProxyChainHop>>
  _proxyChainHopsRefsTable(_$Database db) => MultiTypedResultKey.fromTable(
    db.proxyChainHops,
    aliasName: 'proxy_groups__id__proxy_chain_hops__group_id',
  );

  $$ProxyChainHopsTableProcessedTableManager get proxyChainHopsRefs {
    final manager = $$ProxyChainHopsTableTableManager(
      $_db,
      $_db.proxyChainHops,
    ).filter((f) => f.groupId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_proxyChainHopsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$ProxyGroupMembersTable, List<RawProxyGroupMember>>
  _proxyGroupMembersRefsTable(_$Database db) => MultiTypedResultKey.fromTable(
    db.proxyGroupMembers,
    aliasName: 'proxy_groups__id__proxy_group_members__group_id',
  );

  $$ProxyGroupMembersTableProcessedTableManager get proxyGroupMembersRefs {
    final manager = $$ProxyGroupMembersTableTableManager(
      $_db,
      $_db.proxyGroupMembers,
    ).filter((f) => f.groupId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _proxyGroupMembersRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$ProxyGroupsTableFilterComposer
    extends Composer<_$Database, $ProxyGroupsTable> {
  $$ProxyGroupsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<List<String>?, List<String>, String>
  get proxies => $composableBuilder(
    column: $table.proxies,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnWithTypeConverterFilters<List<String>?, List<String>, String> get use =>
      $composableBuilder(
        column: $table.use,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  ColumnFilters<String> get url => $composableBuilder(
    column: $table.url,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get interval => $composableBuilder(
    column: $table.interval,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get timeout => $composableBuilder(
    column: $table.timeout,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get maxFailedTimes => $composableBuilder(
    column: $table.maxFailedTimes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get lazy => $composableBuilder(
    column: $table.lazy,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get disableUDP => $composableBuilder(
    column: $table.disableUDP,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get filter => $composableBuilder(
    column: $table.filter,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get excludeFilter => $composableBuilder(
    column: $table.excludeFilter,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get excludeType => $composableBuilder(
    column: $table.excludeType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get expectedStatus => $composableBuilder(
    column: $table.expectedStatus,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get includeAll => $composableBuilder(
    column: $table.includeAll,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get includeAllProxies => $composableBuilder(
    column: $table.includeAllProxies,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get includeAllProviders => $composableBuilder(
    column: $table.includeAllProviders,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get hidden => $composableBuilder(
    column: $table.hidden,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get icon => $composableBuilder(
    column: $table.icon,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get order => $composableBuilder(
    column: $table.order,
    builder: (column) => ColumnFilters(column),
  );

  $$ProfilesTableFilterComposer get profileId {
    final $$ProfilesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.profileId,
      referencedTable: $db.profiles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProfilesTableFilterComposer(
            $db: $db,
            $table: $db.profiles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> proxyChainHopsRefs(
    Expression<bool> Function($$ProxyChainHopsTableFilterComposer f) f,
  ) {
    final $$ProxyChainHopsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.proxyChainHops,
      getReferencedColumn: (t) => t.groupId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProxyChainHopsTableFilterComposer(
            $db: $db,
            $table: $db.proxyChainHops,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> proxyGroupMembersRefs(
    Expression<bool> Function($$ProxyGroupMembersTableFilterComposer f) f,
  ) {
    final $$ProxyGroupMembersTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.proxyGroupMembers,
      getReferencedColumn: (t) => t.groupId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProxyGroupMembersTableFilterComposer(
            $db: $db,
            $table: $db.proxyGroupMembers,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$ProxyGroupsTableOrderingComposer
    extends Composer<_$Database, $ProxyGroupsTable> {
  $$ProxyGroupsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get proxies => $composableBuilder(
    column: $table.proxies,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get use => $composableBuilder(
    column: $table.use,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get url => $composableBuilder(
    column: $table.url,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get interval => $composableBuilder(
    column: $table.interval,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get timeout => $composableBuilder(
    column: $table.timeout,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get maxFailedTimes => $composableBuilder(
    column: $table.maxFailedTimes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get lazy => $composableBuilder(
    column: $table.lazy,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get disableUDP => $composableBuilder(
    column: $table.disableUDP,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get filter => $composableBuilder(
    column: $table.filter,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get excludeFilter => $composableBuilder(
    column: $table.excludeFilter,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get excludeType => $composableBuilder(
    column: $table.excludeType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get expectedStatus => $composableBuilder(
    column: $table.expectedStatus,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get includeAll => $composableBuilder(
    column: $table.includeAll,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get includeAllProxies => $composableBuilder(
    column: $table.includeAllProxies,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get includeAllProviders => $composableBuilder(
    column: $table.includeAllProviders,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get hidden => $composableBuilder(
    column: $table.hidden,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get icon => $composableBuilder(
    column: $table.icon,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get order => $composableBuilder(
    column: $table.order,
    builder: (column) => ColumnOrderings(column),
  );

  $$ProfilesTableOrderingComposer get profileId {
    final $$ProfilesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.profileId,
      referencedTable: $db.profiles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProfilesTableOrderingComposer(
            $db: $db,
            $table: $db.profiles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ProxyGroupsTableAnnotationComposer
    extends Composer<_$Database, $ProxyGroupsTable> {
  $$ProxyGroupsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumnWithTypeConverter<List<String>?, String> get proxies =>
      $composableBuilder(column: $table.proxies, builder: (column) => column);

  GeneratedColumnWithTypeConverter<List<String>?, String> get use =>
      $composableBuilder(column: $table.use, builder: (column) => column);

  GeneratedColumn<String> get url =>
      $composableBuilder(column: $table.url, builder: (column) => column);

  GeneratedColumn<int> get interval =>
      $composableBuilder(column: $table.interval, builder: (column) => column);

  GeneratedColumn<int> get timeout =>
      $composableBuilder(column: $table.timeout, builder: (column) => column);

  GeneratedColumn<int> get maxFailedTimes => $composableBuilder(
    column: $table.maxFailedTimes,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get lazy =>
      $composableBuilder(column: $table.lazy, builder: (column) => column);

  GeneratedColumn<bool> get disableUDP => $composableBuilder(
    column: $table.disableUDP,
    builder: (column) => column,
  );

  GeneratedColumn<String> get filter =>
      $composableBuilder(column: $table.filter, builder: (column) => column);

  GeneratedColumn<String> get excludeFilter => $composableBuilder(
    column: $table.excludeFilter,
    builder: (column) => column,
  );

  GeneratedColumn<String> get excludeType => $composableBuilder(
    column: $table.excludeType,
    builder: (column) => column,
  );

  GeneratedColumn<String> get expectedStatus => $composableBuilder(
    column: $table.expectedStatus,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get includeAll => $composableBuilder(
    column: $table.includeAll,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get includeAllProxies => $composableBuilder(
    column: $table.includeAllProxies,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get includeAllProviders => $composableBuilder(
    column: $table.includeAllProviders,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get hidden =>
      $composableBuilder(column: $table.hidden, builder: (column) => column);

  GeneratedColumn<String> get icon =>
      $composableBuilder(column: $table.icon, builder: (column) => column);

  GeneratedColumn<String> get order =>
      $composableBuilder(column: $table.order, builder: (column) => column);

  $$ProfilesTableAnnotationComposer get profileId {
    final $$ProfilesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.profileId,
      referencedTable: $db.profiles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProfilesTableAnnotationComposer(
            $db: $db,
            $table: $db.profiles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> proxyChainHopsRefs<T extends Object>(
    Expression<T> Function($$ProxyChainHopsTableAnnotationComposer a) f,
  ) {
    final $$ProxyChainHopsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.proxyChainHops,
      getReferencedColumn: (t) => t.groupId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProxyChainHopsTableAnnotationComposer(
            $db: $db,
            $table: $db.proxyChainHops,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> proxyGroupMembersRefs<T extends Object>(
    Expression<T> Function($$ProxyGroupMembersTableAnnotationComposer a) f,
  ) {
    final $$ProxyGroupMembersTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.proxyGroupMembers,
          getReferencedColumn: (t) => t.groupId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$ProxyGroupMembersTableAnnotationComposer(
                $db: $db,
                $table: $db.proxyGroupMembers,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$ProxyGroupsTableTableManager
    extends
        RootTableManager<
          _$Database,
          $ProxyGroupsTable,
          RawProxyGroup,
          $$ProxyGroupsTableFilterComposer,
          $$ProxyGroupsTableOrderingComposer,
          $$ProxyGroupsTableAnnotationComposer,
          $$ProxyGroupsTableCreateCompanionBuilder,
          $$ProxyGroupsTableUpdateCompanionBuilder,
          (RawProxyGroup, $$ProxyGroupsTableReferences),
          RawProxyGroup,
          PrefetchHooks Function({
            bool profileId,
            bool proxyChainHopsRefs,
            bool proxyGroupMembersRefs,
          })
        > {
  $$ProxyGroupsTableTableManager(_$Database db, $ProxyGroupsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ProxyGroupsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ProxyGroupsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ProxyGroupsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int?> profileId = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> type = const Value.absent(),
                Value<List<String>?> proxies = const Value.absent(),
                Value<List<String>?> use = const Value.absent(),
                Value<String?> url = const Value.absent(),
                Value<int?> interval = const Value.absent(),
                Value<int?> timeout = const Value.absent(),
                Value<int?> maxFailedTimes = const Value.absent(),
                Value<bool?> lazy = const Value.absent(),
                Value<bool?> disableUDP = const Value.absent(),
                Value<String?> filter = const Value.absent(),
                Value<String?> excludeFilter = const Value.absent(),
                Value<String?> excludeType = const Value.absent(),
                Value<String?> expectedStatus = const Value.absent(),
                Value<bool?> includeAll = const Value.absent(),
                Value<bool?> includeAllProxies = const Value.absent(),
                Value<bool?> includeAllProviders = const Value.absent(),
                Value<bool?> hidden = const Value.absent(),
                Value<String?> icon = const Value.absent(),
                Value<String?> order = const Value.absent(),
              }) => ProxyGroupsCompanion(
                id: id,
                profileId: profileId,
                name: name,
                type: type,
                proxies: proxies,
                use: use,
                url: url,
                interval: interval,
                timeout: timeout,
                maxFailedTimes: maxFailedTimes,
                lazy: lazy,
                disableUDP: disableUDP,
                filter: filter,
                excludeFilter: excludeFilter,
                excludeType: excludeType,
                expectedStatus: expectedStatus,
                includeAll: includeAll,
                includeAllProxies: includeAllProxies,
                includeAllProviders: includeAllProviders,
                hidden: hidden,
                icon: icon,
                order: order,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int?> profileId = const Value.absent(),
                required String name,
                required String type,
                Value<List<String>?> proxies = const Value.absent(),
                Value<List<String>?> use = const Value.absent(),
                Value<String?> url = const Value.absent(),
                Value<int?> interval = const Value.absent(),
                Value<int?> timeout = const Value.absent(),
                Value<int?> maxFailedTimes = const Value.absent(),
                Value<bool?> lazy = const Value.absent(),
                Value<bool?> disableUDP = const Value.absent(),
                Value<String?> filter = const Value.absent(),
                Value<String?> excludeFilter = const Value.absent(),
                Value<String?> excludeType = const Value.absent(),
                Value<String?> expectedStatus = const Value.absent(),
                Value<bool?> includeAll = const Value.absent(),
                Value<bool?> includeAllProxies = const Value.absent(),
                Value<bool?> includeAllProviders = const Value.absent(),
                Value<bool?> hidden = const Value.absent(),
                Value<String?> icon = const Value.absent(),
                Value<String?> order = const Value.absent(),
              }) => ProxyGroupsCompanion.insert(
                id: id,
                profileId: profileId,
                name: name,
                type: type,
                proxies: proxies,
                use: use,
                url: url,
                interval: interval,
                timeout: timeout,
                maxFailedTimes: maxFailedTimes,
                lazy: lazy,
                disableUDP: disableUDP,
                filter: filter,
                excludeFilter: excludeFilter,
                excludeType: excludeType,
                expectedStatus: expectedStatus,
                includeAll: includeAll,
                includeAllProxies: includeAllProxies,
                includeAllProviders: includeAllProviders,
                hidden: hidden,
                icon: icon,
                order: order,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$ProxyGroupsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                profileId = false,
                proxyChainHopsRefs = false,
                proxyGroupMembersRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (proxyChainHopsRefs) db.proxyChainHops,
                    if (proxyGroupMembersRefs) db.proxyGroupMembers,
                  ],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (profileId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.profileId,
                                    referencedTable:
                                        $$ProxyGroupsTableReferences
                                            ._profileIdTable(db),
                                    referencedColumn:
                                        $$ProxyGroupsTableReferences
                                            ._profileIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (proxyChainHopsRefs)
                        await $_getPrefetchedData<
                          RawProxyGroup,
                          $ProxyGroupsTable,
                          RawProxyChainHop
                        >(
                          currentTable: table,
                          referencedTable: $$ProxyGroupsTableReferences
                              ._proxyChainHopsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$ProxyGroupsTableReferences(
                                db,
                                table,
                                p0,
                              ).proxyChainHopsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.groupId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (proxyGroupMembersRefs)
                        await $_getPrefetchedData<
                          RawProxyGroup,
                          $ProxyGroupsTable,
                          RawProxyGroupMember
                        >(
                          currentTable: table,
                          referencedTable: $$ProxyGroupsTableReferences
                              ._proxyGroupMembersRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$ProxyGroupsTableReferences(
                                db,
                                table,
                                p0,
                              ).proxyGroupMembersRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.groupId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$ProxyGroupsTableProcessedTableManager =
    ProcessedTableManager<
      _$Database,
      $ProxyGroupsTable,
      RawProxyGroup,
      $$ProxyGroupsTableFilterComposer,
      $$ProxyGroupsTableOrderingComposer,
      $$ProxyGroupsTableAnnotationComposer,
      $$ProxyGroupsTableCreateCompanionBuilder,
      $$ProxyGroupsTableUpdateCompanionBuilder,
      (RawProxyGroup, $$ProxyGroupsTableReferences),
      RawProxyGroup,
      PrefetchHooks Function({
        bool profileId,
        bool proxyChainHopsRefs,
        bool proxyGroupMembersRefs,
      })
    >;
typedef $$IconRecordsTableCreateCompanionBuilder =
    IconRecordsCompanion Function({
      required String url,
      required int lastAccessed,
      Value<int> rowid,
    });
typedef $$IconRecordsTableUpdateCompanionBuilder =
    IconRecordsCompanion Function({
      Value<String> url,
      Value<int> lastAccessed,
      Value<int> rowid,
    });

class $$IconRecordsTableFilterComposer
    extends Composer<_$Database, $IconRecordsTable> {
  $$IconRecordsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get url => $composableBuilder(
    column: $table.url,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get lastAccessed => $composableBuilder(
    column: $table.lastAccessed,
    builder: (column) => ColumnFilters(column),
  );
}

class $$IconRecordsTableOrderingComposer
    extends Composer<_$Database, $IconRecordsTable> {
  $$IconRecordsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get url => $composableBuilder(
    column: $table.url,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get lastAccessed => $composableBuilder(
    column: $table.lastAccessed,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$IconRecordsTableAnnotationComposer
    extends Composer<_$Database, $IconRecordsTable> {
  $$IconRecordsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get url =>
      $composableBuilder(column: $table.url, builder: (column) => column);

  GeneratedColumn<int> get lastAccessed => $composableBuilder(
    column: $table.lastAccessed,
    builder: (column) => column,
  );
}

class $$IconRecordsTableTableManager
    extends
        RootTableManager<
          _$Database,
          $IconRecordsTable,
          IconRecord,
          $$IconRecordsTableFilterComposer,
          $$IconRecordsTableOrderingComposer,
          $$IconRecordsTableAnnotationComposer,
          $$IconRecordsTableCreateCompanionBuilder,
          $$IconRecordsTableUpdateCompanionBuilder,
          (
            IconRecord,
            BaseReferences<_$Database, $IconRecordsTable, IconRecord>,
          ),
          IconRecord,
          PrefetchHooks Function()
        > {
  $$IconRecordsTableTableManager(_$Database db, $IconRecordsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$IconRecordsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$IconRecordsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$IconRecordsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> url = const Value.absent(),
                Value<int> lastAccessed = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => IconRecordsCompanion(
                url: url,
                lastAccessed: lastAccessed,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String url,
                required int lastAccessed,
                Value<int> rowid = const Value.absent(),
              }) => IconRecordsCompanion.insert(
                url: url,
                lastAccessed: lastAccessed,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$IconRecordsTableProcessedTableManager =
    ProcessedTableManager<
      _$Database,
      $IconRecordsTable,
      IconRecord,
      $$IconRecordsTableFilterComposer,
      $$IconRecordsTableOrderingComposer,
      $$IconRecordsTableAnnotationComposer,
      $$IconRecordsTableCreateCompanionBuilder,
      $$IconRecordsTableUpdateCompanionBuilder,
      (IconRecord, BaseReferences<_$Database, $IconRecordsTable, IconRecord>),
      IconRecord,
      PrefetchHooks Function()
    >;
typedef $$ProxyNodesTableCreateCompanionBuilder =
    ProxyNodesCompanion Function({
      Value<int> id,
      required String displayName,
      required String type,
      required Map<String, Object?> config,
      Value<Map<String, Object?>?> sourceSnapshot,
      Value<String?> sourceKind,
      Value<int?> sourceProfileId,
      Value<String?> sourceProvider,
      Value<String?> sourceKey,
      Value<Map<String, Object?>?> overlaySet,
      Value<List<String>?> overlayRemove,
      Value<Map<String, Object?>?> metadata,
      required String fingerprint,
      required String status,
      Value<DateTime?> createdAt,
      Value<DateTime?> updatedAt,
      Value<int?> order,
    });
typedef $$ProxyNodesTableUpdateCompanionBuilder =
    ProxyNodesCompanion Function({
      Value<int> id,
      Value<String> displayName,
      Value<String> type,
      Value<Map<String, Object?>> config,
      Value<Map<String, Object?>?> sourceSnapshot,
      Value<String?> sourceKind,
      Value<int?> sourceProfileId,
      Value<String?> sourceProvider,
      Value<String?> sourceKey,
      Value<Map<String, Object?>?> overlaySet,
      Value<List<String>?> overlayRemove,
      Value<Map<String, Object?>?> metadata,
      Value<String> fingerprint,
      Value<String> status,
      Value<DateTime?> createdAt,
      Value<DateTime?> updatedAt,
      Value<int?> order,
    });

final class $$ProxyNodesTableReferences
    extends BaseReferences<_$Database, $ProxyNodesTable, RawProxyNode> {
  $$ProxyNodesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $ProfilesTable _sourceProfileIdTable(_$Database db) =>
      db.profiles.createAlias('proxy_nodes__source_profile_id__profiles__id');

  $$ProfilesTableProcessedTableManager? get sourceProfileId {
    final $_column = $_itemColumn<int>('source_profile_id');
    if ($_column == null) return null;
    final manager = $$ProfilesTableTableManager(
      $_db,
      $_db.profiles,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_sourceProfileIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$ProxyNodeBindingsTable, List<RawProxyNodeBinding>>
  _proxyNodeBindingsRefsTable(_$Database db) => MultiTypedResultKey.fromTable(
    db.proxyNodeBindings,
    aliasName: 'proxy_nodes__id__profile_proxy_nodes__node_id',
  );

  $$ProxyNodeBindingsTableProcessedTableManager get proxyNodeBindingsRefs {
    final manager = $$ProxyNodeBindingsTableTableManager(
      $_db,
      $_db.proxyNodeBindings,
    ).filter((f) => f.nodeId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _proxyNodeBindingsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$ProxyChainHopsTable, List<RawProxyChainHop>>
  _proxyChainHopsRefsTable(_$Database db) => MultiTypedResultKey.fromTable(
    db.proxyChainHops,
    aliasName: 'proxy_nodes__id__proxy_chain_hops__node_id',
  );

  $$ProxyChainHopsTableProcessedTableManager get proxyChainHopsRefs {
    final manager = $$ProxyChainHopsTableTableManager(
      $_db,
      $_db.proxyChainHops,
    ).filter((f) => f.nodeId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_proxyChainHopsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$ProxyNodeAssetsTable, List<RawProxyNodeAsset>>
  _proxyNodeAssetsRefsTable(_$Database db) => MultiTypedResultKey.fromTable(
    db.proxyNodeAssets,
    aliasName: 'proxy_nodes__id__proxy_node_assets__node_id',
  );

  $$ProxyNodeAssetsTableProcessedTableManager get proxyNodeAssetsRefs {
    final manager = $$ProxyNodeAssetsTableTableManager(
      $_db,
      $_db.proxyNodeAssets,
    ).filter((f) => f.nodeId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _proxyNodeAssetsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$ProxyGroupMembersTable, List<RawProxyGroupMember>>
  _proxyGroupMembersRefsTable(_$Database db) => MultiTypedResultKey.fromTable(
    db.proxyGroupMembers,
    aliasName: 'proxy_nodes__id__proxy_group_members__node_id',
  );

  $$ProxyGroupMembersTableProcessedTableManager get proxyGroupMembersRefs {
    final manager = $$ProxyGroupMembersTableTableManager(
      $_db,
      $_db.proxyGroupMembers,
    ).filter((f) => f.nodeId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _proxyGroupMembersRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$ProxyNodesTableFilterComposer
    extends Composer<_$Database, $ProxyNodesTable> {
  $$ProxyNodesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get displayName => $composableBuilder(
    column: $table.displayName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<
    Map<String, Object?>,
    Map<String, Object>,
    String
  >
  get config => $composableBuilder(
    column: $table.config,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnWithTypeConverterFilters<
    Map<String, Object?>?,
    Map<String, Object>?,
    String
  >
  get sourceSnapshot => $composableBuilder(
    column: $table.sourceSnapshot,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<String> get sourceKind => $composableBuilder(
    column: $table.sourceKind,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get sourceProvider => $composableBuilder(
    column: $table.sourceProvider,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get sourceKey => $composableBuilder(
    column: $table.sourceKey,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<
    Map<String, Object?>?,
    Map<String, Object>?,
    String
  >
  get overlaySet => $composableBuilder(
    column: $table.overlaySet,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnWithTypeConverterFilters<List<String>?, List<String>, String>
  get overlayRemove => $composableBuilder(
    column: $table.overlayRemove,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnWithTypeConverterFilters<
    Map<String, Object?>?,
    Map<String, Object>?,
    String
  >
  get metadata => $composableBuilder(
    column: $table.metadata,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<String> get fingerprint => $composableBuilder(
    column: $table.fingerprint,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get order => $composableBuilder(
    column: $table.order,
    builder: (column) => ColumnFilters(column),
  );

  $$ProfilesTableFilterComposer get sourceProfileId {
    final $$ProfilesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.sourceProfileId,
      referencedTable: $db.profiles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProfilesTableFilterComposer(
            $db: $db,
            $table: $db.profiles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> proxyNodeBindingsRefs(
    Expression<bool> Function($$ProxyNodeBindingsTableFilterComposer f) f,
  ) {
    final $$ProxyNodeBindingsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.proxyNodeBindings,
      getReferencedColumn: (t) => t.nodeId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProxyNodeBindingsTableFilterComposer(
            $db: $db,
            $table: $db.proxyNodeBindings,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> proxyChainHopsRefs(
    Expression<bool> Function($$ProxyChainHopsTableFilterComposer f) f,
  ) {
    final $$ProxyChainHopsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.proxyChainHops,
      getReferencedColumn: (t) => t.nodeId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProxyChainHopsTableFilterComposer(
            $db: $db,
            $table: $db.proxyChainHops,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> proxyNodeAssetsRefs(
    Expression<bool> Function($$ProxyNodeAssetsTableFilterComposer f) f,
  ) {
    final $$ProxyNodeAssetsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.proxyNodeAssets,
      getReferencedColumn: (t) => t.nodeId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProxyNodeAssetsTableFilterComposer(
            $db: $db,
            $table: $db.proxyNodeAssets,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> proxyGroupMembersRefs(
    Expression<bool> Function($$ProxyGroupMembersTableFilterComposer f) f,
  ) {
    final $$ProxyGroupMembersTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.proxyGroupMembers,
      getReferencedColumn: (t) => t.nodeId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProxyGroupMembersTableFilterComposer(
            $db: $db,
            $table: $db.proxyGroupMembers,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$ProxyNodesTableOrderingComposer
    extends Composer<_$Database, $ProxyNodesTable> {
  $$ProxyNodesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get displayName => $composableBuilder(
    column: $table.displayName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get config => $composableBuilder(
    column: $table.config,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get sourceSnapshot => $composableBuilder(
    column: $table.sourceSnapshot,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get sourceKind => $composableBuilder(
    column: $table.sourceKind,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get sourceProvider => $composableBuilder(
    column: $table.sourceProvider,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get sourceKey => $composableBuilder(
    column: $table.sourceKey,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get overlaySet => $composableBuilder(
    column: $table.overlaySet,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get overlayRemove => $composableBuilder(
    column: $table.overlayRemove,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get metadata => $composableBuilder(
    column: $table.metadata,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get fingerprint => $composableBuilder(
    column: $table.fingerprint,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get order => $composableBuilder(
    column: $table.order,
    builder: (column) => ColumnOrderings(column),
  );

  $$ProfilesTableOrderingComposer get sourceProfileId {
    final $$ProfilesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.sourceProfileId,
      referencedTable: $db.profiles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProfilesTableOrderingComposer(
            $db: $db,
            $table: $db.profiles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ProxyNodesTableAnnotationComposer
    extends Composer<_$Database, $ProxyNodesTable> {
  $$ProxyNodesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get displayName => $composableBuilder(
    column: $table.displayName,
    builder: (column) => column,
  );

  GeneratedColumn<String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumnWithTypeConverter<Map<String, Object?>, String> get config =>
      $composableBuilder(column: $table.config, builder: (column) => column);

  GeneratedColumnWithTypeConverter<Map<String, Object?>?, String>
  get sourceSnapshot => $composableBuilder(
    column: $table.sourceSnapshot,
    builder: (column) => column,
  );

  GeneratedColumn<String> get sourceKind => $composableBuilder(
    column: $table.sourceKind,
    builder: (column) => column,
  );

  GeneratedColumn<String> get sourceProvider => $composableBuilder(
    column: $table.sourceProvider,
    builder: (column) => column,
  );

  GeneratedColumn<String> get sourceKey =>
      $composableBuilder(column: $table.sourceKey, builder: (column) => column);

  GeneratedColumnWithTypeConverter<Map<String, Object?>?, String>
  get overlaySet => $composableBuilder(
    column: $table.overlaySet,
    builder: (column) => column,
  );

  GeneratedColumnWithTypeConverter<List<String>?, String> get overlayRemove =>
      $composableBuilder(
        column: $table.overlayRemove,
        builder: (column) => column,
      );

  GeneratedColumnWithTypeConverter<Map<String, Object?>?, String>
  get metadata =>
      $composableBuilder(column: $table.metadata, builder: (column) => column);

  GeneratedColumn<String> get fingerprint => $composableBuilder(
    column: $table.fingerprint,
    builder: (column) => column,
  );

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<int> get order =>
      $composableBuilder(column: $table.order, builder: (column) => column);

  $$ProfilesTableAnnotationComposer get sourceProfileId {
    final $$ProfilesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.sourceProfileId,
      referencedTable: $db.profiles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProfilesTableAnnotationComposer(
            $db: $db,
            $table: $db.profiles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> proxyNodeBindingsRefs<T extends Object>(
    Expression<T> Function($$ProxyNodeBindingsTableAnnotationComposer a) f,
  ) {
    final $$ProxyNodeBindingsTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.proxyNodeBindings,
          getReferencedColumn: (t) => t.nodeId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$ProxyNodeBindingsTableAnnotationComposer(
                $db: $db,
                $table: $db.proxyNodeBindings,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<T> proxyChainHopsRefs<T extends Object>(
    Expression<T> Function($$ProxyChainHopsTableAnnotationComposer a) f,
  ) {
    final $$ProxyChainHopsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.proxyChainHops,
      getReferencedColumn: (t) => t.nodeId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProxyChainHopsTableAnnotationComposer(
            $db: $db,
            $table: $db.proxyChainHops,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> proxyNodeAssetsRefs<T extends Object>(
    Expression<T> Function($$ProxyNodeAssetsTableAnnotationComposer a) f,
  ) {
    final $$ProxyNodeAssetsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.proxyNodeAssets,
      getReferencedColumn: (t) => t.nodeId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProxyNodeAssetsTableAnnotationComposer(
            $db: $db,
            $table: $db.proxyNodeAssets,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> proxyGroupMembersRefs<T extends Object>(
    Expression<T> Function($$ProxyGroupMembersTableAnnotationComposer a) f,
  ) {
    final $$ProxyGroupMembersTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.proxyGroupMembers,
          getReferencedColumn: (t) => t.nodeId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$ProxyGroupMembersTableAnnotationComposer(
                $db: $db,
                $table: $db.proxyGroupMembers,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$ProxyNodesTableTableManager
    extends
        RootTableManager<
          _$Database,
          $ProxyNodesTable,
          RawProxyNode,
          $$ProxyNodesTableFilterComposer,
          $$ProxyNodesTableOrderingComposer,
          $$ProxyNodesTableAnnotationComposer,
          $$ProxyNodesTableCreateCompanionBuilder,
          $$ProxyNodesTableUpdateCompanionBuilder,
          (RawProxyNode, $$ProxyNodesTableReferences),
          RawProxyNode,
          PrefetchHooks Function({
            bool sourceProfileId,
            bool proxyNodeBindingsRefs,
            bool proxyChainHopsRefs,
            bool proxyNodeAssetsRefs,
            bool proxyGroupMembersRefs,
          })
        > {
  $$ProxyNodesTableTableManager(_$Database db, $ProxyNodesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ProxyNodesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ProxyNodesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ProxyNodesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> displayName = const Value.absent(),
                Value<String> type = const Value.absent(),
                Value<Map<String, Object?>> config = const Value.absent(),
                Value<Map<String, Object?>?> sourceSnapshot =
                    const Value.absent(),
                Value<String?> sourceKind = const Value.absent(),
                Value<int?> sourceProfileId = const Value.absent(),
                Value<String?> sourceProvider = const Value.absent(),
                Value<String?> sourceKey = const Value.absent(),
                Value<Map<String, Object?>?> overlaySet = const Value.absent(),
                Value<List<String>?> overlayRemove = const Value.absent(),
                Value<Map<String, Object?>?> metadata = const Value.absent(),
                Value<String> fingerprint = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<DateTime?> createdAt = const Value.absent(),
                Value<DateTime?> updatedAt = const Value.absent(),
                Value<int?> order = const Value.absent(),
              }) => ProxyNodesCompanion(
                id: id,
                displayName: displayName,
                type: type,
                config: config,
                sourceSnapshot: sourceSnapshot,
                sourceKind: sourceKind,
                sourceProfileId: sourceProfileId,
                sourceProvider: sourceProvider,
                sourceKey: sourceKey,
                overlaySet: overlaySet,
                overlayRemove: overlayRemove,
                metadata: metadata,
                fingerprint: fingerprint,
                status: status,
                createdAt: createdAt,
                updatedAt: updatedAt,
                order: order,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String displayName,
                required String type,
                required Map<String, Object?> config,
                Value<Map<String, Object?>?> sourceSnapshot =
                    const Value.absent(),
                Value<String?> sourceKind = const Value.absent(),
                Value<int?> sourceProfileId = const Value.absent(),
                Value<String?> sourceProvider = const Value.absent(),
                Value<String?> sourceKey = const Value.absent(),
                Value<Map<String, Object?>?> overlaySet = const Value.absent(),
                Value<List<String>?> overlayRemove = const Value.absent(),
                Value<Map<String, Object?>?> metadata = const Value.absent(),
                required String fingerprint,
                required String status,
                Value<DateTime?> createdAt = const Value.absent(),
                Value<DateTime?> updatedAt = const Value.absent(),
                Value<int?> order = const Value.absent(),
              }) => ProxyNodesCompanion.insert(
                id: id,
                displayName: displayName,
                type: type,
                config: config,
                sourceSnapshot: sourceSnapshot,
                sourceKind: sourceKind,
                sourceProfileId: sourceProfileId,
                sourceProvider: sourceProvider,
                sourceKey: sourceKey,
                overlaySet: overlaySet,
                overlayRemove: overlayRemove,
                metadata: metadata,
                fingerprint: fingerprint,
                status: status,
                createdAt: createdAt,
                updatedAt: updatedAt,
                order: order,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$ProxyNodesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                sourceProfileId = false,
                proxyNodeBindingsRefs = false,
                proxyChainHopsRefs = false,
                proxyNodeAssetsRefs = false,
                proxyGroupMembersRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (proxyNodeBindingsRefs) db.proxyNodeBindings,
                    if (proxyChainHopsRefs) db.proxyChainHops,
                    if (proxyNodeAssetsRefs) db.proxyNodeAssets,
                    if (proxyGroupMembersRefs) db.proxyGroupMembers,
                  ],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (sourceProfileId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.sourceProfileId,
                                    referencedTable: $$ProxyNodesTableReferences
                                        ._sourceProfileIdTable(db),
                                    referencedColumn:
                                        $$ProxyNodesTableReferences
                                            ._sourceProfileIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (proxyNodeBindingsRefs)
                        await $_getPrefetchedData<
                          RawProxyNode,
                          $ProxyNodesTable,
                          RawProxyNodeBinding
                        >(
                          currentTable: table,
                          referencedTable: $$ProxyNodesTableReferences
                              ._proxyNodeBindingsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$ProxyNodesTableReferences(
                                db,
                                table,
                                p0,
                              ).proxyNodeBindingsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.nodeId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (proxyChainHopsRefs)
                        await $_getPrefetchedData<
                          RawProxyNode,
                          $ProxyNodesTable,
                          RawProxyChainHop
                        >(
                          currentTable: table,
                          referencedTable: $$ProxyNodesTableReferences
                              ._proxyChainHopsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$ProxyNodesTableReferences(
                                db,
                                table,
                                p0,
                              ).proxyChainHopsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.nodeId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (proxyNodeAssetsRefs)
                        await $_getPrefetchedData<
                          RawProxyNode,
                          $ProxyNodesTable,
                          RawProxyNodeAsset
                        >(
                          currentTable: table,
                          referencedTable: $$ProxyNodesTableReferences
                              ._proxyNodeAssetsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$ProxyNodesTableReferences(
                                db,
                                table,
                                p0,
                              ).proxyNodeAssetsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.nodeId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (proxyGroupMembersRefs)
                        await $_getPrefetchedData<
                          RawProxyNode,
                          $ProxyNodesTable,
                          RawProxyGroupMember
                        >(
                          currentTable: table,
                          referencedTable: $$ProxyNodesTableReferences
                              ._proxyGroupMembersRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$ProxyNodesTableReferences(
                                db,
                                table,
                                p0,
                              ).proxyGroupMembersRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.nodeId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$ProxyNodesTableProcessedTableManager =
    ProcessedTableManager<
      _$Database,
      $ProxyNodesTable,
      RawProxyNode,
      $$ProxyNodesTableFilterComposer,
      $$ProxyNodesTableOrderingComposer,
      $$ProxyNodesTableAnnotationComposer,
      $$ProxyNodesTableCreateCompanionBuilder,
      $$ProxyNodesTableUpdateCompanionBuilder,
      (RawProxyNode, $$ProxyNodesTableReferences),
      RawProxyNode,
      PrefetchHooks Function({
        bool sourceProfileId,
        bool proxyNodeBindingsRefs,
        bool proxyChainHopsRefs,
        bool proxyNodeAssetsRefs,
        bool proxyGroupMembersRefs,
      })
    >;
typedef $$ProxyNodeBindingsTableCreateCompanionBuilder =
    ProxyNodeBindingsCompanion Function({
      required int profileId,
      required int nodeId,
      Value<String?> alias,
      Value<bool> enabled,
      Value<int?> order,
      Value<int> rowid,
    });
typedef $$ProxyNodeBindingsTableUpdateCompanionBuilder =
    ProxyNodeBindingsCompanion Function({
      Value<int> profileId,
      Value<int> nodeId,
      Value<String?> alias,
      Value<bool> enabled,
      Value<int?> order,
      Value<int> rowid,
    });

final class $$ProxyNodeBindingsTableReferences
    extends
        BaseReferences<
          _$Database,
          $ProxyNodeBindingsTable,
          RawProxyNodeBinding
        > {
  $$ProxyNodeBindingsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $ProfilesTable _profileIdTable(_$Database db) =>
      db.profiles.createAlias('profile_proxy_nodes__profile_id__profiles__id');

  $$ProfilesTableProcessedTableManager get profileId {
    final $_column = $_itemColumn<int>('profile_id')!;

    final manager = $$ProfilesTableTableManager(
      $_db,
      $_db.profiles,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_profileIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $ProxyNodesTable _nodeIdTable(_$Database db) => db.proxyNodes
      .createAlias('profile_proxy_nodes__node_id__proxy_nodes__id');

  $$ProxyNodesTableProcessedTableManager get nodeId {
    final $_column = $_itemColumn<int>('node_id')!;

    final manager = $$ProxyNodesTableTableManager(
      $_db,
      $_db.proxyNodes,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_nodeIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$ProxyNodeBindingsTableFilterComposer
    extends Composer<_$Database, $ProxyNodeBindingsTable> {
  $$ProxyNodeBindingsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get alias => $composableBuilder(
    column: $table.alias,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get enabled => $composableBuilder(
    column: $table.enabled,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get order => $composableBuilder(
    column: $table.order,
    builder: (column) => ColumnFilters(column),
  );

  $$ProfilesTableFilterComposer get profileId {
    final $$ProfilesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.profileId,
      referencedTable: $db.profiles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProfilesTableFilterComposer(
            $db: $db,
            $table: $db.profiles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ProxyNodesTableFilterComposer get nodeId {
    final $$ProxyNodesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.nodeId,
      referencedTable: $db.proxyNodes,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProxyNodesTableFilterComposer(
            $db: $db,
            $table: $db.proxyNodes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ProxyNodeBindingsTableOrderingComposer
    extends Composer<_$Database, $ProxyNodeBindingsTable> {
  $$ProxyNodeBindingsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get alias => $composableBuilder(
    column: $table.alias,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get enabled => $composableBuilder(
    column: $table.enabled,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get order => $composableBuilder(
    column: $table.order,
    builder: (column) => ColumnOrderings(column),
  );

  $$ProfilesTableOrderingComposer get profileId {
    final $$ProfilesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.profileId,
      referencedTable: $db.profiles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProfilesTableOrderingComposer(
            $db: $db,
            $table: $db.profiles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ProxyNodesTableOrderingComposer get nodeId {
    final $$ProxyNodesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.nodeId,
      referencedTable: $db.proxyNodes,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProxyNodesTableOrderingComposer(
            $db: $db,
            $table: $db.proxyNodes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ProxyNodeBindingsTableAnnotationComposer
    extends Composer<_$Database, $ProxyNodeBindingsTable> {
  $$ProxyNodeBindingsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get alias =>
      $composableBuilder(column: $table.alias, builder: (column) => column);

  GeneratedColumn<bool> get enabled =>
      $composableBuilder(column: $table.enabled, builder: (column) => column);

  GeneratedColumn<int> get order =>
      $composableBuilder(column: $table.order, builder: (column) => column);

  $$ProfilesTableAnnotationComposer get profileId {
    final $$ProfilesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.profileId,
      referencedTable: $db.profiles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProfilesTableAnnotationComposer(
            $db: $db,
            $table: $db.profiles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ProxyNodesTableAnnotationComposer get nodeId {
    final $$ProxyNodesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.nodeId,
      referencedTable: $db.proxyNodes,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProxyNodesTableAnnotationComposer(
            $db: $db,
            $table: $db.proxyNodes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ProxyNodeBindingsTableTableManager
    extends
        RootTableManager<
          _$Database,
          $ProxyNodeBindingsTable,
          RawProxyNodeBinding,
          $$ProxyNodeBindingsTableFilterComposer,
          $$ProxyNodeBindingsTableOrderingComposer,
          $$ProxyNodeBindingsTableAnnotationComposer,
          $$ProxyNodeBindingsTableCreateCompanionBuilder,
          $$ProxyNodeBindingsTableUpdateCompanionBuilder,
          (RawProxyNodeBinding, $$ProxyNodeBindingsTableReferences),
          RawProxyNodeBinding,
          PrefetchHooks Function({bool profileId, bool nodeId})
        > {
  $$ProxyNodeBindingsTableTableManager(
    _$Database db,
    $ProxyNodeBindingsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ProxyNodeBindingsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ProxyNodeBindingsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ProxyNodeBindingsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> profileId = const Value.absent(),
                Value<int> nodeId = const Value.absent(),
                Value<String?> alias = const Value.absent(),
                Value<bool> enabled = const Value.absent(),
                Value<int?> order = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ProxyNodeBindingsCompanion(
                profileId: profileId,
                nodeId: nodeId,
                alias: alias,
                enabled: enabled,
                order: order,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required int profileId,
                required int nodeId,
                Value<String?> alias = const Value.absent(),
                Value<bool> enabled = const Value.absent(),
                Value<int?> order = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ProxyNodeBindingsCompanion.insert(
                profileId: profileId,
                nodeId: nodeId,
                alias: alias,
                enabled: enabled,
                order: order,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$ProxyNodeBindingsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({profileId = false, nodeId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (profileId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.profileId,
                                referencedTable:
                                    $$ProxyNodeBindingsTableReferences
                                        ._profileIdTable(db),
                                referencedColumn:
                                    $$ProxyNodeBindingsTableReferences
                                        ._profileIdTable(db)
                                        .id,
                              )
                              as T;
                    }
                    if (nodeId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.nodeId,
                                referencedTable:
                                    $$ProxyNodeBindingsTableReferences
                                        ._nodeIdTable(db),
                                referencedColumn:
                                    $$ProxyNodeBindingsTableReferences
                                        ._nodeIdTable(db)
                                        .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$ProxyNodeBindingsTableProcessedTableManager =
    ProcessedTableManager<
      _$Database,
      $ProxyNodeBindingsTable,
      RawProxyNodeBinding,
      $$ProxyNodeBindingsTableFilterComposer,
      $$ProxyNodeBindingsTableOrderingComposer,
      $$ProxyNodeBindingsTableAnnotationComposer,
      $$ProxyNodeBindingsTableCreateCompanionBuilder,
      $$ProxyNodeBindingsTableUpdateCompanionBuilder,
      (RawProxyNodeBinding, $$ProxyNodeBindingsTableReferences),
      RawProxyNodeBinding,
      PrefetchHooks Function({bool profileId, bool nodeId})
    >;
typedef $$ProxyChainsTableCreateCompanionBuilder =
    ProxyChainsCompanion Function({
      Value<int> id,
      required String name,
      Value<String?> description,
      Value<int> branchLimit,
      Value<int?> order,
    });
typedef $$ProxyChainsTableUpdateCompanionBuilder =
    ProxyChainsCompanion Function({
      Value<int> id,
      Value<String> name,
      Value<String?> description,
      Value<int> branchLimit,
      Value<int?> order,
    });

final class $$ProxyChainsTableReferences
    extends BaseReferences<_$Database, $ProxyChainsTable, RawProxyChain> {
  $$ProxyChainsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$ProxyChainHopsTable, List<RawProxyChainHop>>
  _proxyChainHopsRefsTable(_$Database db) => MultiTypedResultKey.fromTable(
    db.proxyChainHops,
    aliasName: 'proxy_chains__id__proxy_chain_hops__chain_id',
  );

  $$ProxyChainHopsTableProcessedTableManager get proxyChainHopsRefs {
    final manager = $$ProxyChainHopsTableTableManager(
      $_db,
      $_db.proxyChainHops,
    ).filter((f) => f.chainId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_proxyChainHopsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<
    $ProxyChainBindingsTable,
    List<RawProxyChainBinding>
  >
  _proxyChainBindingsRefsTable(_$Database db) => MultiTypedResultKey.fromTable(
    db.proxyChainBindings,
    aliasName: 'proxy_chains__id__profile_proxy_chains__chain_id',
  );

  $$ProxyChainBindingsTableProcessedTableManager get proxyChainBindingsRefs {
    final manager = $$ProxyChainBindingsTableTableManager(
      $_db,
      $_db.proxyChainBindings,
    ).filter((f) => f.chainId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _proxyChainBindingsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$ProxyChainsTableFilterComposer
    extends Composer<_$Database, $ProxyChainsTable> {
  $$ProxyChainsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get branchLimit => $composableBuilder(
    column: $table.branchLimit,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get order => $composableBuilder(
    column: $table.order,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> proxyChainHopsRefs(
    Expression<bool> Function($$ProxyChainHopsTableFilterComposer f) f,
  ) {
    final $$ProxyChainHopsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.proxyChainHops,
      getReferencedColumn: (t) => t.chainId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProxyChainHopsTableFilterComposer(
            $db: $db,
            $table: $db.proxyChainHops,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> proxyChainBindingsRefs(
    Expression<bool> Function($$ProxyChainBindingsTableFilterComposer f) f,
  ) {
    final $$ProxyChainBindingsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.proxyChainBindings,
      getReferencedColumn: (t) => t.chainId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProxyChainBindingsTableFilterComposer(
            $db: $db,
            $table: $db.proxyChainBindings,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$ProxyChainsTableOrderingComposer
    extends Composer<_$Database, $ProxyChainsTable> {
  $$ProxyChainsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get branchLimit => $composableBuilder(
    column: $table.branchLimit,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get order => $composableBuilder(
    column: $table.order,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ProxyChainsTableAnnotationComposer
    extends Composer<_$Database, $ProxyChainsTable> {
  $$ProxyChainsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<int> get branchLimit => $composableBuilder(
    column: $table.branchLimit,
    builder: (column) => column,
  );

  GeneratedColumn<int> get order =>
      $composableBuilder(column: $table.order, builder: (column) => column);

  Expression<T> proxyChainHopsRefs<T extends Object>(
    Expression<T> Function($$ProxyChainHopsTableAnnotationComposer a) f,
  ) {
    final $$ProxyChainHopsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.proxyChainHops,
      getReferencedColumn: (t) => t.chainId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProxyChainHopsTableAnnotationComposer(
            $db: $db,
            $table: $db.proxyChainHops,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> proxyChainBindingsRefs<T extends Object>(
    Expression<T> Function($$ProxyChainBindingsTableAnnotationComposer a) f,
  ) {
    final $$ProxyChainBindingsTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.proxyChainBindings,
          getReferencedColumn: (t) => t.chainId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$ProxyChainBindingsTableAnnotationComposer(
                $db: $db,
                $table: $db.proxyChainBindings,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$ProxyChainsTableTableManager
    extends
        RootTableManager<
          _$Database,
          $ProxyChainsTable,
          RawProxyChain,
          $$ProxyChainsTableFilterComposer,
          $$ProxyChainsTableOrderingComposer,
          $$ProxyChainsTableAnnotationComposer,
          $$ProxyChainsTableCreateCompanionBuilder,
          $$ProxyChainsTableUpdateCompanionBuilder,
          (RawProxyChain, $$ProxyChainsTableReferences),
          RawProxyChain,
          PrefetchHooks Function({
            bool proxyChainHopsRefs,
            bool proxyChainBindingsRefs,
          })
        > {
  $$ProxyChainsTableTableManager(_$Database db, $ProxyChainsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ProxyChainsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ProxyChainsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ProxyChainsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String?> description = const Value.absent(),
                Value<int> branchLimit = const Value.absent(),
                Value<int?> order = const Value.absent(),
              }) => ProxyChainsCompanion(
                id: id,
                name: name,
                description: description,
                branchLimit: branchLimit,
                order: order,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String name,
                Value<String?> description = const Value.absent(),
                Value<int> branchLimit = const Value.absent(),
                Value<int?> order = const Value.absent(),
              }) => ProxyChainsCompanion.insert(
                id: id,
                name: name,
                description: description,
                branchLimit: branchLimit,
                order: order,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$ProxyChainsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({proxyChainHopsRefs = false, proxyChainBindingsRefs = false}) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (proxyChainHopsRefs) db.proxyChainHops,
                    if (proxyChainBindingsRefs) db.proxyChainBindings,
                  ],
                  addJoins: null,
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (proxyChainHopsRefs)
                        await $_getPrefetchedData<
                          RawProxyChain,
                          $ProxyChainsTable,
                          RawProxyChainHop
                        >(
                          currentTable: table,
                          referencedTable: $$ProxyChainsTableReferences
                              ._proxyChainHopsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$ProxyChainsTableReferences(
                                db,
                                table,
                                p0,
                              ).proxyChainHopsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.chainId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (proxyChainBindingsRefs)
                        await $_getPrefetchedData<
                          RawProxyChain,
                          $ProxyChainsTable,
                          RawProxyChainBinding
                        >(
                          currentTable: table,
                          referencedTable: $$ProxyChainsTableReferences
                              ._proxyChainBindingsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$ProxyChainsTableReferences(
                                db,
                                table,
                                p0,
                              ).proxyChainBindingsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.chainId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$ProxyChainsTableProcessedTableManager =
    ProcessedTableManager<
      _$Database,
      $ProxyChainsTable,
      RawProxyChain,
      $$ProxyChainsTableFilterComposer,
      $$ProxyChainsTableOrderingComposer,
      $$ProxyChainsTableAnnotationComposer,
      $$ProxyChainsTableCreateCompanionBuilder,
      $$ProxyChainsTableUpdateCompanionBuilder,
      (RawProxyChain, $$ProxyChainsTableReferences),
      RawProxyChain,
      PrefetchHooks Function({
        bool proxyChainHopsRefs,
        bool proxyChainBindingsRefs,
      })
    >;
typedef $$ProxyChainHopsTableCreateCompanionBuilder =
    ProxyChainHopsCompanion Function({
      Value<int> id,
      required int chainId,
      required int order,
      required String targetKind,
      Value<int?> nodeId,
      Value<int?> groupId,
      Value<int?> profileId,
      Value<String?> groupName,
      Value<Map<String, Object?>?> localEndpoint,
    });
typedef $$ProxyChainHopsTableUpdateCompanionBuilder =
    ProxyChainHopsCompanion Function({
      Value<int> id,
      Value<int> chainId,
      Value<int> order,
      Value<String> targetKind,
      Value<int?> nodeId,
      Value<int?> groupId,
      Value<int?> profileId,
      Value<String?> groupName,
      Value<Map<String, Object?>?> localEndpoint,
    });

final class $$ProxyChainHopsTableReferences
    extends BaseReferences<_$Database, $ProxyChainHopsTable, RawProxyChainHop> {
  $$ProxyChainHopsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $ProxyChainsTable _chainIdTable(_$Database db) => db.proxyChains
      .createAlias('proxy_chain_hops__chain_id__proxy_chains__id');

  $$ProxyChainsTableProcessedTableManager get chainId {
    final $_column = $_itemColumn<int>('chain_id')!;

    final manager = $$ProxyChainsTableTableManager(
      $_db,
      $_db.proxyChains,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_chainIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $ProxyNodesTable _nodeIdTable(_$Database db) =>
      db.proxyNodes.createAlias('proxy_chain_hops__node_id__proxy_nodes__id');

  $$ProxyNodesTableProcessedTableManager? get nodeId {
    final $_column = $_itemColumn<int>('node_id');
    if ($_column == null) return null;
    final manager = $$ProxyNodesTableTableManager(
      $_db,
      $_db.proxyNodes,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_nodeIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $ProxyGroupsTable _groupIdTable(_$Database db) => db.proxyGroups
      .createAlias('proxy_chain_hops__group_id__proxy_groups__id');

  $$ProxyGroupsTableProcessedTableManager? get groupId {
    final $_column = $_itemColumn<int>('group_id');
    if ($_column == null) return null;
    final manager = $$ProxyGroupsTableTableManager(
      $_db,
      $_db.proxyGroups,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_groupIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $ProfilesTable _profileIdTable(_$Database db) =>
      db.profiles.createAlias('proxy_chain_hops__profile_id__profiles__id');

  $$ProfilesTableProcessedTableManager? get profileId {
    final $_column = $_itemColumn<int>('profile_id');
    if ($_column == null) return null;
    final manager = $$ProfilesTableTableManager(
      $_db,
      $_db.profiles,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_profileIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$ProxyChainHopsTableFilterComposer
    extends Composer<_$Database, $ProxyChainHopsTable> {
  $$ProxyChainHopsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get order => $composableBuilder(
    column: $table.order,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get targetKind => $composableBuilder(
    column: $table.targetKind,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get groupName => $composableBuilder(
    column: $table.groupName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<
    Map<String, Object?>?,
    Map<String, Object>?,
    String
  >
  get localEndpoint => $composableBuilder(
    column: $table.localEndpoint,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  $$ProxyChainsTableFilterComposer get chainId {
    final $$ProxyChainsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.chainId,
      referencedTable: $db.proxyChains,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProxyChainsTableFilterComposer(
            $db: $db,
            $table: $db.proxyChains,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ProxyNodesTableFilterComposer get nodeId {
    final $$ProxyNodesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.nodeId,
      referencedTable: $db.proxyNodes,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProxyNodesTableFilterComposer(
            $db: $db,
            $table: $db.proxyNodes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ProxyGroupsTableFilterComposer get groupId {
    final $$ProxyGroupsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.groupId,
      referencedTable: $db.proxyGroups,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProxyGroupsTableFilterComposer(
            $db: $db,
            $table: $db.proxyGroups,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ProfilesTableFilterComposer get profileId {
    final $$ProfilesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.profileId,
      referencedTable: $db.profiles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProfilesTableFilterComposer(
            $db: $db,
            $table: $db.profiles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ProxyChainHopsTableOrderingComposer
    extends Composer<_$Database, $ProxyChainHopsTable> {
  $$ProxyChainHopsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get order => $composableBuilder(
    column: $table.order,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get targetKind => $composableBuilder(
    column: $table.targetKind,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get groupName => $composableBuilder(
    column: $table.groupName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get localEndpoint => $composableBuilder(
    column: $table.localEndpoint,
    builder: (column) => ColumnOrderings(column),
  );

  $$ProxyChainsTableOrderingComposer get chainId {
    final $$ProxyChainsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.chainId,
      referencedTable: $db.proxyChains,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProxyChainsTableOrderingComposer(
            $db: $db,
            $table: $db.proxyChains,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ProxyNodesTableOrderingComposer get nodeId {
    final $$ProxyNodesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.nodeId,
      referencedTable: $db.proxyNodes,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProxyNodesTableOrderingComposer(
            $db: $db,
            $table: $db.proxyNodes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ProxyGroupsTableOrderingComposer get groupId {
    final $$ProxyGroupsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.groupId,
      referencedTable: $db.proxyGroups,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProxyGroupsTableOrderingComposer(
            $db: $db,
            $table: $db.proxyGroups,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ProfilesTableOrderingComposer get profileId {
    final $$ProfilesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.profileId,
      referencedTable: $db.profiles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProfilesTableOrderingComposer(
            $db: $db,
            $table: $db.profiles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ProxyChainHopsTableAnnotationComposer
    extends Composer<_$Database, $ProxyChainHopsTable> {
  $$ProxyChainHopsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get order =>
      $composableBuilder(column: $table.order, builder: (column) => column);

  GeneratedColumn<String> get targetKind => $composableBuilder(
    column: $table.targetKind,
    builder: (column) => column,
  );

  GeneratedColumn<String> get groupName =>
      $composableBuilder(column: $table.groupName, builder: (column) => column);

  GeneratedColumnWithTypeConverter<Map<String, Object?>?, String>
  get localEndpoint => $composableBuilder(
    column: $table.localEndpoint,
    builder: (column) => column,
  );

  $$ProxyChainsTableAnnotationComposer get chainId {
    final $$ProxyChainsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.chainId,
      referencedTable: $db.proxyChains,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProxyChainsTableAnnotationComposer(
            $db: $db,
            $table: $db.proxyChains,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ProxyNodesTableAnnotationComposer get nodeId {
    final $$ProxyNodesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.nodeId,
      referencedTable: $db.proxyNodes,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProxyNodesTableAnnotationComposer(
            $db: $db,
            $table: $db.proxyNodes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ProxyGroupsTableAnnotationComposer get groupId {
    final $$ProxyGroupsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.groupId,
      referencedTable: $db.proxyGroups,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProxyGroupsTableAnnotationComposer(
            $db: $db,
            $table: $db.proxyGroups,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ProfilesTableAnnotationComposer get profileId {
    final $$ProfilesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.profileId,
      referencedTable: $db.profiles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProfilesTableAnnotationComposer(
            $db: $db,
            $table: $db.profiles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ProxyChainHopsTableTableManager
    extends
        RootTableManager<
          _$Database,
          $ProxyChainHopsTable,
          RawProxyChainHop,
          $$ProxyChainHopsTableFilterComposer,
          $$ProxyChainHopsTableOrderingComposer,
          $$ProxyChainHopsTableAnnotationComposer,
          $$ProxyChainHopsTableCreateCompanionBuilder,
          $$ProxyChainHopsTableUpdateCompanionBuilder,
          (RawProxyChainHop, $$ProxyChainHopsTableReferences),
          RawProxyChainHop,
          PrefetchHooks Function({
            bool chainId,
            bool nodeId,
            bool groupId,
            bool profileId,
          })
        > {
  $$ProxyChainHopsTableTableManager(_$Database db, $ProxyChainHopsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ProxyChainHopsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ProxyChainHopsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ProxyChainHopsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> chainId = const Value.absent(),
                Value<int> order = const Value.absent(),
                Value<String> targetKind = const Value.absent(),
                Value<int?> nodeId = const Value.absent(),
                Value<int?> groupId = const Value.absent(),
                Value<int?> profileId = const Value.absent(),
                Value<String?> groupName = const Value.absent(),
                Value<Map<String, Object?>?> localEndpoint =
                    const Value.absent(),
              }) => ProxyChainHopsCompanion(
                id: id,
                chainId: chainId,
                order: order,
                targetKind: targetKind,
                nodeId: nodeId,
                groupId: groupId,
                profileId: profileId,
                groupName: groupName,
                localEndpoint: localEndpoint,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int chainId,
                required int order,
                required String targetKind,
                Value<int?> nodeId = const Value.absent(),
                Value<int?> groupId = const Value.absent(),
                Value<int?> profileId = const Value.absent(),
                Value<String?> groupName = const Value.absent(),
                Value<Map<String, Object?>?> localEndpoint =
                    const Value.absent(),
              }) => ProxyChainHopsCompanion.insert(
                id: id,
                chainId: chainId,
                order: order,
                targetKind: targetKind,
                nodeId: nodeId,
                groupId: groupId,
                profileId: profileId,
                groupName: groupName,
                localEndpoint: localEndpoint,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$ProxyChainHopsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                chainId = false,
                nodeId = false,
                groupId = false,
                profileId = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (chainId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.chainId,
                                    referencedTable:
                                        $$ProxyChainHopsTableReferences
                                            ._chainIdTable(db),
                                    referencedColumn:
                                        $$ProxyChainHopsTableReferences
                                            ._chainIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }
                        if (nodeId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.nodeId,
                                    referencedTable:
                                        $$ProxyChainHopsTableReferences
                                            ._nodeIdTable(db),
                                    referencedColumn:
                                        $$ProxyChainHopsTableReferences
                                            ._nodeIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }
                        if (groupId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.groupId,
                                    referencedTable:
                                        $$ProxyChainHopsTableReferences
                                            ._groupIdTable(db),
                                    referencedColumn:
                                        $$ProxyChainHopsTableReferences
                                            ._groupIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }
                        if (profileId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.profileId,
                                    referencedTable:
                                        $$ProxyChainHopsTableReferences
                                            ._profileIdTable(db),
                                    referencedColumn:
                                        $$ProxyChainHopsTableReferences
                                            ._profileIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [];
                  },
                );
              },
        ),
      );
}

typedef $$ProxyChainHopsTableProcessedTableManager =
    ProcessedTableManager<
      _$Database,
      $ProxyChainHopsTable,
      RawProxyChainHop,
      $$ProxyChainHopsTableFilterComposer,
      $$ProxyChainHopsTableOrderingComposer,
      $$ProxyChainHopsTableAnnotationComposer,
      $$ProxyChainHopsTableCreateCompanionBuilder,
      $$ProxyChainHopsTableUpdateCompanionBuilder,
      (RawProxyChainHop, $$ProxyChainHopsTableReferences),
      RawProxyChainHop,
      PrefetchHooks Function({
        bool chainId,
        bool nodeId,
        bool groupId,
        bool profileId,
      })
    >;
typedef $$ProxyChainBindingsTableCreateCompanionBuilder =
    ProxyChainBindingsCompanion Function({
      required int profileId,
      required int chainId,
      Value<bool> enabled,
      Value<bool> isDefault,
      Value<String?> selectorName,
      Value<int?> order,
      Value<int> rowid,
    });
typedef $$ProxyChainBindingsTableUpdateCompanionBuilder =
    ProxyChainBindingsCompanion Function({
      Value<int> profileId,
      Value<int> chainId,
      Value<bool> enabled,
      Value<bool> isDefault,
      Value<String?> selectorName,
      Value<int?> order,
      Value<int> rowid,
    });

final class $$ProxyChainBindingsTableReferences
    extends
        BaseReferences<
          _$Database,
          $ProxyChainBindingsTable,
          RawProxyChainBinding
        > {
  $$ProxyChainBindingsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $ProfilesTable _profileIdTable(_$Database db) =>
      db.profiles.createAlias('profile_proxy_chains__profile_id__profiles__id');

  $$ProfilesTableProcessedTableManager get profileId {
    final $_column = $_itemColumn<int>('profile_id')!;

    final manager = $$ProfilesTableTableManager(
      $_db,
      $_db.profiles,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_profileIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $ProxyChainsTable _chainIdTable(_$Database db) => db.proxyChains
      .createAlias('profile_proxy_chains__chain_id__proxy_chains__id');

  $$ProxyChainsTableProcessedTableManager get chainId {
    final $_column = $_itemColumn<int>('chain_id')!;

    final manager = $$ProxyChainsTableTableManager(
      $_db,
      $_db.proxyChains,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_chainIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$ProxyChainBindingsTableFilterComposer
    extends Composer<_$Database, $ProxyChainBindingsTable> {
  $$ProxyChainBindingsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<bool> get enabled => $composableBuilder(
    column: $table.enabled,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isDefault => $composableBuilder(
    column: $table.isDefault,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get selectorName => $composableBuilder(
    column: $table.selectorName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get order => $composableBuilder(
    column: $table.order,
    builder: (column) => ColumnFilters(column),
  );

  $$ProfilesTableFilterComposer get profileId {
    final $$ProfilesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.profileId,
      referencedTable: $db.profiles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProfilesTableFilterComposer(
            $db: $db,
            $table: $db.profiles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ProxyChainsTableFilterComposer get chainId {
    final $$ProxyChainsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.chainId,
      referencedTable: $db.proxyChains,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProxyChainsTableFilterComposer(
            $db: $db,
            $table: $db.proxyChains,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ProxyChainBindingsTableOrderingComposer
    extends Composer<_$Database, $ProxyChainBindingsTable> {
  $$ProxyChainBindingsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<bool> get enabled => $composableBuilder(
    column: $table.enabled,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isDefault => $composableBuilder(
    column: $table.isDefault,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get selectorName => $composableBuilder(
    column: $table.selectorName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get order => $composableBuilder(
    column: $table.order,
    builder: (column) => ColumnOrderings(column),
  );

  $$ProfilesTableOrderingComposer get profileId {
    final $$ProfilesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.profileId,
      referencedTable: $db.profiles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProfilesTableOrderingComposer(
            $db: $db,
            $table: $db.profiles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ProxyChainsTableOrderingComposer get chainId {
    final $$ProxyChainsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.chainId,
      referencedTable: $db.proxyChains,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProxyChainsTableOrderingComposer(
            $db: $db,
            $table: $db.proxyChains,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ProxyChainBindingsTableAnnotationComposer
    extends Composer<_$Database, $ProxyChainBindingsTable> {
  $$ProxyChainBindingsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<bool> get enabled =>
      $composableBuilder(column: $table.enabled, builder: (column) => column);

  GeneratedColumn<bool> get isDefault =>
      $composableBuilder(column: $table.isDefault, builder: (column) => column);

  GeneratedColumn<String> get selectorName => $composableBuilder(
    column: $table.selectorName,
    builder: (column) => column,
  );

  GeneratedColumn<int> get order =>
      $composableBuilder(column: $table.order, builder: (column) => column);

  $$ProfilesTableAnnotationComposer get profileId {
    final $$ProfilesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.profileId,
      referencedTable: $db.profiles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProfilesTableAnnotationComposer(
            $db: $db,
            $table: $db.profiles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ProxyChainsTableAnnotationComposer get chainId {
    final $$ProxyChainsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.chainId,
      referencedTable: $db.proxyChains,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProxyChainsTableAnnotationComposer(
            $db: $db,
            $table: $db.proxyChains,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ProxyChainBindingsTableTableManager
    extends
        RootTableManager<
          _$Database,
          $ProxyChainBindingsTable,
          RawProxyChainBinding,
          $$ProxyChainBindingsTableFilterComposer,
          $$ProxyChainBindingsTableOrderingComposer,
          $$ProxyChainBindingsTableAnnotationComposer,
          $$ProxyChainBindingsTableCreateCompanionBuilder,
          $$ProxyChainBindingsTableUpdateCompanionBuilder,
          (RawProxyChainBinding, $$ProxyChainBindingsTableReferences),
          RawProxyChainBinding,
          PrefetchHooks Function({bool profileId, bool chainId})
        > {
  $$ProxyChainBindingsTableTableManager(
    _$Database db,
    $ProxyChainBindingsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ProxyChainBindingsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ProxyChainBindingsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ProxyChainBindingsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> profileId = const Value.absent(),
                Value<int> chainId = const Value.absent(),
                Value<bool> enabled = const Value.absent(),
                Value<bool> isDefault = const Value.absent(),
                Value<String?> selectorName = const Value.absent(),
                Value<int?> order = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ProxyChainBindingsCompanion(
                profileId: profileId,
                chainId: chainId,
                enabled: enabled,
                isDefault: isDefault,
                selectorName: selectorName,
                order: order,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required int profileId,
                required int chainId,
                Value<bool> enabled = const Value.absent(),
                Value<bool> isDefault = const Value.absent(),
                Value<String?> selectorName = const Value.absent(),
                Value<int?> order = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ProxyChainBindingsCompanion.insert(
                profileId: profileId,
                chainId: chainId,
                enabled: enabled,
                isDefault: isDefault,
                selectorName: selectorName,
                order: order,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$ProxyChainBindingsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({profileId = false, chainId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (profileId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.profileId,
                                referencedTable:
                                    $$ProxyChainBindingsTableReferences
                                        ._profileIdTable(db),
                                referencedColumn:
                                    $$ProxyChainBindingsTableReferences
                                        ._profileIdTable(db)
                                        .id,
                              )
                              as T;
                    }
                    if (chainId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.chainId,
                                referencedTable:
                                    $$ProxyChainBindingsTableReferences
                                        ._chainIdTable(db),
                                referencedColumn:
                                    $$ProxyChainBindingsTableReferences
                                        ._chainIdTable(db)
                                        .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$ProxyChainBindingsTableProcessedTableManager =
    ProcessedTableManager<
      _$Database,
      $ProxyChainBindingsTable,
      RawProxyChainBinding,
      $$ProxyChainBindingsTableFilterComposer,
      $$ProxyChainBindingsTableOrderingComposer,
      $$ProxyChainBindingsTableAnnotationComposer,
      $$ProxyChainBindingsTableCreateCompanionBuilder,
      $$ProxyChainBindingsTableUpdateCompanionBuilder,
      (RawProxyChainBinding, $$ProxyChainBindingsTableReferences),
      RawProxyChainBinding,
      PrefetchHooks Function({bool profileId, bool chainId})
    >;
typedef $$ProxyNodeAssetsTableCreateCompanionBuilder =
    ProxyNodeAssetsCompanion Function({
      Value<int> id,
      required int nodeId,
      required String fieldPath,
      required String fileName,
      required String relativePath,
      required String sha256,
      Value<int?> size,
    });
typedef $$ProxyNodeAssetsTableUpdateCompanionBuilder =
    ProxyNodeAssetsCompanion Function({
      Value<int> id,
      Value<int> nodeId,
      Value<String> fieldPath,
      Value<String> fileName,
      Value<String> relativePath,
      Value<String> sha256,
      Value<int?> size,
    });

final class $$ProxyNodeAssetsTableReferences
    extends
        BaseReferences<_$Database, $ProxyNodeAssetsTable, RawProxyNodeAsset> {
  $$ProxyNodeAssetsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $ProxyNodesTable _nodeIdTable(_$Database db) =>
      db.proxyNodes.createAlias('proxy_node_assets__node_id__proxy_nodes__id');

  $$ProxyNodesTableProcessedTableManager get nodeId {
    final $_column = $_itemColumn<int>('node_id')!;

    final manager = $$ProxyNodesTableTableManager(
      $_db,
      $_db.proxyNodes,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_nodeIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$ProxyNodeAssetsTableFilterComposer
    extends Composer<_$Database, $ProxyNodeAssetsTable> {
  $$ProxyNodeAssetsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get fieldPath => $composableBuilder(
    column: $table.fieldPath,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get fileName => $composableBuilder(
    column: $table.fileName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get relativePath => $composableBuilder(
    column: $table.relativePath,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get sha256 => $composableBuilder(
    column: $table.sha256,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get size => $composableBuilder(
    column: $table.size,
    builder: (column) => ColumnFilters(column),
  );

  $$ProxyNodesTableFilterComposer get nodeId {
    final $$ProxyNodesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.nodeId,
      referencedTable: $db.proxyNodes,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProxyNodesTableFilterComposer(
            $db: $db,
            $table: $db.proxyNodes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ProxyNodeAssetsTableOrderingComposer
    extends Composer<_$Database, $ProxyNodeAssetsTable> {
  $$ProxyNodeAssetsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get fieldPath => $composableBuilder(
    column: $table.fieldPath,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get fileName => $composableBuilder(
    column: $table.fileName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get relativePath => $composableBuilder(
    column: $table.relativePath,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get sha256 => $composableBuilder(
    column: $table.sha256,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get size => $composableBuilder(
    column: $table.size,
    builder: (column) => ColumnOrderings(column),
  );

  $$ProxyNodesTableOrderingComposer get nodeId {
    final $$ProxyNodesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.nodeId,
      referencedTable: $db.proxyNodes,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProxyNodesTableOrderingComposer(
            $db: $db,
            $table: $db.proxyNodes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ProxyNodeAssetsTableAnnotationComposer
    extends Composer<_$Database, $ProxyNodeAssetsTable> {
  $$ProxyNodeAssetsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get fieldPath =>
      $composableBuilder(column: $table.fieldPath, builder: (column) => column);

  GeneratedColumn<String> get fileName =>
      $composableBuilder(column: $table.fileName, builder: (column) => column);

  GeneratedColumn<String> get relativePath => $composableBuilder(
    column: $table.relativePath,
    builder: (column) => column,
  );

  GeneratedColumn<String> get sha256 =>
      $composableBuilder(column: $table.sha256, builder: (column) => column);

  GeneratedColumn<int> get size =>
      $composableBuilder(column: $table.size, builder: (column) => column);

  $$ProxyNodesTableAnnotationComposer get nodeId {
    final $$ProxyNodesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.nodeId,
      referencedTable: $db.proxyNodes,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProxyNodesTableAnnotationComposer(
            $db: $db,
            $table: $db.proxyNodes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ProxyNodeAssetsTableTableManager
    extends
        RootTableManager<
          _$Database,
          $ProxyNodeAssetsTable,
          RawProxyNodeAsset,
          $$ProxyNodeAssetsTableFilterComposer,
          $$ProxyNodeAssetsTableOrderingComposer,
          $$ProxyNodeAssetsTableAnnotationComposer,
          $$ProxyNodeAssetsTableCreateCompanionBuilder,
          $$ProxyNodeAssetsTableUpdateCompanionBuilder,
          (RawProxyNodeAsset, $$ProxyNodeAssetsTableReferences),
          RawProxyNodeAsset,
          PrefetchHooks Function({bool nodeId})
        > {
  $$ProxyNodeAssetsTableTableManager(_$Database db, $ProxyNodeAssetsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ProxyNodeAssetsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ProxyNodeAssetsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ProxyNodeAssetsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> nodeId = const Value.absent(),
                Value<String> fieldPath = const Value.absent(),
                Value<String> fileName = const Value.absent(),
                Value<String> relativePath = const Value.absent(),
                Value<String> sha256 = const Value.absent(),
                Value<int?> size = const Value.absent(),
              }) => ProxyNodeAssetsCompanion(
                id: id,
                nodeId: nodeId,
                fieldPath: fieldPath,
                fileName: fileName,
                relativePath: relativePath,
                sha256: sha256,
                size: size,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int nodeId,
                required String fieldPath,
                required String fileName,
                required String relativePath,
                required String sha256,
                Value<int?> size = const Value.absent(),
              }) => ProxyNodeAssetsCompanion.insert(
                id: id,
                nodeId: nodeId,
                fieldPath: fieldPath,
                fileName: fileName,
                relativePath: relativePath,
                sha256: sha256,
                size: size,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$ProxyNodeAssetsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({nodeId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (nodeId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.nodeId,
                                referencedTable:
                                    $$ProxyNodeAssetsTableReferences
                                        ._nodeIdTable(db),
                                referencedColumn:
                                    $$ProxyNodeAssetsTableReferences
                                        ._nodeIdTable(db)
                                        .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$ProxyNodeAssetsTableProcessedTableManager =
    ProcessedTableManager<
      _$Database,
      $ProxyNodeAssetsTable,
      RawProxyNodeAsset,
      $$ProxyNodeAssetsTableFilterComposer,
      $$ProxyNodeAssetsTableOrderingComposer,
      $$ProxyNodeAssetsTableAnnotationComposer,
      $$ProxyNodeAssetsTableCreateCompanionBuilder,
      $$ProxyNodeAssetsTableUpdateCompanionBuilder,
      (RawProxyNodeAsset, $$ProxyNodeAssetsTableReferences),
      RawProxyNodeAsset,
      PrefetchHooks Function({bool nodeId})
    >;
typedef $$ProxyGroupMembersTableCreateCompanionBuilder =
    ProxyGroupMembersCompanion Function({
      Value<int> id,
      required int groupId,
      Value<int?> nodeId,
      Value<String?> literalName,
      Value<int?> order,
    });
typedef $$ProxyGroupMembersTableUpdateCompanionBuilder =
    ProxyGroupMembersCompanion Function({
      Value<int> id,
      Value<int> groupId,
      Value<int?> nodeId,
      Value<String?> literalName,
      Value<int?> order,
    });

final class $$ProxyGroupMembersTableReferences
    extends
        BaseReferences<
          _$Database,
          $ProxyGroupMembersTable,
          RawProxyGroupMember
        > {
  $$ProxyGroupMembersTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $ProxyGroupsTable _groupIdTable(_$Database db) => db.proxyGroups
      .createAlias('proxy_group_members__group_id__proxy_groups__id');

  $$ProxyGroupsTableProcessedTableManager get groupId {
    final $_column = $_itemColumn<int>('group_id')!;

    final manager = $$ProxyGroupsTableTableManager(
      $_db,
      $_db.proxyGroups,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_groupIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $ProxyNodesTable _nodeIdTable(_$Database db) => db.proxyNodes
      .createAlias('proxy_group_members__node_id__proxy_nodes__id');

  $$ProxyNodesTableProcessedTableManager? get nodeId {
    final $_column = $_itemColumn<int>('node_id');
    if ($_column == null) return null;
    final manager = $$ProxyNodesTableTableManager(
      $_db,
      $_db.proxyNodes,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_nodeIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$ProxyGroupMembersTableFilterComposer
    extends Composer<_$Database, $ProxyGroupMembersTable> {
  $$ProxyGroupMembersTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get literalName => $composableBuilder(
    column: $table.literalName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get order => $composableBuilder(
    column: $table.order,
    builder: (column) => ColumnFilters(column),
  );

  $$ProxyGroupsTableFilterComposer get groupId {
    final $$ProxyGroupsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.groupId,
      referencedTable: $db.proxyGroups,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProxyGroupsTableFilterComposer(
            $db: $db,
            $table: $db.proxyGroups,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ProxyNodesTableFilterComposer get nodeId {
    final $$ProxyNodesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.nodeId,
      referencedTable: $db.proxyNodes,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProxyNodesTableFilterComposer(
            $db: $db,
            $table: $db.proxyNodes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ProxyGroupMembersTableOrderingComposer
    extends Composer<_$Database, $ProxyGroupMembersTable> {
  $$ProxyGroupMembersTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get literalName => $composableBuilder(
    column: $table.literalName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get order => $composableBuilder(
    column: $table.order,
    builder: (column) => ColumnOrderings(column),
  );

  $$ProxyGroupsTableOrderingComposer get groupId {
    final $$ProxyGroupsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.groupId,
      referencedTable: $db.proxyGroups,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProxyGroupsTableOrderingComposer(
            $db: $db,
            $table: $db.proxyGroups,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ProxyNodesTableOrderingComposer get nodeId {
    final $$ProxyNodesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.nodeId,
      referencedTable: $db.proxyNodes,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProxyNodesTableOrderingComposer(
            $db: $db,
            $table: $db.proxyNodes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ProxyGroupMembersTableAnnotationComposer
    extends Composer<_$Database, $ProxyGroupMembersTable> {
  $$ProxyGroupMembersTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get literalName => $composableBuilder(
    column: $table.literalName,
    builder: (column) => column,
  );

  GeneratedColumn<int> get order =>
      $composableBuilder(column: $table.order, builder: (column) => column);

  $$ProxyGroupsTableAnnotationComposer get groupId {
    final $$ProxyGroupsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.groupId,
      referencedTable: $db.proxyGroups,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProxyGroupsTableAnnotationComposer(
            $db: $db,
            $table: $db.proxyGroups,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ProxyNodesTableAnnotationComposer get nodeId {
    final $$ProxyNodesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.nodeId,
      referencedTable: $db.proxyNodes,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProxyNodesTableAnnotationComposer(
            $db: $db,
            $table: $db.proxyNodes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ProxyGroupMembersTableTableManager
    extends
        RootTableManager<
          _$Database,
          $ProxyGroupMembersTable,
          RawProxyGroupMember,
          $$ProxyGroupMembersTableFilterComposer,
          $$ProxyGroupMembersTableOrderingComposer,
          $$ProxyGroupMembersTableAnnotationComposer,
          $$ProxyGroupMembersTableCreateCompanionBuilder,
          $$ProxyGroupMembersTableUpdateCompanionBuilder,
          (RawProxyGroupMember, $$ProxyGroupMembersTableReferences),
          RawProxyGroupMember,
          PrefetchHooks Function({bool groupId, bool nodeId})
        > {
  $$ProxyGroupMembersTableTableManager(
    _$Database db,
    $ProxyGroupMembersTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ProxyGroupMembersTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ProxyGroupMembersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ProxyGroupMembersTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> groupId = const Value.absent(),
                Value<int?> nodeId = const Value.absent(),
                Value<String?> literalName = const Value.absent(),
                Value<int?> order = const Value.absent(),
              }) => ProxyGroupMembersCompanion(
                id: id,
                groupId: groupId,
                nodeId: nodeId,
                literalName: literalName,
                order: order,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int groupId,
                Value<int?> nodeId = const Value.absent(),
                Value<String?> literalName = const Value.absent(),
                Value<int?> order = const Value.absent(),
              }) => ProxyGroupMembersCompanion.insert(
                id: id,
                groupId: groupId,
                nodeId: nodeId,
                literalName: literalName,
                order: order,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$ProxyGroupMembersTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({groupId = false, nodeId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (groupId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.groupId,
                                referencedTable:
                                    $$ProxyGroupMembersTableReferences
                                        ._groupIdTable(db),
                                referencedColumn:
                                    $$ProxyGroupMembersTableReferences
                                        ._groupIdTable(db)
                                        .id,
                              )
                              as T;
                    }
                    if (nodeId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.nodeId,
                                referencedTable:
                                    $$ProxyGroupMembersTableReferences
                                        ._nodeIdTable(db),
                                referencedColumn:
                                    $$ProxyGroupMembersTableReferences
                                        ._nodeIdTable(db)
                                        .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$ProxyGroupMembersTableProcessedTableManager =
    ProcessedTableManager<
      _$Database,
      $ProxyGroupMembersTable,
      RawProxyGroupMember,
      $$ProxyGroupMembersTableFilterComposer,
      $$ProxyGroupMembersTableOrderingComposer,
      $$ProxyGroupMembersTableAnnotationComposer,
      $$ProxyGroupMembersTableCreateCompanionBuilder,
      $$ProxyGroupMembersTableUpdateCompanionBuilder,
      (RawProxyGroupMember, $$ProxyGroupMembersTableReferences),
      RawProxyGroupMember,
      PrefetchHooks Function({bool groupId, bool nodeId})
    >;

class $DatabaseManager {
  final _$Database _db;
  $DatabaseManager(this._db);
  $$ProfilesTableTableManager get profiles =>
      $$ProfilesTableTableManager(_db, _db.profiles);
  $$ScriptsTableTableManager get scripts =>
      $$ScriptsTableTableManager(_db, _db.scripts);
  $$RulesTableTableManager get rules =>
      $$RulesTableTableManager(_db, _db.rules);
  $$ProfileRuleLinksTableTableManager get profileRuleLinks =>
      $$ProfileRuleLinksTableTableManager(_db, _db.profileRuleLinks);
  $$ProxyGroupsTableTableManager get proxyGroups =>
      $$ProxyGroupsTableTableManager(_db, _db.proxyGroups);
  $$IconRecordsTableTableManager get iconRecords =>
      $$IconRecordsTableTableManager(_db, _db.iconRecords);
  $$ProxyNodesTableTableManager get proxyNodes =>
      $$ProxyNodesTableTableManager(_db, _db.proxyNodes);
  $$ProxyNodeBindingsTableTableManager get proxyNodeBindings =>
      $$ProxyNodeBindingsTableTableManager(_db, _db.proxyNodeBindings);
  $$ProxyChainsTableTableManager get proxyChains =>
      $$ProxyChainsTableTableManager(_db, _db.proxyChains);
  $$ProxyChainHopsTableTableManager get proxyChainHops =>
      $$ProxyChainHopsTableTableManager(_db, _db.proxyChainHops);
  $$ProxyChainBindingsTableTableManager get proxyChainBindings =>
      $$ProxyChainBindingsTableTableManager(_db, _db.proxyChainBindings);
  $$ProxyNodeAssetsTableTableManager get proxyNodeAssets =>
      $$ProxyNodeAssetsTableTableManager(_db, _db.proxyNodeAssets);
  $$ProxyGroupMembersTableTableManager get proxyGroupMembers =>
      $$ProxyGroupMembersTableTableManager(_db, _db.proxyGroupMembers);
}

mixin _$ProfilesDaoMixin on DatabaseAccessor<Database> {
  $ProfilesTable get profiles => attachedDatabase.profiles;
  ProfilesDaoManager get managers => ProfilesDaoManager(this);
}

class ProfilesDaoManager {
  final _$ProfilesDaoMixin _db;
  ProfilesDaoManager(this._db);
  $$ProfilesTableTableManager get profiles =>
      $$ProfilesTableTableManager(_db.attachedDatabase, _db.profiles);
}

mixin _$ScriptsDaoMixin on DatabaseAccessor<Database> {
  $ScriptsTable get scripts => attachedDatabase.scripts;
  ScriptsDaoManager get managers => ScriptsDaoManager(this);
}

class ScriptsDaoManager {
  final _$ScriptsDaoMixin _db;
  ScriptsDaoManager(this._db);
  $$ScriptsTableTableManager get scripts =>
      $$ScriptsTableTableManager(_db.attachedDatabase, _db.scripts);
}

mixin _$RulesDaoMixin on DatabaseAccessor<Database> {
  $RulesTable get rules => attachedDatabase.rules;
  $ProfilesTable get profiles => attachedDatabase.profiles;
  $ProfileRuleLinksTable get profileRuleLinks =>
      attachedDatabase.profileRuleLinks;
  RulesDaoManager get managers => RulesDaoManager(this);
}

class RulesDaoManager {
  final _$RulesDaoMixin _db;
  RulesDaoManager(this._db);
  $$RulesTableTableManager get rules =>
      $$RulesTableTableManager(_db.attachedDatabase, _db.rules);
  $$ProfilesTableTableManager get profiles =>
      $$ProfilesTableTableManager(_db.attachedDatabase, _db.profiles);
  $$ProfileRuleLinksTableTableManager get profileRuleLinks =>
      $$ProfileRuleLinksTableTableManager(
        _db.attachedDatabase,
        _db.profileRuleLinks,
      );
}

mixin _$ProxyGroupsDaoMixin on DatabaseAccessor<Database> {
  $ProfilesTable get profiles => attachedDatabase.profiles;
  $ProxyGroupsTable get proxyGroups => attachedDatabase.proxyGroups;
  ProxyGroupsDaoManager get managers => ProxyGroupsDaoManager(this);
}

class ProxyGroupsDaoManager {
  final _$ProxyGroupsDaoMixin _db;
  ProxyGroupsDaoManager(this._db);
  $$ProfilesTableTableManager get profiles =>
      $$ProfilesTableTableManager(_db.attachedDatabase, _db.profiles);
  $$ProxyGroupsTableTableManager get proxyGroups =>
      $$ProxyGroupsTableTableManager(_db.attachedDatabase, _db.proxyGroups);
}

mixin _$IconRecordsDaoMixin on DatabaseAccessor<Database> {
  $IconRecordsTable get iconRecords => attachedDatabase.iconRecords;
  IconRecordsDaoManager get managers => IconRecordsDaoManager(this);
}

class IconRecordsDaoManager {
  final _$IconRecordsDaoMixin _db;
  IconRecordsDaoManager(this._db);
  $$IconRecordsTableTableManager get iconRecords =>
      $$IconRecordsTableTableManager(_db.attachedDatabase, _db.iconRecords);
}

mixin _$ProxyNodesDaoMixin on DatabaseAccessor<Database> {
  $ProfilesTable get profiles => attachedDatabase.profiles;
  $ProxyNodesTable get proxyNodes => attachedDatabase.proxyNodes;
  ProxyNodesDaoManager get managers => ProxyNodesDaoManager(this);
}

class ProxyNodesDaoManager {
  final _$ProxyNodesDaoMixin _db;
  ProxyNodesDaoManager(this._db);
  $$ProfilesTableTableManager get profiles =>
      $$ProfilesTableTableManager(_db.attachedDatabase, _db.profiles);
  $$ProxyNodesTableTableManager get proxyNodes =>
      $$ProxyNodesTableTableManager(_db.attachedDatabase, _db.proxyNodes);
}

mixin _$ProxyNodeBindingsDaoMixin on DatabaseAccessor<Database> {
  $ProfilesTable get profiles => attachedDatabase.profiles;
  $ProxyNodesTable get proxyNodes => attachedDatabase.proxyNodes;
  $ProxyNodeBindingsTable get proxyNodeBindings =>
      attachedDatabase.proxyNodeBindings;
  ProxyNodeBindingsDaoManager get managers => ProxyNodeBindingsDaoManager(this);
}

class ProxyNodeBindingsDaoManager {
  final _$ProxyNodeBindingsDaoMixin _db;
  ProxyNodeBindingsDaoManager(this._db);
  $$ProfilesTableTableManager get profiles =>
      $$ProfilesTableTableManager(_db.attachedDatabase, _db.profiles);
  $$ProxyNodesTableTableManager get proxyNodes =>
      $$ProxyNodesTableTableManager(_db.attachedDatabase, _db.proxyNodes);
  $$ProxyNodeBindingsTableTableManager get proxyNodeBindings =>
      $$ProxyNodeBindingsTableTableManager(
        _db.attachedDatabase,
        _db.proxyNodeBindings,
      );
}

mixin _$ProxyChainsDaoMixin on DatabaseAccessor<Database> {
  $ProxyChainsTable get proxyChains => attachedDatabase.proxyChains;
  ProxyChainsDaoManager get managers => ProxyChainsDaoManager(this);
}

class ProxyChainsDaoManager {
  final _$ProxyChainsDaoMixin _db;
  ProxyChainsDaoManager(this._db);
  $$ProxyChainsTableTableManager get proxyChains =>
      $$ProxyChainsTableTableManager(_db.attachedDatabase, _db.proxyChains);
}

mixin _$ProxyChainHopsDaoMixin on DatabaseAccessor<Database> {
  $ProxyChainsTable get proxyChains => attachedDatabase.proxyChains;
  $ProfilesTable get profiles => attachedDatabase.profiles;
  $ProxyNodesTable get proxyNodes => attachedDatabase.proxyNodes;
  $ProxyGroupsTable get proxyGroups => attachedDatabase.proxyGroups;
  $ProxyChainHopsTable get proxyChainHops => attachedDatabase.proxyChainHops;
  ProxyChainHopsDaoManager get managers => ProxyChainHopsDaoManager(this);
}

class ProxyChainHopsDaoManager {
  final _$ProxyChainHopsDaoMixin _db;
  ProxyChainHopsDaoManager(this._db);
  $$ProxyChainsTableTableManager get proxyChains =>
      $$ProxyChainsTableTableManager(_db.attachedDatabase, _db.proxyChains);
  $$ProfilesTableTableManager get profiles =>
      $$ProfilesTableTableManager(_db.attachedDatabase, _db.profiles);
  $$ProxyNodesTableTableManager get proxyNodes =>
      $$ProxyNodesTableTableManager(_db.attachedDatabase, _db.proxyNodes);
  $$ProxyGroupsTableTableManager get proxyGroups =>
      $$ProxyGroupsTableTableManager(_db.attachedDatabase, _db.proxyGroups);
  $$ProxyChainHopsTableTableManager get proxyChainHops =>
      $$ProxyChainHopsTableTableManager(
        _db.attachedDatabase,
        _db.proxyChainHops,
      );
}

mixin _$ProxyChainBindingsDaoMixin on DatabaseAccessor<Database> {
  $ProfilesTable get profiles => attachedDatabase.profiles;
  $ProxyChainsTable get proxyChains => attachedDatabase.proxyChains;
  $ProxyChainBindingsTable get proxyChainBindings =>
      attachedDatabase.proxyChainBindings;
  ProxyChainBindingsDaoManager get managers =>
      ProxyChainBindingsDaoManager(this);
}

class ProxyChainBindingsDaoManager {
  final _$ProxyChainBindingsDaoMixin _db;
  ProxyChainBindingsDaoManager(this._db);
  $$ProfilesTableTableManager get profiles =>
      $$ProfilesTableTableManager(_db.attachedDatabase, _db.profiles);
  $$ProxyChainsTableTableManager get proxyChains =>
      $$ProxyChainsTableTableManager(_db.attachedDatabase, _db.proxyChains);
  $$ProxyChainBindingsTableTableManager get proxyChainBindings =>
      $$ProxyChainBindingsTableTableManager(
        _db.attachedDatabase,
        _db.proxyChainBindings,
      );
}

mixin _$ProxyNodeAssetsDaoMixin on DatabaseAccessor<Database> {
  $ProfilesTable get profiles => attachedDatabase.profiles;
  $ProxyNodesTable get proxyNodes => attachedDatabase.proxyNodes;
  $ProxyNodeAssetsTable get proxyNodeAssets => attachedDatabase.proxyNodeAssets;
  ProxyNodeAssetsDaoManager get managers => ProxyNodeAssetsDaoManager(this);
}

class ProxyNodeAssetsDaoManager {
  final _$ProxyNodeAssetsDaoMixin _db;
  ProxyNodeAssetsDaoManager(this._db);
  $$ProfilesTableTableManager get profiles =>
      $$ProfilesTableTableManager(_db.attachedDatabase, _db.profiles);
  $$ProxyNodesTableTableManager get proxyNodes =>
      $$ProxyNodesTableTableManager(_db.attachedDatabase, _db.proxyNodes);
  $$ProxyNodeAssetsTableTableManager get proxyNodeAssets =>
      $$ProxyNodeAssetsTableTableManager(
        _db.attachedDatabase,
        _db.proxyNodeAssets,
      );
}

mixin _$ProxyGroupMembersDaoMixin on DatabaseAccessor<Database> {
  $ProfilesTable get profiles => attachedDatabase.profiles;
  $ProxyGroupsTable get proxyGroups => attachedDatabase.proxyGroups;
  $ProxyNodesTable get proxyNodes => attachedDatabase.proxyNodes;
  $ProxyGroupMembersTable get proxyGroupMembers =>
      attachedDatabase.proxyGroupMembers;
  ProxyGroupMembersDaoManager get managers => ProxyGroupMembersDaoManager(this);
}

class ProxyGroupMembersDaoManager {
  final _$ProxyGroupMembersDaoMixin _db;
  ProxyGroupMembersDaoManager(this._db);
  $$ProfilesTableTableManager get profiles =>
      $$ProfilesTableTableManager(_db.attachedDatabase, _db.profiles);
  $$ProxyGroupsTableTableManager get proxyGroups =>
      $$ProxyGroupsTableTableManager(_db.attachedDatabase, _db.proxyGroups);
  $$ProxyNodesTableTableManager get proxyNodes =>
      $$ProxyNodesTableTableManager(_db.attachedDatabase, _db.proxyNodes);
  $$ProxyGroupMembersTableTableManager get proxyGroupMembers =>
      $$ProxyGroupMembersTableTableManager(
        _db.attachedDatabase,
        _db.proxyGroupMembers,
      );
}
