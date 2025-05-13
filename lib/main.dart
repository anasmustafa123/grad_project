import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:secndversion_of_gradproj/firebase_options.dart';
import 'app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
} 