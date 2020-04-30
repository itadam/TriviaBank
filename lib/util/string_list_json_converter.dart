
import 'dart:convert';

import 'package:moor/moor.dart';

class StringListJsonConverter extends TypeConverter<List<String>, String> {

  const StringListJsonConverter();

  @override
  List<String> mapToDart(String fromDb) {
    if (fromDb == null) {
      return null;
    }
    return json.decode(fromDb) as List<String>;
  }

  @override
  String mapToSql(List<String> value) {
    if (value == null) {
      return null;
    }
    return jsonEncode(value);
  }
}