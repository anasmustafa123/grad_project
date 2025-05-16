import 'package:flutter/material.dart';
import '../widgets/header/header_widget.dart';
import 'home/components/navigation_icons.dart';
import 'departments/components/department_card.dart';
import 'departments/components/department_filter_menu.dart';

class DepartmentsScreen extends StatefulWidget {
  const DepartmentsScreen({super.key});

  @override
  State<DepartmentsScreen> createState() => _DepartmentsScreenState();
}

class _DepartmentsScreenState extends State<DepartmentsScreen> {
  String? selectedCategory;
  final List<String> categories = [
    'Core Engineering',
    'Specialized Engineering',
  ];

  // Sample department data
  final List<Map<String, dynamic>> departments = [
    {
      'name': 'Computer Engineering',
      'description': 'Focuses on the design and development of computer systems and networks.',
      'head': 'Dr. Ahmed Hassan',
      'location': 'Engineering Building A, Floor 3',
      'icon': Icons.computer,
      'category': 'Core Engineering',
    },
    {
      'name': 'Electrical Engineering',
      'description': 'Deals with the study and application of electricity, electronics, and electromagnetism.',
      'head': 'Dr. Sarah Mohamed',
      'location': 'Engineering Building B, Floor 2',
      'icon': Icons.electric_bolt,
      'category': 'Core Engineering',
    },
    {
      'name': 'Mechanical Engineering',
      'description': 'Focuses on the design, analysis, and manufacturing of mechanical systems.',
      'head': 'Dr. Mohamed Ali',
      'location': 'Engineering Building C, Floor 1',
      'icon': Icons.engineering,
      'category': 'Core Engineering',
    },
    {
      'name': 'Biomedical Engineering',
      'description': 'Combines engineering principles with medical and biological sciences.',
      'head': 'Dr. Fatima Ahmed',
      'location': 'Engineering Building D, Floor 2',
      'icon': Icons.medical_services,
      'category': 'Specialized Engineering',
    },
    {
      'name': 'Aerospace Engineering',
      'description': 'Focuses on the development of aircraft and spacecraft.',
      'head': 'Dr. Omar Khalid',
      'location': 'Engineering Building E, Floor 3',
      'icon': Icons.airplanemode_active,
      'category': 'Specialized Engineering',
    },
  ];

  List<Map<String, dynamic>> get filteredDepartments {
    if (selectedCategory == null || selectedCategory == 'all') {
      return departments;
    }
    return departments.where((dept) => dept['category'] == selectedCategory).toList();
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
                        DepartmentFilterMenu(
                          categories: categories,
                          onFilterChanged: (category) {
                            setState(() {
                              selectedCategory = category;
                            });
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    ...filteredDepartments.map((department) => Padding(
                          padding: const EdgeInsets.only(bottom: 16.0),
                          child: DepartmentCard(
                            name: department['name']!,
                            description: department['description']!,
                            head: department['head']!,
                            location: department['location']!,
                            icon: department['icon']!,
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