
import 'package:flutter/material.dart';
import 'package:triviabank/data/app_database.dart';

extension CalculateAccountTotals on List<BankTransaction> {

  num computeTotalCents() {
    num result = 0;
    this.forEach((t) => result += t.amount);
    return result;
  }
}

extension CalculateUserBankBalanceProperties on num {

  String userDifficultyLevel() {
    if (this >= 10 ^ 4) {
      return 'hard';
    }
    return 'easy';
  }

  Color bankAccountBalanceColor() {
    if (this >= 10 ^ 8) {
      return Colors.green;
    } else if (this >= 10 ^ 6) {
      return Colors.blueGrey;
    } else if (this >= 10 ^ 4) {
      return Colors.lightGreen;
    }
    return Colors.red;
  }
}