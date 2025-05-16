import 'package:flutter/material.dart';
import '../widgets/header/header_widget.dart';
import 'home/components/navigation_icons.dart';
import 'input_menu_page.dart';

class CalendarScreen extends StatefulWidget {
  final List<String>? selectedCourses;
  final double? density;
  final double? timePreference;

  const CalendarScreen({
    Key? key,
    this.selectedCourses,
    this.density,
    this.timePreference,
  }) : super(key: key);

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  final List<String> _days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
  final List<String> _timeSlots = [
    '8:30 - 10:10',
    '10:20 - 12:00',
    '12:10 - 1:50',
    '2:00 - 3:40',
    '3:50 - 5:30',
    '5:40 - 7:20'
  ];

  final ScrollController _horizontalScrollController = ScrollController();
  final ScrollController _headerScrollController = ScrollController();

  // Sample default courses with schedule
  final List<Map<String, dynamic>> _allCourses = [
    {'name': 'Introduction to Programming', 'day': 'Mon', 'timeSlotIndex': 0},
    {'name': 'Mathematics I', 'day': 'Tue', 'timeSlotIndex': 1},
    {'name': 'Physics I', 'day': 'Wed', 'timeSlotIndex': 2},
    {'name': 'Data Structures', 'day': 'Thu', 'timeSlotIndex': 0},
    {'name': 'Mathematics II', 'day': 'Fri', 'timeSlotIndex': 1},
    {'name': 'Algorithms', 'day': 'Mon', 'timeSlotIndex': 3},
    {'name': 'Electronics I', 'day': 'Wed', 'timeSlotIndex': 4},
  ];

  @override
  void initState() {
    super.initState();
    _horizontalScrollController.addListener(_syncScroll);
  }

  void _syncScroll() {
    if (_horizontalScrollController.hasClients &&
        _headerScrollController.hasClients) {
      _headerScrollController.jumpTo(_horizontalScrollController.offset);
    }
  }

  @override
  void dispose() {
    _horizontalScrollController.removeListener(_syncScroll);
    _horizontalScrollController.dispose();
    _headerScrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final headerHeight = 100.0;
    final bottomNavHeight = 80.0;
    final padding = screenHeight * 0.02;
    final availableHeight =
        screenHeight - headerHeight - bottomNavHeight - (padding * 2);

    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const InputMenuPage()),
          );
        },
        backgroundColor: const Color(0xFFA5D7C2),
        child: const Icon(Icons.add),
      ),
      body: Column(
        children: [
          const HeaderWidget(),
          Padding(
            padding: EdgeInsets.symmetric(vertical: padding),
            child: SizedBox(
              height: availableHeight,
              child: _buildCalendarGrid(availableHeight),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            height: bottomNavHeight,
            decoration: const BoxDecoration(
              color: Color(0xFFA5D7C2),
            ),
            child: const NavigationIcons(),
          ),
        ],
      ),
    );
  }

  Widget _buildCalendarGrid(double availableHeight) {
    final screenWidth = MediaQuery.of(context).size.width;
    final timeColumnWidth = 100.0;
    final availableWidth = screenWidth - timeColumnWidth;
    final dayColumnWidth = availableWidth / 2;

    final headerHeight = 50.0;
    final slotHeight = (availableHeight - headerHeight) / _timeSlots.length;

    // Filter selected courses
    final selectedNames = widget.selectedCourses ?? [];
    final filteredCourses = _allCourses
        .where((course) => selectedNames.contains(course['name']))
        .toList();

    return Column(
      children: [
        // Header Row
        SizedBox(
          height: headerHeight,
          child: Row(
            children: [
              Container(
                width: timeColumnWidth,
                padding: const EdgeInsets.symmetric(vertical: 8),
                decoration: BoxDecoration(
                  border: Border.all(color: const Color(0xFF104B63)),
                ),
                child: const Text(
                  'Time',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xFF104B63),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Expanded(
                child: NotificationListener<ScrollNotification>(
                  onNotification: (ScrollNotification notification) {
                    if (notification is ScrollUpdateNotification) {
                      _horizontalScrollController
                          .jumpTo(notification.metrics.pixels);
                    }
                    return true;
                  },
                  child: SingleChildScrollView(
                    controller: _headerScrollController,
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: _days.map((day) {
                        return Container(
                          width: dayColumnWidth,
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          decoration: BoxDecoration(
                            border: Border.all(color: const Color(0xFF104B63)),
                          ),
                          child: Text(
                            day,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: Color(0xFF104B63),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),

        // Time Slots + Grid
        Expanded(
          child: NotificationListener<ScrollNotification>(
            onNotification: (ScrollNotification notification) {
              if (notification is ScrollUpdateNotification) {
                _headerScrollController.jumpTo(notification.metrics.pixels);
              }
              return true;
            },
            child: SingleChildScrollView(
              controller: _horizontalScrollController,
              scrollDirection: Axis.horizontal,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Time column
                  Column(
                    children: _timeSlots.map((time) {
                      return Container(
                        width: timeColumnWidth,
                        height: slotHeight,
                        decoration: BoxDecoration(
                          border: Border.all(color: const Color(0xFF104B63)),
                        ),
                        child: Center(
                          child: Text(
                            time,
                            style: const TextStyle(
                              color: Color(0xFF104B63),
                              fontSize: 12,
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),

                  // Grid with days and slots
                  ..._days.map((day) {
                    return Column(
                      children: List.generate(_timeSlots.length, (slotIndex) {
                        // Check if any course matches this day and time slot
                        final matchingCourse = filteredCourses.firstWhere(
                              (course) =>
                          course['day'] == day &&
                              course['timeSlotIndex'] == slotIndex,
                          orElse: () => <String, dynamic>{},
                        );

                        return Container(
                          width: dayColumnWidth,
                          height: slotHeight,
                          decoration: BoxDecoration(
                            border: Border.all(color: const Color(0xFF104B63)),
                          ),
                          child: Center(
                            child: matchingCourse.isNotEmpty
                                ? Text(
                              matchingCourse['name'],
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                color: Color(0xFF104B63),
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                              ),
                            )
                                : const SizedBox.shrink(),
                          ),
                        );
                      }),
                    );
                  }).toList(),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
