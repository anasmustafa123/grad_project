import 'package:flutter/material.dart';
import '../screens/login_screen.dart';
import '../screens/signup_screen.dart';
import '../screens/home_screen.dart';
import '../screens/professors_screen.dart';
import '../screens/departments_screen.dart';
import '../screens/calendar_screen.dart';
import '../screens/roadmaps_screen.dart';

class AppRouter {
  static const String loginRoute = '/login';
  static const String signupRoute = '/signup';
  static const String homeRoute = '/';
  static const String professorsRoute = '/professors';
  static const String departmentsRoute = '/departments';
  static const String calendarRoute = '/calendar';
  static const String roadmapsRoute = '/roadmaps';
  
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case loginRoute:
        return MaterialPageRoute(
          builder: (_) => const LoginScreen(),
        );
      case signupRoute:
        return MaterialPageRoute(
          builder: (_) => const SignupScreen(),
        );
      case homeRoute:
        return MaterialPageRoute(
          builder: (_) => const HomeScreen(),
        );
      case professorsRoute:
        return MaterialPageRoute(
          builder: (_) => const ProfessorsScreen(),
        );
      case departmentsRoute:
        return MaterialPageRoute(
          builder: (_) => const DepartmentsScreen(),
        );
      case calendarRoute:
        return MaterialPageRoute(
          builder: (_) => const CalendarScreen(),
        );
      case roadmapsRoute:
        return MaterialPageRoute(
          builder: (_) => const RoadmapsScreen(),
        );
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