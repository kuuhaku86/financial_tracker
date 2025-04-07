import 'package:flutter_driver/driver_extension.dart'
    show enableFlutterDriverExtension;
import 'package:financial_tracker/main.dart' as app;

void main() {
  enableFlutterDriverExtension();

  app.main();
}
