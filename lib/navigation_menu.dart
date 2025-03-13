import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:test_flutter/features/personalization/screens/settings/settings.dart';
import 'package:test_flutter/features/shop/screens/home/home.dart';
import 'package:test_flutter/features/shop/screens/home/shop.dart';
import 'package:test_flutter/features/shop/screens/wishlist/wishlist.dart';
import 'features/shop/screens/store/store.dart';

class NavigationMenu extends StatelessWidget {
  const NavigationMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final navigationController = Get.put((NavigationController()));
    return Scaffold(
      bottomNavigationBar: Obx(() => NavigationBar(
              height: 80,
              elevation: 0,
              selectedIndex: navigationController.currentIndex.value,
              onDestinationSelected: (newIndex) {
                navigationController.currentIndex.value = newIndex;
                print(newIndex);
              },
              destinations: const [
                NavigationDestination(icon: Icon(Iconsax.home), label: 'Home'),
                NavigationDestination(icon: Icon(Iconsax.shopping_bag1), label: 'Shop'),
                NavigationDestination(icon: Icon(Iconsax.shop), label: 'Store'),
                NavigationDestination(icon: Icon(Iconsax.heart), label: 'Wishlist'),
                NavigationDestination(icon: Icon(Iconsax.user), label: 'Profile'),
              ])),
      body: Obx(() => navigationController.screens[navigationController.currentIndex.value]),
    );
  }
}

class NavigationController extends GetxController {
  final Rx<int> currentIndex = 0.obs;

  final screens = [HomeScreen(), HomeScreen2(), Store(), FavoriteScreen(), SettingsScreen()];
}
