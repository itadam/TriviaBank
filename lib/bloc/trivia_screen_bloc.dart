
import 'package:triviabank/bloc/authorization_bloc.dart';
import 'package:triviabank/data/app_database.dart';

class TriviaScreenBloc {

  AppDatabase get appDatabase => AppDatabase();

  BankTransactionDao get transactionDao => appDatabase.bankTransactionDao;



  void dispose() {
    appDatabase.close();
  }
}