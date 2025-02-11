import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

class UniqueKeyConverter implements JsonConverter<UniqueKey, String> {
  const UniqueKeyConverter();

  @override
  UniqueKey fromJson(String json) {
    return UniqueKey();
  }

  @override
  String toJson(UniqueKey object) {
    return object.toString();
  }
}
