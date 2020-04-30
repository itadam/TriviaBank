// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TriviaQuestions _$TriviaQuestionsFromJson(Map<String, dynamic> json) {
  return TriviaQuestions();
}

Map<String, dynamic> _$TriviaQuestionsToJson(TriviaQuestions instance) =>
    <String, dynamic>{};

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
    this.createdDt = const Value.absent(),
    this.amount = const Value.absent(),
  }) : userId = Value(userId);
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
    return GeneratedDateTimeColumn('created_dt', $tableName, false,
        defaultValue: Constant(DateTime.now()));
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

class TriviaQuestion extends DataClass implements Insertable<TriviaQuestion> {
  final int id;
  final int userId;
  final DateTime createdDt;
  final int correctlyAnswered;
  final String category;
  final String difficulty;
  final String type;
  final String question;
  final String correctAnswer;
  final List<String> incorrectAnswers;
  TriviaQuestion(
      {@required this.id,
      @required this.userId,
      @required this.createdDt,
      @required this.correctlyAnswered,
      this.category,
      this.difficulty,
      this.type,
      this.question,
      this.correctAnswer,
      this.incorrectAnswers});
  factory TriviaQuestion.fromData(
      Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final intType = db.typeSystem.forDartType<int>();
    final dateTimeType = db.typeSystem.forDartType<DateTime>();
    final stringType = db.typeSystem.forDartType<String>();
    return TriviaQuestion(
      id: intType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      userId:
          intType.mapFromDatabaseResponse(data['${effectivePrefix}user_id']),
      createdDt: dateTimeType
          .mapFromDatabaseResponse(data['${effectivePrefix}created_dt']),
      correctlyAnswered: intType.mapFromDatabaseResponse(
          data['${effectivePrefix}correctly_answered']),
      category: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}category']),
      difficulty: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}difficulty']),
      type: stringType.mapFromDatabaseResponse(data['${effectivePrefix}type']),
      question: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}question']),
      correctAnswer: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}correct_answer']),
      incorrectAnswers: $TriviaQuestionsTable.$converter0.mapToDart(
          stringType.mapFromDatabaseResponse(
              data['${effectivePrefix}incorrect_answers'])),
    );
  }
  factory TriviaQuestion.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return TriviaQuestion(
      id: serializer.fromJson<int>(json['id']),
      userId: serializer.fromJson<int>(json['userId']),
      createdDt: serializer.fromJson<DateTime>(json['createdDt']),
      correctlyAnswered: serializer.fromJson<int>(json['correctlyAnswered']),
      category: serializer.fromJson<String>(json['category']),
      difficulty: serializer.fromJson<String>(json['difficulty']),
      type: serializer.fromJson<String>(json['type']),
      question: serializer.fromJson<String>(json['question']),
      correctAnswer: serializer.fromJson<String>(json['correctAnswer']),
      incorrectAnswers:
          serializer.fromJson<List<String>>(json['incorrectAnswers']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'userId': serializer.toJson<int>(userId),
      'createdDt': serializer.toJson<DateTime>(createdDt),
      'correctlyAnswered': serializer.toJson<int>(correctlyAnswered),
      'category': serializer.toJson<String>(category),
      'difficulty': serializer.toJson<String>(difficulty),
      'type': serializer.toJson<String>(type),
      'question': serializer.toJson<String>(question),
      'correctAnswer': serializer.toJson<String>(correctAnswer),
      'incorrectAnswers': serializer.toJson<List<String>>(incorrectAnswers),
    };
  }

  @override
  TriviaQuestionsCompanion createCompanion(bool nullToAbsent) {
    return TriviaQuestionsCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      userId:
          userId == null && nullToAbsent ? const Value.absent() : Value(userId),
      createdDt: createdDt == null && nullToAbsent
          ? const Value.absent()
          : Value(createdDt),
      correctlyAnswered: correctlyAnswered == null && nullToAbsent
          ? const Value.absent()
          : Value(correctlyAnswered),
      category: category == null && nullToAbsent
          ? const Value.absent()
          : Value(category),
      difficulty: difficulty == null && nullToAbsent
          ? const Value.absent()
          : Value(difficulty),
      type: type == null && nullToAbsent ? const Value.absent() : Value(type),
      question: question == null && nullToAbsent
          ? const Value.absent()
          : Value(question),
      correctAnswer: correctAnswer == null && nullToAbsent
          ? const Value.absent()
          : Value(correctAnswer),
      incorrectAnswers: incorrectAnswers == null && nullToAbsent
          ? const Value.absent()
          : Value(incorrectAnswers),
    );
  }

  TriviaQuestion copyWith(
          {int id,
          int userId,
          DateTime createdDt,
          int correctlyAnswered,
          String category,
          String difficulty,
          String type,
          String question,
          String correctAnswer,
          List<String> incorrectAnswers}) =>
      TriviaQuestion(
        id: id ?? this.id,
        userId: userId ?? this.userId,
        createdDt: createdDt ?? this.createdDt,
        correctlyAnswered: correctlyAnswered ?? this.correctlyAnswered,
        category: category ?? this.category,
        difficulty: difficulty ?? this.difficulty,
        type: type ?? this.type,
        question: question ?? this.question,
        correctAnswer: correctAnswer ?? this.correctAnswer,
        incorrectAnswers: incorrectAnswers ?? this.incorrectAnswers,
      );
  @override
  String toString() {
    return (StringBuffer('TriviaQuestion(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('createdDt: $createdDt, ')
          ..write('correctlyAnswered: $correctlyAnswered, ')
          ..write('category: $category, ')
          ..write('difficulty: $difficulty, ')
          ..write('type: $type, ')
          ..write('question: $question, ')
          ..write('correctAnswer: $correctAnswer, ')
          ..write('incorrectAnswers: $incorrectAnswers')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      id.hashCode,
      $mrjc(
          userId.hashCode,
          $mrjc(
              createdDt.hashCode,
              $mrjc(
                  correctlyAnswered.hashCode,
                  $mrjc(
                      category.hashCode,
                      $mrjc(
                          difficulty.hashCode,
                          $mrjc(
                              type.hashCode,
                              $mrjc(
                                  question.hashCode,
                                  $mrjc(correctAnswer.hashCode,
                                      incorrectAnswers.hashCode))))))))));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is TriviaQuestion &&
          other.id == this.id &&
          other.userId == this.userId &&
          other.createdDt == this.createdDt &&
          other.correctlyAnswered == this.correctlyAnswered &&
          other.category == this.category &&
          other.difficulty == this.difficulty &&
          other.type == this.type &&
          other.question == this.question &&
          other.correctAnswer == this.correctAnswer &&
          other.incorrectAnswers == this.incorrectAnswers);
}

class TriviaQuestionsCompanion extends UpdateCompanion<TriviaQuestion> {
  final Value<int> id;
  final Value<int> userId;
  final Value<DateTime> createdDt;
  final Value<int> correctlyAnswered;
  final Value<String> category;
  final Value<String> difficulty;
  final Value<String> type;
  final Value<String> question;
  final Value<String> correctAnswer;
  final Value<List<String>> incorrectAnswers;
  const TriviaQuestionsCompanion({
    this.id = const Value.absent(),
    this.userId = const Value.absent(),
    this.createdDt = const Value.absent(),
    this.correctlyAnswered = const Value.absent(),
    this.category = const Value.absent(),
    this.difficulty = const Value.absent(),
    this.type = const Value.absent(),
    this.question = const Value.absent(),
    this.correctAnswer = const Value.absent(),
    this.incorrectAnswers = const Value.absent(),
  });
  TriviaQuestionsCompanion.insert({
    this.id = const Value.absent(),
    @required int userId,
    this.createdDt = const Value.absent(),
    this.correctlyAnswered = const Value.absent(),
    this.category = const Value.absent(),
    this.difficulty = const Value.absent(),
    this.type = const Value.absent(),
    this.question = const Value.absent(),
    this.correctAnswer = const Value.absent(),
    this.incorrectAnswers = const Value.absent(),
  }) : userId = Value(userId);
  TriviaQuestionsCompanion copyWith(
      {Value<int> id,
      Value<int> userId,
      Value<DateTime> createdDt,
      Value<int> correctlyAnswered,
      Value<String> category,
      Value<String> difficulty,
      Value<String> type,
      Value<String> question,
      Value<String> correctAnswer,
      Value<List<String>> incorrectAnswers}) {
    return TriviaQuestionsCompanion(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      createdDt: createdDt ?? this.createdDt,
      correctlyAnswered: correctlyAnswered ?? this.correctlyAnswered,
      category: category ?? this.category,
      difficulty: difficulty ?? this.difficulty,
      type: type ?? this.type,
      question: question ?? this.question,
      correctAnswer: correctAnswer ?? this.correctAnswer,
      incorrectAnswers: incorrectAnswers ?? this.incorrectAnswers,
    );
  }
}

class $TriviaQuestionsTable extends TriviaQuestions
    with TableInfo<$TriviaQuestionsTable, TriviaQuestion> {
  final GeneratedDatabase _db;
  final String _alias;
  $TriviaQuestionsTable(this._db, [this._alias]);
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

  final VerificationMeta _createdDtMeta = const VerificationMeta('createdDt');
  GeneratedDateTimeColumn _createdDt;
  @override
  GeneratedDateTimeColumn get createdDt => _createdDt ??= _constructCreatedDt();
  GeneratedDateTimeColumn _constructCreatedDt() {
    return GeneratedDateTimeColumn('created_dt', $tableName, false,
        defaultValue: Constant(DateTime.now()));
  }

  final VerificationMeta _correctlyAnsweredMeta =
      const VerificationMeta('correctlyAnswered');
  GeneratedIntColumn _correctlyAnswered;
  @override
  GeneratedIntColumn get correctlyAnswered =>
      _correctlyAnswered ??= _constructCorrectlyAnswered();
  GeneratedIntColumn _constructCorrectlyAnswered() {
    return GeneratedIntColumn('correctly_answered', $tableName, false,
        defaultValue: Constant(0));
  }

  final VerificationMeta _categoryMeta = const VerificationMeta('category');
  GeneratedTextColumn _category;
  @override
  GeneratedTextColumn get category => _category ??= _constructCategory();
  GeneratedTextColumn _constructCategory() {
    return GeneratedTextColumn(
      'category',
      $tableName,
      true,
    );
  }

  final VerificationMeta _difficultyMeta = const VerificationMeta('difficulty');
  GeneratedTextColumn _difficulty;
  @override
  GeneratedTextColumn get difficulty => _difficulty ??= _constructDifficulty();
  GeneratedTextColumn _constructDifficulty() {
    return GeneratedTextColumn(
      'difficulty',
      $tableName,
      true,
    );
  }

  final VerificationMeta _typeMeta = const VerificationMeta('type');
  GeneratedTextColumn _type;
  @override
  GeneratedTextColumn get type => _type ??= _constructType();
  GeneratedTextColumn _constructType() {
    return GeneratedTextColumn(
      'type',
      $tableName,
      true,
    );
  }

  final VerificationMeta _questionMeta = const VerificationMeta('question');
  GeneratedTextColumn _question;
  @override
  GeneratedTextColumn get question => _question ??= _constructQuestion();
  GeneratedTextColumn _constructQuestion() {
    return GeneratedTextColumn(
      'question',
      $tableName,
      true,
    );
  }

  final VerificationMeta _correctAnswerMeta =
      const VerificationMeta('correctAnswer');
  GeneratedTextColumn _correctAnswer;
  @override
  GeneratedTextColumn get correctAnswer =>
      _correctAnswer ??= _constructCorrectAnswer();
  GeneratedTextColumn _constructCorrectAnswer() {
    return GeneratedTextColumn(
      'correct_answer',
      $tableName,
      true,
    );
  }

  final VerificationMeta _incorrectAnswersMeta =
      const VerificationMeta('incorrectAnswers');
  GeneratedTextColumn _incorrectAnswers;
  @override
  GeneratedTextColumn get incorrectAnswers =>
      _incorrectAnswers ??= _constructIncorrectAnswers();
  GeneratedTextColumn _constructIncorrectAnswers() {
    return GeneratedTextColumn(
      'incorrect_answers',
      $tableName,
      true,
    );
  }

  @override
  List<GeneratedColumn> get $columns => [
        id,
        userId,
        createdDt,
        correctlyAnswered,
        category,
        difficulty,
        type,
        question,
        correctAnswer,
        incorrectAnswers
      ];
  @override
  $TriviaQuestionsTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'trivia_questions';
  @override
  final String actualTableName = 'trivia_questions';
  @override
  VerificationContext validateIntegrity(TriviaQuestionsCompanion d,
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
    if (d.createdDt.present) {
      context.handle(_createdDtMeta,
          createdDt.isAcceptableValue(d.createdDt.value, _createdDtMeta));
    }
    if (d.correctlyAnswered.present) {
      context.handle(
          _correctlyAnsweredMeta,
          correctlyAnswered.isAcceptableValue(
              d.correctlyAnswered.value, _correctlyAnsweredMeta));
    }
    if (d.category.present) {
      context.handle(_categoryMeta,
          category.isAcceptableValue(d.category.value, _categoryMeta));
    }
    if (d.difficulty.present) {
      context.handle(_difficultyMeta,
          difficulty.isAcceptableValue(d.difficulty.value, _difficultyMeta));
    }
    if (d.type.present) {
      context.handle(
          _typeMeta, type.isAcceptableValue(d.type.value, _typeMeta));
    }
    if (d.question.present) {
      context.handle(_questionMeta,
          question.isAcceptableValue(d.question.value, _questionMeta));
    }
    if (d.correctAnswer.present) {
      context.handle(
          _correctAnswerMeta,
          correctAnswer.isAcceptableValue(
              d.correctAnswer.value, _correctAnswerMeta));
    }
    context.handle(_incorrectAnswersMeta, const VerificationResult.success());
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  TriviaQuestion map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return TriviaQuestion.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  Map<String, Variable> entityToSql(TriviaQuestionsCompanion d) {
    final map = <String, Variable>{};
    if (d.id.present) {
      map['id'] = Variable<int, IntType>(d.id.value);
    }
    if (d.userId.present) {
      map['user_id'] = Variable<int, IntType>(d.userId.value);
    }
    if (d.createdDt.present) {
      map['created_dt'] = Variable<DateTime, DateTimeType>(d.createdDt.value);
    }
    if (d.correctlyAnswered.present) {
      map['correctly_answered'] =
          Variable<int, IntType>(d.correctlyAnswered.value);
    }
    if (d.category.present) {
      map['category'] = Variable<String, StringType>(d.category.value);
    }
    if (d.difficulty.present) {
      map['difficulty'] = Variable<String, StringType>(d.difficulty.value);
    }
    if (d.type.present) {
      map['type'] = Variable<String, StringType>(d.type.value);
    }
    if (d.question.present) {
      map['question'] = Variable<String, StringType>(d.question.value);
    }
    if (d.correctAnswer.present) {
      map['correct_answer'] =
          Variable<String, StringType>(d.correctAnswer.value);
    }
    if (d.incorrectAnswers.present) {
      final converter = $TriviaQuestionsTable.$converter0;
      map['incorrect_answers'] = Variable<String, StringType>(
          converter.mapToSql(d.incorrectAnswers.value));
    }
    return map;
  }

  @override
  $TriviaQuestionsTable createAlias(String alias) {
    return $TriviaQuestionsTable(_db, alias);
  }

  static TypeConverter<List<String>, String> $converter0 =
      const StringListJsonConverter();
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
  $TriviaQuestionsTable _triviaQuestions;
  $TriviaQuestionsTable get triviaQuestions =>
      _triviaQuestions ??= $TriviaQuestionsTable(this);
  $UsersTable _users;
  $UsersTable get users => _users ??= $UsersTable(this);
  BankTransactionDao _bankTransactionDao;
  BankTransactionDao get bankTransactionDao =>
      _bankTransactionDao ??= BankTransactionDao(this as AppDatabase);
  TriviaQuestionDao _triviaQuestionDao;
  TriviaQuestionDao get triviaQuestionDao =>
      _triviaQuestionDao ??= TriviaQuestionDao(this as AppDatabase);
  UserDao _userDao;
  UserDao get userDao => _userDao ??= UserDao(this as AppDatabase);
  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [bankTransactions, triviaQuestions, users];
}

// **************************************************************************
// DaoGenerator
// **************************************************************************

mixin _$BankTransactionDaoMixin on DatabaseAccessor<AppDatabase> {
  $BankTransactionsTable get bankTransactions => db.bankTransactions;
}
mixin _$TriviaQuestionDaoMixin on DatabaseAccessor<AppDatabase> {
  $TriviaQuestionsTable get triviaQuestions => db.triviaQuestions;
}
mixin _$UserDaoMixin on DatabaseAccessor<AppDatabase> {
  $UsersTable get users => db.users;
}
