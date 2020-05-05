
import 'dart:async';
import 'dart:math';

import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_device_type/flutter_device_type.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:triviabank/bloc/home/home_state.dart';
import 'package:triviabank/bloc/trivia_screen/trivia_screen_bloc.dart';
import 'package:triviabank/bloc/trivia_screen/trivia_screen_state.dart';
import 'package:triviabank/data/app_database.dart';
import 'package:triviabank/ui/trivia_question_card.dart';
import 'package:triviabank/ui/trivia_screen_phone_state.dart';
import 'package:triviabank/ui/trivia_screen_tablet_state.dart';
import 'package:triviabank/util/am_localizations.dart';
import 'package:flutter/material.dart';
import 'package:triviabank/util/app_config.dart';
import 'package:triviabank/util/orientation_helper.dart';

class TriviaScreen extends StatefulWidget {

  final User user;
  final HomeState homeState;

  TriviaScreen({Key key, this.user, this.homeState}) : super(key: key);

  @override
  State<StatefulWidget> createState() => Device.get().isPhone ? TriviaScreenPhoneState() : TriviaScreenTabletState();

}