import 'package:integration_test/integration_test.dart';
import 'package:test/test.dart';
import 'package:flutter_driver/flutter_driver.dart' as FlutterDriver;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('end-to-end test', () {
    late FlutterDriver.FlutterDriver driver;

    setUpAll(() async {
      driver = await FlutterDriver.FlutterDriver.connect();
    });

    tearDownAll(() async {
      if (driver != null) {
        await driver.close();
      }
    });

    test('Add, read, update, and remove a source', () async {
      await driver
          .waitFor(FlutterDriver.find.byValueKey('bottom-navigation-bar'));
      // const MethodChannel channel =
      //     MethodChannel('plugins.flutter.io/image_picker');

      // channel.setMockMethodCallHandler((MethodCall methodCall) async {
      //   ByteData data = await rootBundle.load('images/sample.png');
      //   Uint8List bytes = data.buffer.asUint8List();
      //   Directory tempDir = await getTemporaryDirectory();
      //   File file = await File(
      //     '${tempDir.path}/tmp.tmp',
      //   ).writeAsBytes(bytes);
      //   return file.path;
      // });

      // await driver
      //     .waitFor(find.byType(BottomNavigationBarItem) as SerializableFinder);

      // await tester.tap(find.byType(TextField));

      // await tester.enterText(find.byType(TextField), const Uuid().v1());

      // await tester.tap(find.byIcon(Icons.photo_camera));

      // await tester.tap(find.byIcon(Icons.save));
    });
  });
}
