import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:fundraiser_app/utils/constant.dart';
import 'package:get/get.dart';

import '../controllers/navigation_controller.dart';
import '../utils/app_colors.dart';
// Ensure you have a Utils class with the tabs defined

class NavigationWrapper extends StatelessWidget {
  NavigationWrapper({super.key});
  final navigationController = Get.find<NavigationController>();

  @override
  Widget build(BuildContext context) {
    // Jump to the saved page only after the PageView has been built
    WidgetsBinding.instance.addPostFrameCallback((_) {
      navigationController.pageController
          .jumpToPage(navigationController.pageIndex);
    });

    return Obx(
      () => Scaffold(
        body: PageView(
          controller: navigationController.pageController,
          onPageChanged: (value) {
            navigationController.updateIndex(value);
          },
          children: Utils.tabs,
        ),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          elevation: 0,
          selectedFontSize: 12,
          selectedLabelStyle: const TextStyle(),
          showUnselectedLabels: true,
          unselectedLabelStyle: const TextStyle(),
          backgroundColor: AppColor.primaryBackgroundW,
          selectedItemColor: AppColor.primary,
          unselectedItemColor: AppColor.textAccentW.withOpacity(.55),
          iconSize: 25,
          currentIndex: navigationController.pageIndex,
          onTap: (index) {
            navigationController.updateIndex(index);
            navigationController.pageController.jumpToPage(index);
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(EvaIcons.homeOutline),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.add,
                size: 25,
              ),
              label: 'Create',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.account_circle_outlined),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }
}
