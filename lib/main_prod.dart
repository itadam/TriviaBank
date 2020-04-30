
import 'package:triviabank/main.dart' as App;
import 'package:triviabank/util/app_config.dart';

// call this directly for Production versions. Use -t or --target to specify lib/main_prod.dart as the target rather than the default "lib/main.dart".
void main() {
  App.launchApp(env: 'prod');
}