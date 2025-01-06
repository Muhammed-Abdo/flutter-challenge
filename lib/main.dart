import 'package:flutter/material.dart';
import 'package:flutter_challenge/app/app.dart';
import 'package:flutter_challenge/app/di.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  initAppModule();
  runApp(const MyApp());
}
