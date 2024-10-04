import 'package:flutter/material.dart';
import 'package:fundraiser_app/views/funds/create_fundraiser.dart';
import 'package:fundraiser_app/views/home/home_page.dart';
import 'package:fundraiser_app/views/profile/profile_page.dart';
import 'package:get/get.dart';

class Utils {
  static List<Widget> tabs = [
    const HomePage(),
    const CreateFundRaserPage(),
    ProfilePage(),
  ];
  static List<String> fundCategories = ['Personal', 'Community', 'NGOs'];
  static Transition rToL = Transition.rightToLeftWithFade;
  static Transition lToR = Transition.leftToRightWithFade;
  static Transition zoom = Transition.zoom;
}
