// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps, unnecessary_this
class BankTransaction extends DataClass implements Insertable<BankTransaction> {
  final int id;
  final int userId;
  final String description;
  final DateTime createdDt;
  final int amount;
  BankTransaction(
      {@required this.id,
      @required this.userId,
      this.description,
      @required this.createdDt,
      @required this.amount});
  factory BankTransaction.fromData(
      Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final intType = db.typeSystem.forDartType<int>();
    final stringType = db.typeSystem.forDartType<String>();
    final dateTimeType = db.typeSystem.forDartType<DateTime>();
    return BankTransaction(
      id: intType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      userId:
          intType.mapFromDatabaseResponse(data['${effectivePrefix}user_id']),
      description: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}description']),
      createdDt: dateTimeType
          .mapFromDatabaseResponse(data['${effectivePrefix}created_dt']),
      amount: intType.mapFromDatabaseResponse(data['${effectivePrefix}amount']),
    );
  }
  factory BankTransaction.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return BankTransaction(
      id: serializer.fromJson<int>(json['id']),
      userId: serializer.fromJson<int>(json['userId']),
      description: serializer.fromJson<String>(json['description']),
      createdDt: serializer.fromJson<DateTime>(json['createdDt']),
      amount: serializer.fromJson<int>(json['amount']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'userId': serializer.toJson<int>(userId),
      'description': serializer.toJson<String>(description),
      'createdDt': serializer.toJson<DateTime>(createdDt),
      'amount': serializer.toJson<int>(amount),
    };
  }

  @override
  BankTransactionsCompanion createCompanion(bool nullToAbsent) {
    return BankTransactionsCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      userId:
          userId == null && nullToAbsent ? const Value.absent() : Value(userId),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      createdDt: createdDt == null && nullToAbsent
          ? const Value.absent()
          : Value(createdDt),
      amount:
          amount == null && nullToAbsent ? const Value.absent() : Value(amount),
    );
  }

  BankTransaction copyWith(
          {int id,
          int userId,
          String description,
          DateTime createdDt,
          int amount}) =>
      BankTransaction(
        id: id ?? this.id,
        userId: userId ?? this.userId,
        description: description ?? this.description,
        createdDt: createdDt ?? this.createdDt,
        amount: amount ?? this.amount,
      );
  @override
  String toString() {
    return (StringBuffer('BankTransaction(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('description: $description, ')
          ..write('createdDt: $createdDt, ')
          ..write('amount: $amount')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      id.hashCode,
      $mrjc(
          userId.hashCode,
          $mrjc(description.hashCode,
              $mrjc(createdDt.hashCode, amount.hashCode)))));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is BankTransaction &&
          other.id == this.id &&
          other.userId == this.userId &&
          other.description == this.description &&
          other.createdDt == this.createdDt &&
          other.amount == this.amount);
}

class BankTransactionsCompanion extends UpdateCompanion<BankTransaction> {
  final Value<int> id;
  final Value<int> userId;
  final Value<String> description;
  final Value<DateTime> createdDt;
  final Value<int> amount;
  const BankTransactionsCompanion({
    this.id = const Value.absent(),
    this.userId = const Value.absent(),
    this.description = const Value.absent(),
    this.createdDt = const Value.absent(),
    this.amount = const Value.absent(),
  });
  BankTransactionsCompanion.insert({
    this.id = const Value.absent(),
    @required int userId,
    this.description = const Value.absent(),
    @required DateTime createdDt,
    this.amount = const Value.absent(),
  })  : userId = Value(userId),
        createdDt = Value(createdDt);
  BankTransactionsCompanion copyWith(
      {Value<int> id,
      Value<int> userId,
      Value<String> description,
      Value<DateTime> createdDt,
      Value<int> amount}) {
    return BankTransactionsCompanion(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      description: description ?? this.description,
      createdDt: createdDt ?? this.createdDt,
      amount: amount ?? this.amount,
    );
  }
}

class $BankTransactionsTable extends BankTransactions
    with TableInfo<$BankTransactionsTable, BankTransaction> {
  final GeneratedDatabase _db;
  final String _alias;
  $BankTransactionsTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedIntColumn _id;
  @override
  GeneratedIntColumn get id => _id ??= _constructId();
  GeneratedIntColumn _constructId() {
    return GeneratedIntColumn('id', $tableName, false,
        hasAutoIncrement: true, declaredAsPrimaryKey: true);
  }

  final VerificationMeta _userIdMeta = const VerificationMeta('userId');
  GeneratedIntColumn _userId;
  @override
  GeneratedIntColumn get userId => _userId ??= _constructUserId();
  GeneratedIntColumn _constructUserId() {
    return GeneratedIntColumn(
      'user_id',
      $tableName,
      false,
    );
  }

  final VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  GeneratedTextColumn _description;
  @override
  GeneratedTextColumn get description =>
      _description ??= _constructDescription();
  GeneratedTextColumn _constructDescription() {
    return GeneratedTextColumn(
      'description',
      $tableName,
      true,
    );
  }

  final VerificationMeta _createdDtMeta = const VerificationMeta('createdDt');
  GeneratedDateTimeColumn _createdDt;
  @override
  GeneratedDateTimeColumn get createdDt => _createdDt ??= _constructCreatedDt();
  GeneratedDateTimeColumn _constructCreatedDt() {
    return GeneratedDateTimeColumn(
      'created_dt',
      $tableName,
      false,
    );
  }

  final VerificationMeta _amountMeta = const VerificationMeta('amount');
  GeneratedIntColumn _amount;
  @override
  GeneratedIntColumn get amount => _amount ??= _constructAmount();
  GeneratedIntColumn _constructAmount() {
    return GeneratedIntColumn('amount', $tableName, false,
        defaultValue: Constant(0));
  }

  @override
  List<GeneratedColumn> get $columns =>
      [id, userId, description, createdDt, amount];
  @override
  $BankTransactionsTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'bank_transactions';
  @override
  final String actualTableName = 'bank_transactions';
  @override
  VerificationContext validateIntegrity(BankTransactionsCompanion d,
      {bool isInserting = false}) {
    final context = VerificationContext();
    if (d.id.present) {
      context.handle(_idMeta, id.isAcceptableValue(d.id.value, _idMeta));
    }
    if (d.userId.present) {
      context.handle(
          _userIdMeta, userId.isAcceptableValue(d.userId.value, _userIdMeta));
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    if (d.description.present) {
      context.handle(_descriptionMeta,
          description.isAcceptableValue(d.description.value, _descriptionMeta));
    }
    if (d.createdDt.present) {
      context.handle(_createdDtMeta,
          createdDt.isAcceptableValue(d.createdDt.value, _createdDtMeta));
    } else if (isInserting) {
      context.missing(_createdDtMeta);
    }
    if (d.amount.present) {
      context.handle(
          _amountMeta, amount.isAcceptableValue(d.amount.value, _amountMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  BankTransaction map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return BankTransaction.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  Map<String, Variable> entityToSql(BankTransactionsCompanion d) {
    final map = <String, Variable>{};
    if (d.id.present) {
      map['id'] = Variable<int, IntType>(d.id.value);
    }
    if (d.userId.present) {
      map['user_id'] = Variable<int, IntType>(d.userId.value);
    }
    if (d.description.present) {
      map['description'] = Variable<String, StringType>(d.description.value);
    }
    if (d.createdDt.present) {
      map['created_dt'] = Variable<DateTime, DateTimeType>(d.createdDt.value);
    }
    if (d.amount.present) {
      map['amount'] = Variable<int, IntType>(d.amount.value);
    }
    return map;
  }

  @override
  $BankTransactionsTable createAlias(String alias) {
    return $BankTransactionsTable(_db, alias);
  }
}

class User extends DataClass implements Insertable<User> {
  final int id;
  final String emailAddress;
  User({@required this.id, @required this.emailAddress});
  factory User.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final intType = db.typeSystem.forDartType<int>();
    final stringType = db.typeSystem.forDartType<String>();
    return User(
      id: intType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      emailAddress: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}email_address']),
    );
  }
  factory User.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return User(
      id: serializer.fromJson<int>(json['id']),
      emailAddress: serializer.fromJson<String>(json['emailAddress']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'emailAddress': serializer.toJson<String>(emailAddress),
    };
  }

  @override
  UsersCompanion createCompanion(bool nullToAbsent) {
    return UsersCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      emailAddress: emailAddress == null && nullToAbsent
          ? const Value.absent()
          : Value(emailAddress),
    );
  }

  User copyWith({int id, String emailAddress}) => User(
        id: id ?? this.id,
        emailAddress: emailAddress ?? this.emailAddress,
      );
  @override
  String toString() {
    return (StringBuffer('User(')
          ..write('id: $id, ')
          ..write('emailAddress: $emailAddress')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(id.hashCode, emailAddress.hashCode));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is User &&
          other.id == this.id &&
          other.emailAddress == this.emailAddress);
}

class UsersCompanion extends UpdateCompanion<User> {
  final Value<int> id;
  final Value<String> emailAddress;
  const UsersCompanion({
    this.id = const Value.absent(),
    this.emailAddress = const Value.absent(),
  });
  UsersCompanion.insert({
    this.id = const Value.absent(),
    @required String emailAddress,
  }) : emailAddress = Value(emailAddress);
  UsersCompanion copyWith({Value<int> id, Value<String> emailAddress}) {
    return UsersCompanion(
      id: id ?? this.id,
      emailAddress: emailAddress ?? this.emailAddress,
    );
  }
}

class $UsersTable extends Users with TableInfo<$UsersTable, User> {
  final GeneratedDatabase _db;
  final String _alias;
  $UsersTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedIntColumn _id;
  @override
  GeneratedIntColumn get id => _id ??= _constructId();
  GeneratedIntColumn _constructId() {
    return GeneratedIntColumn('id', $tableName, false,
        hasAutoIncrement: true, declaredAsPrimaryKey: true);
  }

  final VerificationMeta _emailAddressMeta =
      const VerificationMeta('emailAddress');
  GeneratedTextColumn _emailAddress;
  @override
  GeneratedTextColumn get emailAddress =>
      _emailAddress ??= _constructEmailAddress();
  GeneratedTextColumn _constructEmailAddress() {
    return GeneratedTextColumn('email_address', $tableName, false,
        $customConstraints: 'UNIQUE');
  }

  @override
  List<GeneratedColumn> get $columns => [id, emailAddress];
  @override
  $UsersTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'users';
  @override
  final String actualTableName = 'users';
  @override
  VerificationContext validateIntegrity(UsersCompanion d,
      {bool isInserting = false}) {
    final context = VerificationContext();
    if (d.id.present) {
      context.handle(_idMeta, id.isAcceptableValue(d.id.value, _idMeta));
    }
    if (d.emailAddress.present) {
      context.handle(
          _emailAddressMeta,
          emailAddress.isAcceptableValue(
              d.emailAddress.value, _emailAddressMeta));
    } else if (isInserting) {
      context.missing(_emailAddressMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  User map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return User.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  Map<String, Variable> entityToSql(UsersCompanion d) {
    final map = <String, Variable>{};
    if (d.id.present) {
      map['id'] = Variable<int, IntType>(d.id.value);
    }
    if (d.emailAddress.present) {
      map['email_address'] = Variable<String, StringType>(d.emailAddress.value);
    }
    return map;
  }

  @override
  $UsersTable createAlias(String alias) {
    return $UsersTable(_db, alias);
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(SqlTypeSystem.defaultInstance, e);
  _$AppDatabase.connect(DatabaseConnection c) : super.connect(c);
  $BankTransactionsTable _bankTransactions;
  $BankTransactionsTable get bankTransactions =>
      _bankTransactions ??= $BankTransactionsTable(this);
  $UsersTable _users;
  $UsersTable get users => _users ??= $UsersTable(this);
  BankTransactionDao _bankTransactionDao;
  BankTransactionDao get bankTransactionDao =>
      _bankTransactionDao ??= BankTransactionDao(this as AppDatabase);
  UserDao _userDao;
  UserDao get userDao => _userDao ??= UserDao(this as AppDatabase);
  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [bankTransactions, users];
}

// **************************************************************************
// DaoGenerator
// **************************************************************************

mixin _$BankTransactionDaoMixin on DatabaseAccessor<AppDatabase> {
  $BankTransactionsTable get bankTransactions => db.bankTransactions;
}
mixin _$UserDaoMixin on DatabaseAccessor<AppDatabase> {
  $UsersTable get users => db.users;
}
