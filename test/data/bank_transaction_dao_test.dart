
import 'package:flutter_test/flutter_test.dart';
import 'package:moor/moor.dart';
import 'package:encrypted_moor/encrypted_moor.dart';
import 'package:triviabank/data/app_database.dart';

void main() {

  AppDatabase database;



  setUp(() {
    //database = AppDatabase(VmDatabase.memory());
  });
  tearDown(() async {
    await database.close();
  });
}