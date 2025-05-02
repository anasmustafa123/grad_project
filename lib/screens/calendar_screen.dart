import 'package:flutter/material.dart';
import '../widgets/header/header_widget.dart';
import 'home/components/navigation_icons.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});

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

  @override
  void initState() {
    super.initState();
    _horizontalScrollController.addListener(_syncScroll);
  }

  void _syncScroll() {
    if (_horizontalScrollController.hasClients && _headerScrollController.hasClients) {
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
    // Calculate available height and padding
    final screenHeight = MediaQuery.of(context).size.height;
    final headerHeight = 100.0; // HeaderWidget height
    final bottomNavHeight = 80.0; // NavigationIcons height
    final padding = screenHeight * 0.02; // 2% of screen height for padding
    final availableHeight = screenHeight - headerHeight - bottomNavHeight - (padding * 2);

    return Scaffold(
      backgroundColor: Colors.white,
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
    
    // Calculate the height for each time slot
    final headerHeight = 50.0;
    final slotHeight = (availableHeight - headerHeight) / _timeSlots.length;

    return Column(
      children: [
        // Time slots header
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
                      _horizontalScrollController.jumpTo(notification.metrics.pixels);
                    }
                    return true;
                  },
                  child: SingleChildScrollView(
                    controller: _headerScrollController,
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: _days.map((day) => Container(
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
                      )).toList(),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        // Days and grid
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
                    children: _timeSlots.map((time) => Container(
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
                    )).toList(),
                  ),
                  // Days columns
                  ..._days.map((day) => Column(
                    children: _timeSlots.map((time) => Container(
                      width: dayColumnWidth,
                      height: slotHeight,
                      decoration: BoxDecoration(
                        border: Border.all(color: const Color(0xFF104B63)),
                      ),
                      child: const Center(
                        child: Text(
                          '',
                          style: TextStyle(
                            color: Color(0xFF104B63),
                          ),
                        ),
                      ),
                    )).toList(),
                  )),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
} 