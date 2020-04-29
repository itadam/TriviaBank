import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:triviabank/constants.dart';
import 'package:triviabank/util/app_config.dart';
import 'package:encrypted_moor/encrypted_moor.dart';
import 'package:moor/moor.dart';

import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:sqflite_sqlcipher/sqflite.dart';

part 'app_database.g.dart';

class BankTransactions extends Table {

  IntColumn get id => integer().autoIncrement()();

  IntColumn get userId => integer()(); // TODO: future versions should define a foreign key to the Users primary key

  TextColumn get description => text().nullable()();

  DateTimeColumn get createdDt => dateTime()();

  IntColumn get amount => integer().withDefault(Constant(0))();

}

class Users extends Table {

  IntColumn get id => integer().autoIncrement()();

  TextColumn get emailAddress => text().customConstraint('UNIQUE')();

}

@UseDao(tables: [BankTransactions])
class BankTransactionDao extends DatabaseAccessor<AppDatabase> with _$BankTransactionDaoMixin {

  final AppDatabase db;
  BankTransactionDao(this.db) : super(db);

  Future<List<BankTransaction>> getAllBankTransactionsByUser(int userId) => (select(bankTransactions)..where((t) => t.userId.equals(userId))).get();
  Future insertTransaction(BankTransaction t) => into(bankTransactions).insert(t);
  Future updateTransaction(BankTransaction t) => update(bankTransactions).replace(t);
  Future deleteTransaction(BankTransaction t) => delete(bankTransactions).delete(t);
  num computerUserBalance(int userId) {
    num result = 0;
    select(bankTransactions)..where((tbl) => tbl.userId.equals(userId))..get()..map((t) => result += t.amount);
    return result;
  }
}

@UseDao(tables: [Users])
class UserDao extends DatabaseAccessor<AppDatabase> with _$UserDaoMixin {

  final AppDatabase db;
  UserDao(this.db) : super(db);

  Future<List<User>> getAllUsers() => select(users).get();
  Future<User> findUser(String emailAddress) => (select(users)..where((u) => u.emailAddress.collate(Collate.noCase).equals(emailAddress))).getSingle();
  Future insertUser(User t) => into(users).insert(t, mode: InsertMode.insertOrReplace);
  Future updateUser(User t) => update(users).replace(t);
  Future deleteUser(User t) => delete(users).delete(t);
}

@UseMoor(tables: [BankTransactions, Users], daos: [BankTransactionDao, UserDao])
class AppDatabase extends _$AppDatabase {

  AppDatabase() : super(EncryptedExecutor.inDatabaseFolder(path: 'am.sqlite', password: dbPassword, logStatements: kDebugMode));

  AppDatabase.connect(DatabaseConnection connection) : super.connect(connection);

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration => MigrationStrategy(
      onCreate: (Migrator m) {
        return m.createAll();
      }
  );
}