import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';

class AppHelper {
  AppHelper._();

  static String formatCurrency({required int price}) {
    String res = "\$ $price.00";
    return res;
  }

  // static IconData formatIcon({required int icon}) {
  //   IconData res = categoryList.firstWhere((el) => el['value'] == icon)['icon'];
  //   return res;
  // }

  // static String formatIconText({required int icon}) {
  //   String res = categoryList.firstWhere((el) => el['value'] == icon)['text'];
  //   return res;
  // }
}
