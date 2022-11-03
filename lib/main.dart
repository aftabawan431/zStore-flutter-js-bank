import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'dependency_injection.dart' as di;
import 'my_app.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(
    DevicePreview(
      builder: (context) => const MyApp(),
      enabled: false,
    ),
  );
}