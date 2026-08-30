part of 'database.dart';

class StringMapConverter extends TypeConverter<Map<String, String>, String> {
  const StringMapConverter();

  @override
  Map<String, String> fromSql(String fromDb) {
    return Map<String, String>.from(json.decode(fromDb));
  }

  @override
  String toSql(Map<String, String> value) {
    return json.encode(value);
  }
}

class StringListConverter extends TypeConverter<List<String>, String> {
  const StringListConverter();

  @override
  List<String> fromSql(String fromDb) {
    return List<String>.from(json.decode(fromDb));
  }

  @override
  String toSql(List<String> value) {
    return json.encode(value.toList());
  }
}

class StringSetConverter extends TypeConverter<Set<String>, String> {
  const StringSetConverter();

  @override
  Set<String> fromSql(String fromDb) {
    return Set<String>.from(json.decode(fromDb));
  }

  @override
  String toSql(Set<String> value) {
    return json.encode(value.toList());
  }
}

class JsonMapConverter extends TypeConverter<Map<String, Object?>, String> {
  const JsonMapConverter();

  @override
  Map<String, Object?> fromSql(String fromDb) {
    final value = json.decode(fromDb);
    return Map<String, Object?>.from(value as Map);
  }

  @override
  String toSql(Map<String, Object?> value) => json.encode(value);
}

class JsonMapNullableConverter
    extends TypeConverter<Map<String, Object?>?, String?> {
  const JsonMapNullableConverter();

  @override
  Map<String, Object?>? fromSql(String? fromDb) {
    if (fromDb == null) return null;
    final value = json.decode(fromDb);
    return Map<String, Object?>.from(value as Map);
  }

  @override
  String? toSql(Map<String, Object?>? value) {
    if (value == null) return null;
    return json.encode(value);
  }
}
