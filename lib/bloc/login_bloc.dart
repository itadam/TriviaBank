
import 'package:triviabank/bloc/authorization_bloc.dart';
import 'package:triviabank/data/app_database.dart';
import 'package:triviabank/data/user_repository.dart';
import 'package:triviabank/auth/login_validators.dart';
import 'package:observable/observable.dart';
import 'package:rxdart/rxdart.dart';

class LoginBloc extends LoginValidators {

  UserRepository repository = UserRepository();

  final BehaviorSubject _emailController = BehaviorSubject<String>();
  final BehaviorSubject _passwordController = BehaviorSubject<String>();
  final PublishSubject _loadingData = PublishSubject<bool>();
  Function(String) get changeEmail => _emailController.sink.add;
  Function(String) get changePassword => _passwordController.sink.add;
  Stream<String> get email => _emailController.stream.transform(validateEmail);
  Stream<String> get password => _passwordController.stream.transform(validatePassword);
  Stream<bool> get submitValid => Rx.combineLatest2(email, password, (email, password) => true);

  Stream<bool> get loading => _loadingData.stream;

  void submit() {

    final validEmail = _emailController.value;
    final validPassword = _passwordController.value;
    _loadingData.sink.add(true);
    login(validEmail, validPassword);
  }

  login(String email, String password) async {
    User userRecord = await repository.login(email, password); // At the moment this should always be returning a non-null value.
    _loadingData.sink.add(false);
    authBloc.openSession(userRecord.toJsonString());
  }

  void dispose() {

    _emailController.close();
    _passwordController.close();
    _loadingData.close();
  }
}