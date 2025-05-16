import 'package:flutter/material.dart';
import 'calendar_screen.dart';

class InputMenuPage extends StatefulWidget {
  const InputMenuPage({super.key});

  @override
  State<InputMenuPage> createState() => _InputMenuPageState();
}

class _InputMenuPageState extends State<InputMenuPage> {
  final List<String> _departments = ['Computer Engineering', 'Electrical Engineering', 'Mechanical Engineering'];
  final List<String> _semesters = ['Semester 1', 'Semester 2', 'Semester 3'];

  final Map<String, List<String>> _semesterCourses = {
    'Semester 1': ['Introduction to Programming', 'Mathematics I', 'Physics I'],
    'Semester 2': ['Data Structures', 'Mathematics II', 'Physics II'],
    'Semester 3': ['Algorithms', 'Electronics I', 'Computer Architecture'],
  };

  String? _selectedDepartment;
  String? _selectedSemester;
  String? _selectedCourse;
  List<String> _selectedCourses = [];

  List<String> _availableCourses = [];

  double _densityValue = 1; // Default is Medium
  final List<String> _densityLabels = ['Low', 'Medium', 'High'];

  double _timePreference = 1;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Input Menu'),
        backgroundColor: const Color(0xFFA5D7C2),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Department Dropdown
            DropdownButtonFormField<String>(
              decoration:  InputDecoration(
                labelText: 'Select Department',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(40.0), // Rounded corners
                  )
              ),
              value: _selectedDepartment,
              items: _departments.map((dept) {
                return DropdownMenuItem<String>(
                  value: dept,
                  child: Text(dept),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _selectedDepartment = value;
                });
              },
            ),
            const SizedBox(height: 20),

            // Semester Dropdown
            DropdownButtonFormField<String>(
              decoration: InputDecoration(
                labelText: 'Select Semester',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(40.0), // Rounded corners
                  )

              ),
              value: _selectedSemester,
              items: _semesters.map((sem) {
                return DropdownMenuItem<String>(
                  value: sem,
                  child: Text(sem),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _selectedSemester = value;
                  _availableCourses = _semesterCourses[value] ?? [];
                  _selectedCourse = null; // reset selected course
                });
              },
            ),
            const SizedBox(height: 20),

            // Course Dropdown
            DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  labelText: 'Select course',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(40.0), // Rounded corners
                  ),
                ),
              value: _selectedCourse,
              items: _availableCourses.map((course) {
                return DropdownMenuItem<String>(
                  value: course,
                  child: Text(course),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _selectedCourse = value;
                  if (value != null && !_selectedCourses.contains(value)) {
                    _selectedCourses.add(value);
                  }
                });
              },
            ),
            const SizedBox(height: 30),

// Course Density Slider
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Course Density',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Slider(
                  value: _densityValue,
                  min: 0,
                  max: 2,
                  divisions: 2,
                  label: _densityLabels[_densityValue.toInt()],
                  activeColor: const Color(0xFF104B63), // <- custom color
                  onChanged: (value) {
                    setState(() {
                      _densityValue = value;
                    });
                  },
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text('Low'),
                    Text('Medium'),
                    Text('High'),
                  ],
                ),
              ],
            ),

            const SizedBox(height: 30),

// Time Preference Slider
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Time Preference',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Slider(
                  value: _timePreference,
                  min: 0,
                  max: 1,
                  divisions: 1,
                  label: _timePreference == 0 ? 'Early' : 'Late',
                  activeColor: const Color(0xFF104B63), // <- custom color
                  onChanged: (value) {
                    setState(() {
                      _timePreference = value;
                    });
                  },
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text('Early'),
                    Text('Late'),
                  ],
                ),
              ],
            ),

            const SizedBox(height: 30),
            const Text(
              'Selected Courses',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Wrap(
              spacing: 8.0,
              runSpacing: 8.0,
              children: _selectedCourses.map((course) {
                return Chip(
                  label: Text(course),
                  deleteIcon: const Icon(Icons.close),
                  onDeleted: () {
                    setState(() {
                      _selectedCourses.remove(course);
                    });
                  },
                  backgroundColor: const Color(0xFFA5D7C2),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                    side: const BorderSide(color: Color(0xFF104B63)),
                  ),
                );
              }).toList(),

            ),
            const SizedBox(height: 30),

            ElevatedButton(
                onPressed: () {
                  if (_selectedCourses.isEmpty) {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text("No Courses Selected"),
                        content: const Text("Please select at least one course before scheduling."),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.of(context).pop(),
                            child: const Text("OK"),
                          ),
                        ],
                      ),
                    );
                  } else {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CalendarScreen(
                          selectedCourses: _selectedCourses,
                          density: _densityValue,
                          timePreference: _timePreference,
                        ),
                      ),
                    );
                  }
                },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF104B63),
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              child: const Text(
                'Schedule',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),




          ],
        ),
      ),
    );
  }
}
