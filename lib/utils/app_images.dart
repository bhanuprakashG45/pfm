import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AppImages {
  AppImages._();

  static const List<IconData> values = [
    FontAwesomeIcons.house,
    FontAwesomeIcons.list,
    FontAwesomeIcons.search,
    FontAwesomeIcons.user,
  ];

  static const List<IconData> darkValues = [
    FontAwesomeIcons.house,
    FontAwesomeIcons.listCheck,
    FontAwesomeIcons.searchengin,
    FontAwesomeIcons.userCheck,
  ];
  // static const List<String> images = [
  //   cat1,
  //   cat6,
  //   cat3,
  //   cat4,
  //   cat5,
  //   cat6,
  //   cat7,
  //   cat1,
  //   cat1,
  //   cat4,
  // ];

  static const String _base = 'assets/images';
  // static const String _catBase = 'assets/images/categories';

  static const String freshMeatLogo = '$_base/meat_delivery.jpg';
  static const String freshMeatLogoRemoveBg = '$_base/logo.png';
  static const String welcomeScreenBg1 = '$_base/welcome_screen_bg1.jpg';
  static const String iconChicken = '$_base/chicken_icon.png';
  static const String iconFish = '$_base/fish_icon.png';
  static const String loginBg = '$_base/login_bg.jpg';
  static const String welcomeBg = '$_base/welcome_bg.jpg';
  static const String welcomeBg1 = '$_base/welcome_bg1.png';
  static const String emptyAddress = '$_base/empty_address.png';
  static const String noOrders = '$_base/no_orders.png';

  //Categories
  // static const String cat1 = '$_catBase/chicken.png';
  // static const String cat2 = '$_catBase/fish.jpg';
  // static const String cat3 = '$_catBase/eggs.png';
  // static const String cat4 = '$_catBase/fish.jpg';
  // static const String cat5 = '$_catBase/pfm_specials.png';
  // static const String cat6 = '$_catBase/mutton.png';
  // static const String cat7 = '$_base/chicken_breast.jpg';
  // static const String cat8 = '$_catBase/prawns_crabs.png';
  // static const String cat9 = '$_catBase/eggs.png';
  // static const String cat10 = '$_catBase/cat5_prawns_black.png';
  // static const String cat11 = '$_catBase/plant_meat.png';
  // static const String cat12 = '$_catBase/kabab_masala.png';
  // static const String cat13 = '$_catBase/kabab_masala.png';
  // static const String cat14 = '$_catBase/spreads.png';
  // static const String cat15 = '$_catBase/kebab_biryani.png';
}
