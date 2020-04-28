
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:triviabank/bloc/home/home_status.dart';
import 'package:triviabank/data/app_database.dart';

class HomeState extends Equatable {

  final HomeStatus homeStatus;
  final String error;
  final List<BankTransaction> bankTransactionList;
  final num bankBalance;

  const HomeState({this.homeStatus, this.error, this.bankTransactionList, this.bankBalance});

  HomeState mergeWith({
    HomeStatus homeStatus,
    String error,
    List<BankTransaction> bankTransactionList,
    num bankBalance
  }) {
    return HomeState(
      homeStatus: homeStatus ?? this.homeStatus,
      error: error ?? this.error,
      bankTransactionList: bankTransactionList ?? this.bankTransactionList,
      bankBalance: bankBalance ?? this.bankBalance
    );
  }

  @override
  List<Object> get props => [homeStatus,error,bankTransactionList,bankBalance];
}