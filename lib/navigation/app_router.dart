import 'package:flutter/material.dart';
import '../screens/login_screen.dart';
import '../screens/signup_screen.dart';
import '../screens/home_screen.dart';
import '../screens/professors_screen.dart';
import '../screens/departments_screen.dart';
import '../screens/calendar_screen.dart';
import '../screens/roadmaps_screen.dart';
import '../screens/profile_screen.dart';
import '../screens/help_screen.dart';
import '../screens/about_screen.dart';
import '../screens/search_page.dart';
import '../screens/indoor_view_page.dart';


class AppRouter {
  static const String loginRoute = '/login';
  static const String signupRoute = '/signup';
  static const String homeRoute = '/';
  static const String professorsRoute = '/professors';
  static const String departmentsRoute = '/departments';
  static const String calendarRoute = '/calendar';
  static const String roadmapsRoute = '/roadmaps';
  static const String profileRoute = '/profile';
  static const String helpRoute = '/help';
  static const String aboutRoute = '/about';
  static const String searchRoute = '/search';
  static const String indoorViewRoute = '/indoor-view';


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
      case searchRoute:
        return MaterialPageRoute(builder: (_) => const SearchPage());
      case indoorViewRoute:
        return MaterialPageRoute(builder: (_) => const IndoorViewPage());
      case profileRoute:
        return MaterialPageRoute(
          builder: (_) => const ProfileScreen(),
        );
      case helpRoute:
        return MaterialPageRoute(
          builder: (_) => const HelpScreen(),
        );
      case aboutRoute:
        return MaterialPageRoute(
          builder: (_) => const AboutScreen(),
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