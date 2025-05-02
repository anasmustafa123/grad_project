import 'package:flutter/material.dart';

class FilterMenu extends StatefulWidget {
  final List<String> departments;
  final Function(String?) onFilterChanged;

  const FilterMenu({
    super.key,
    required this.departments,
    required this.onFilterChanged,
  });

  @override
  State<FilterMenu> createState() => _FilterMenuState();
}

class _FilterMenuState extends State<FilterMenu> {
  String? selectedDepartment;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      icon: const Icon(
        Icons.filter_list,
        color: Color(0xFF104B63),
        size: 30,
      ),
      onSelected: (String value) {
        setState(() {
          selectedDepartment = value;
        });
        widget.onFilterChanged(value);
      },
      itemBuilder: (BuildContext context) => [
        const PopupMenuItem<String>(
          value: 'all',
          child: Text('All Departments'),
        ),
        ...widget.departments.map((String department) {
          return PopupMenuItem<String>(
            value: department,
            child: Text(department),
          );
        }).toList(),
      ],
    );
  }
} 