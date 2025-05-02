import 'package:flutter/material.dart';

class DepartmentFilterMenu extends StatefulWidget {
  final List<String> categories;
  final Function(String?) onFilterChanged;

  const DepartmentFilterMenu({
    super.key,
    required this.categories,
    required this.onFilterChanged,
  });

  @override
  State<DepartmentFilterMenu> createState() => _DepartmentFilterMenuState();
}

class _DepartmentFilterMenuState extends State<DepartmentFilterMenu> {
  String? selectedCategory;

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
          selectedCategory = value;
        });
        widget.onFilterChanged(value);
      },
      itemBuilder: (BuildContext context) => widget.categories.map((String category) {
        return PopupMenuItem<String>(
          value: category,
          child: Text(category),
        );
      }).toList(),
    );
  }
} 