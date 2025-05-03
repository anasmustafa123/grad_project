import 'package:flutter/material.dart';
import '../widgets/header/header_widget.dart';
import '../widgets/footer/footer_widget.dart';
import 'home/components/navigation_icons.dart';

class RoadmapsScreen extends StatelessWidget {
  final int totalSemesters;
  
  const RoadmapsScreen({
    super.key,
    this.totalSemesters = 9, // Default to 9 semesters (4 years + 1 semester)
  });

  // Sample data for subjects - you can replace this with your actual data
  final Map<String, List<String>> semesterSubjects = const {
    '1-1': ['CS101', 'MATH101', 'PHYS101', 'ENG101', 'HUM101'],
    '1-2': ['CS102', 'MATH102', 'PHYS102', 'ENG102', 'HUM102'],
    '2-1': ['CS201', 'MATH201', 'PHYS201', 'ENG201', 'HUM201'],
    '2-2': ['CS202', 'MATH202', 'PHYS202', 'ENG202', 'HUM202'],
    '3-1': ['CS301', 'MATH301', 'PHYS301', 'ENG301', 'HUM301'],
    '3-2': ['CS302', 'MATH302', 'PHYS302', 'ENG302', 'HUM302'],
    '4-1': ['CS401', 'MATH401', 'PHYS401', 'ENG401', 'HUM401'],
    '4-2': ['CS402', 'MATH402', 'PHYS402', 'ENG402', 'HUM402'],
    '5-1': ['CS501', 'MATH501', 'PHYS501', 'ENG501', 'HUM501'],
    '5-2': ['CS502', 'MATH502', 'PHYS502', 'ENG502', 'HUM502'],
  };

  @override
  Widget build(BuildContext context) {
    // Calculate the number of full years and remaining semesters
    final fullYears = totalSemesters ~/ 2;
    final remainingSemesters = totalSemesters % 2;
    final totalYears = fullYears + (remainingSemesters > 0 ? 1 : 0);
    
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          const HeaderWidget(),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Academic Roadmaps',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF2E7D32),
                      ),
                    ),
                    const SizedBox(height: 20),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: totalYears,
                      itemBuilder: (context, yearIndex) {
                        final year = yearIndex + 1;
                        final isLastYear = year == totalYears;
                        final showSecondSemester = !isLastYear || remainingSemesters == 2;
                        
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10.0),
                              child: Text(
                                'Year $year',
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF2E7D32),
                                ),
                              ),
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: _buildRoadmapCard(
                                    context,
                                    year,
                                    1,
                                    semesterSubjects['$year-1']!,
                                  ),
                                ),
                                if (showSecondSemester) ...[
                                  const SizedBox(width: 15),
                                  Expanded(
                                    child: _buildRoadmapCard(
                                      context,
                                      year,
                                      2,
                                      semesterSubjects['$year-2']!,
                                    ),
                                  ),
                                ],
                              ],
                            ),
                            const SizedBox(height: 20),
                          ],
                        );
                      },
                    ),
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

  Widget _buildRoadmapCard(
    BuildContext context,
    int year,
    int semester,
    List<String> subjects,
  ) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFFA5D7C2), Color(0xFF81C784)],
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Semester $semester',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 12),
            const Divider(color: Colors.white30),
            const SizedBox(height: 8),
            ...subjects.map((subject) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          subject,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                )),
          ],
        ),
      ),
    );
  }
} 