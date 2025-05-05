import 'package:flutter/material.dart';
import '../widgets/header/header_widget.dart';
import 'home/components/navigation_icons.dart';
import 'home/components/home_card.dart';
import 'home/components/status_card.dart';
import '../navigation/app_router.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          const HeaderWidget(),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    const StatusCard(),
                    const SizedBox(height: 20),
                    GridView.count(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      crossAxisCount: 2,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                      children: [
                        HomeCard(
                          title: 'Professors',
                          icon: Icons.school,
                          onTap: () {
                            Navigator.pushNamed(context, AppRouter.professorsRoute);
                          },
                        ),
                        HomeCard(
                          title: 'Departments',
                          icon: Icons.business,
                          onTap: () {
                            Navigator.pushNamed(context, AppRouter.departmentsRoute);
                          },
                        ),
                        HomeCard(
                          title: 'Roadmaps',
                          icon: Icons.route,
                          onTap: () {
                            Navigator.pushNamed(context, AppRouter.roadmapsRoute);
                          },
                        ),
                        HomeCard(
                          title: 'Timetable',
                          icon: Icons.calendar_today,
                          onTap: () {
                            Navigator.pushNamed(context, AppRouter.calendarRoute);
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            height: 80,
            decoration: const BoxDecoration(
              color: Color(0xFFA5D7C2),
            ),
            child: const NavigationIcons(),
          ),
        ],
      ),
    );
  }
} 