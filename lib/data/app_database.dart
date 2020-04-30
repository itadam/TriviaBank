import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart' as j;
import 'package:triviabank/constants.dart';
import 'package:triviabank/util/app_config.dart';
import 'package:encrypted_moor/encrypted_moor.dart';
import 'package:moor/moor.dart';

import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:sqflite_sqlcipher/sqflite.dart';
import 'package:triviabank/util/string_list_json_converter.dart';

part 'app_database.g.dart';

class BankTransactions extends Table {

  IntColumn get id => integer().autoIncrement()();

  IntColumn get userId => integer()(); // TODO: future versions should define a foreign key to the Users primary key

  TextColumn get description => text().nullable()();

  DateTimeColumn get createdDt => dateTime().withDefault(Constant(DateTime.now()))();

  IntColumn get amount => integer().withDefault(Constant(0))();

}

@j.JsonSerializable()
class TriviaQuestions extends Table {

  @j.JsonKey(ignore: true)
  IntColumn get id => integer().autoIncrement()();

  @j.JsonKey(ignore: true)
  IntColumn get userId => integer()(); // TODO: future versions should define a foreign key to the Users primary key

  @j.JsonKey(ignore: true)
  DateTimeColumn get createdDt => dateTime().withDefault(Constant(DateTime.now()))();

  // Count the number of times the question has been answered correctly by the user.
  @j.JsonKey(ignore: true)
  IntColumn get correctlyAnswered => integer().withDefault(Constant(0))();

  @j.JsonKey(name: 'category')
  TextColumn get category => text().nullable()();

  @j.JsonKey(name: 'difficulty')
  TextColumn get difficulty => text().nullable()();

  @j.JsonKey(name: 'type')
  TextColumn get type => text().nullable()();

  @j.JsonKey(name: 'question')
  TextColumn get question => text().nullable()();

  @j.JsonKey(name: 'correct_answer')
  TextColumn get correctAnswer => text().nullable()();

  @j.JsonKey(name: 'incorrect_answers')
  TextColumn get incorrectAnswers => text().map(const StringListJsonConverter()).nullable()();

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

@UseDao(tables: [TriviaQuestions])
class TriviaQuestionDao extends DatabaseAccessor<AppDatabase> with _$TriviaQuestionDaoMixin {

  final AppDatabase db;
  TriviaQuestionDao(this.db) : super(db);

  Future insertTriviaQuestion(TriviaQuestion t) => into(triviaQuestions).insert(t, mode: InsertMode.insertOrReplace);
  Future<TriviaQuestion> findExistingQuestion(int userId, String question) => (select(triviaQuestions)..where((q) => q.userId.equals(userId) & q.question.collate(Collate.noCase).equals(question))).getSingle();

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

@UseMoor(tables: [BankTransactions, TriviaQuestions, Users], daos: [BankTransactionDao, TriviaQuestionDao, UserDao])
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