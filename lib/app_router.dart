import 'package:flutter/material.dart';
import 'package:secndversion_of_gradproj/screens/home_screen.dart';
import 'package:secndversion_of_gradproj/screens/professors_screen.dart';
import 'package:secndversion_of_gradproj/screens/departments_screen.dart';

class AppRouter {
  static const String homeRoute = '/';
  static const String professorsRoute = '/professors';
  static const String departmentsRoute = '/departments';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case homeRoute:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      case professorsRoute:
        return MaterialPageRoute(builder: (_) => const ProfessorsScreen());
      case departmentsRoute:
        return MaterialPageRoute(builder: (_) => const DepartmentsScreen());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
} 