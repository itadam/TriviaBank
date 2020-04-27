
import 'package:triviabank/bloc/authorization_bloc.dart';
import 'package:triviabank/data/app_database.dart';

class HomeBloc {

  AppDatabase get appDatabase => AppDatabase();

  BankTransactionDao get transactionDao => appDatabase.bankTransactionDao;

  logoutUser() {
    authBloc.closeSession();
  }

  void dispose() {
    appDatabase.close();
  }
}