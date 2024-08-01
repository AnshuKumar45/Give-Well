import 'package:flutter/material.dart';
import 'package:fundraiser_app/views/funds/create_fundraiser.dart';
import 'package:fundraiser_app/views/home/home_page.dart';
import 'package:fundraiser_app/views/profile/profile_page.dart';

class Utils {
  static List<Widget> tabs = [
    const HomePage(),
    CreateFundRaserPage(),
    ProfilePage(),
  ];
}
