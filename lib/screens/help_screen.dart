import 'package:flutter/material.dart';
import '../widgets/header/header_widget.dart';
import 'home/components/navigation_icons.dart';

class HelpScreen extends StatefulWidget {
  const HelpScreen({super.key});

  @override
  State<HelpScreen> createState() => _HelpScreenState();
}

class _HelpScreenState extends State<HelpScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  bool _isSearching = false;

  final List<Map<String, String>> _faqs = [
    {
      'question': 'How do I view my course schedule?',
      'answer': 'You can view your course schedule by clicking on the Calendar icon in the bottom navigation bar or by visiting the Timetable section from the home screen.',
      'category': 'Schedule',
    },
    {
      'question': 'How can I contact my professors?',
      'answer': 'You can find your professors\' contact information in the Professors section. Click on any professor\'s card to view their details and contact information.',
      'category': 'Professors',
    },
    {
      'question': 'Where can I find my academic roadmap?',
      'answer': 'Your academic roadmap is available in the Roadmaps section. It shows your course progression and requirements for each semester.',
      'category': 'Academic',
    },
    {
      'question': 'How do I update my profile information?',
      'answer': 'Click on your profile icon in the top-left corner or select Profile from the More menu. Then click the Edit Profile button to make changes.',
      'category': 'Profile',
    },
    {
      'question': 'What do I do if I forget my password?',
      'answer': 'On the login screen, click the "Forgot Password" link. Follow the instructions sent to your registered email address to reset your password.',
      'category': 'Account',
    },
  ];

  List<Map<String, String>> get _filteredFaqs {
    if (_searchQuery.isEmpty) return _faqs;
    return _faqs.where((faq) {
      return faq['question']!.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          faq['answer']!.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          faq['category']!.toLowerCase().contains(_searchQuery.toLowerCase());
    }).toList();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
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
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildSearchBar(),
                    const SizedBox(height: 30),
                    _buildHelpCategories(),
                    const SizedBox(height: 30),
                    _buildFaqSection(),
                    const SizedBox(height: 30),
                    _buildContactSection(),
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

  Widget _buildSearchBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(25),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        children: [
          const Icon(Icons.search, color: Color(0xFF2E7D32)),
          const SizedBox(width: 10),
          Expanded(
            child: TextField(
              controller: _searchController,
              decoration: const InputDecoration(
                hintText: 'Search for help...',
                border: InputBorder.none,
              ),
              onChanged: (value) {
                setState(() {
                  _searchQuery = value;
                  _isSearching = value.isNotEmpty;
                });
              },
            ),
          ),
          if (_isSearching)
            IconButton(
              icon: const Icon(Icons.clear, color: Color(0xFF2E7D32)),
              onPressed: () {
                setState(() {
                  _searchController.clear();
                  _searchQuery = '';
                  _isSearching = false;
                });
              },
            ),
        ],
      ),
    );
  }

  Widget _buildHelpCategories() {
    final List<Map<String, dynamic>> categories = [
      {'icon': Icons.school, 'title': 'Academic', 'color': Colors.blue},
      {'icon': Icons.calendar_today, 'title': 'Schedule', 'color': Colors.orange},
      {'icon': Icons.person, 'title': 'Profile', 'color': Colors.green},
      {'icon': Icons.security, 'title': 'Account', 'color': Colors.purple},
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Help Categories',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Color(0xFF2E7D32),
          ),
        ),
        const SizedBox(height: 15),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 15,
            mainAxisSpacing: 15,
            childAspectRatio: 1.5,
          ),
          itemCount: categories.length,
          itemBuilder: (context, index) {
            final category = categories[index];
            final Color categoryColor = category['color'] as Color;
            return Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: InkWell(
                onTap: () {
                  setState(() {
                    _searchQuery = category['title'] as String;
                    _isSearching = true;
                  });
                },
                borderRadius: BorderRadius.circular(15),
                child: Container(
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        categoryColor.withAlpha(51), // 0.2 opacity
                        categoryColor.withAlpha(26), // 0.1 opacity
                      ],
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        category['icon'] as IconData,
                        color: categoryColor,
                        size: 30,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        category['title'] as String,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: categoryColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildFaqSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Frequently Asked Questions',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Color(0xFF2E7D32),
          ),
        ),
        const SizedBox(height: 15),
        ..._filteredFaqs.map((faq) => _buildFaqCard(faq)),
      ],
    );
  }

  Widget _buildFaqCard(Map<String, String> faq) {
    return Card(
      margin: const EdgeInsets.only(bottom: 15),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: ExpansionTile(
        title: Text(
          faq['question']!,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        subtitle: Text(
          faq['category']!,
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey[600],
          ),
        ),
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              faq['answer']!,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.black87,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContactSection() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFFA5D7C2).withAlpha(51), // 0.2 opacity
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Need More Help?',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xFF2E7D32),
            ),
          ),
          const SizedBox(height: 15),
          _buildContactItem(
            Icons.email,
            'Email Support',
            'support@studentportal.edu',
            () {
              // TODO: Implement email support
            },
          ),
          const SizedBox(height: 10),
          _buildContactItem(
            Icons.phone,
            'Phone Support',
            '+1 (555) 123-4567',
            () {
              // TODO: Implement phone support
            },
          ),
          const SizedBox(height: 10),
          _buildContactItem(
            Icons.chat,
            'Live Chat',
            'Available 24/7',
            () {
              // TODO: Implement live chat
            },
          ),
        ],
      ),
    );
  }

  Widget _buildContactItem(
    IconData icon,
    String title,
    String subtitle,
    VoidCallback onTap,
  ) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: const Color(0xFF2E7D32).withAlpha(26), // 0.1 opacity
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(
                icon,
                color: const Color(0xFF2E7D32),
                size: 24,
              ),
            ),
            const SizedBox(width: 15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
            const Icon(
              Icons.arrow_forward_ios,
              size: 16,
              color: Colors.grey,
            ),
          ],
        ),
      ),
    );
  }
} 