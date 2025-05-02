import 'package:flutter/material.dart';
import '../widgets/header/header_widget.dart';
import '../widgets/footer/footer_widget.dart';
import 'home/components/navigation_icons.dart';
import 'professors/components/professor_card.dart';
import 'professors/components/filter_menu.dart';

class ProfessorsScreen extends StatefulWidget {
  const ProfessorsScreen({super.key});

  @override
  State<ProfessorsScreen> createState() => _ProfessorsScreenState();
}

class _ProfessorsScreenState extends State<ProfessorsScreen> {
  String? selectedDepartment;
  final List<String> departments = [
    'Computer Engineering',
    'Electrical Engineering',
    'Mechanical Engineering',
    'Civil Engineering',
    'Chemical Engineering',
    'Industrial Engineering',
    'Aerospace Engineering',
    'Biomedical Engineering',
  ];

  // Sample professor data
  final List<Map<String, String>> professors = [
    {
      'name': 'Dr. Ahmed Hassan',
      'department': 'Computer Engineering',
      'email': 'ahmed.hassan@university.edu',
      'office': 'Building A, Room 101',
      'imageUrl': 'https://via.placeholder.com/150',
    },
    {
      'name': 'Dr. Sarah Mohamed',
      'department': 'Electrical Engineering',
      'email': 'sarah.mohamed@university.edu',
      'office': 'Building B, Room 205',
      'imageUrl': 'https://via.placeholder.com/150',
    },
    {
      'name': 'Dr. Mohamed Ali',
      'department': 'Mechanical Engineering',
      'email': 'mohamed.ali@university.edu',
      'office': 'Building C, Room 310',
      'imageUrl': 'https://via.placeholder.com/150',
    },
  ];

  List<Map<String, String>> get filteredProfessors {
    if (selectedDepartment == null || selectedDepartment == 'all') {
      return professors;
    }
    return professors.where((prof) => prof['department'] == selectedDepartment).toList();
  }

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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        FilterMenu(
                          departments: departments,
                          onFilterChanged: (department) {
                            setState(() {
                              selectedDepartment = department;
                            });
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    ...filteredProfessors.map((professor) => Padding(
                          padding: const EdgeInsets.only(bottom: 16.0),
                          child: ProfessorCard(
                            name: professor['name']!,
                            department: professor['department']!,
                            email: professor['email']!,
                            office: professor['office']!,
                            imageUrl: professor['imageUrl']!,
                          ),
                        )),
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