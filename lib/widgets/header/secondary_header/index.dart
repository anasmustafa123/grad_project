export 'nav_item.dart';
export 'secondary_header.dart';

import 'package:flutter/material.dart';
import 'nav_item.dart';
import '../../../navigation/app_router.dart';

class SecondaryHeader extends StatefulWidget {
  const SecondaryHeader({super.key});

  @override
  State<SecondaryHeader> createState() => _SecondaryHeaderState();
}

class _SecondaryHeaderState extends State<SecondaryHeader> {
  final ScrollController _scrollController = ScrollController();

  void _scrollToLeft() {
    final screenWidth = MediaQuery.of(context).size.width;
    _scrollController.animateTo(
      0,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void _scrollToRight() {
    final screenWidth = MediaQuery.of(context).size.width;
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    
    return Container(
      width: screenWidth,
      height: 50,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFFA5D7C2),
            Color(0xFF9FD983),
            Color(0xFFA5D7C2),
          ],
        ),
      ),
      child: Stack(
        children: [
          SingleChildScrollView(
            controller: _scrollController,
            scrollDirection: Axis.horizontal,
            physics: const ClampingScrollPhysics(),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth / 2 - 40), // This allows items to reach center
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SecondaryNavItem(
                    label: 'Home',
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, AppRouter.homeRoute);
                    },
                  ),
                  const SizedBox(width: 24),
                  SecondaryNavItem(
                    label: 'Semester Timeline',
                    onPressed: () {
                      // TODO: Navigate to semester timeline
                    },
                  ),
                  const SizedBox(width: 24),
                  SecondaryNavItem(
                    label: 'College Clubs',
                    onPressed: () {
                      // TODO: Navigate to college clubs
                    },
                  ),
                  const SizedBox(width: 24),
                  SecondaryNavItem(
                    label: 'Campus Map',
                    onPressed: () {
                      // TODO: Navigate to campus map
                    },
                  ),
                  const SizedBox(width: 24),
                  SecondaryNavItem(
                    label: 'Chatbot',
                    onPressed: () {
                      // TODO: Navigate to chatbot
                    },
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            left: 0,
            top: 0,
            bottom: 0,
            child: Container(
              width: 40,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFFA5D7C2), Colors.transparent],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
              ),
              child: IconButton(
                icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
                onPressed: _scrollToLeft,
              ),
            ),
          ),
          Positioned(
            right: 0,
            top: 0,
            bottom: 0,
            child: Container(
              width: 40,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.transparent, Color(0xFFA5D7C2)],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
              ),
              child: IconButton(
                icon: const Icon(Icons.arrow_forward_ios, color: Colors.white),
                onPressed: _scrollToRight,
              ),
            ),
          ),
        ],
      ),
    );
  }
} 