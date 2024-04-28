import 'dart:convert';

// import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lakukan_app/app/data/models/products_setting.dart';
// import 'package:intl/intl.dart';
// import 'package:note_app_flutter/app/data/models/action_setting.dart';
// import 'package:note_app_flutter/app/data/models/note_setting.dart';
// import 'package:note_app_flutter/app/routes/app_pages.dart';
// import 'package:note_app_flutter/app/widget/app/asset/app_icons.dart';
// import 'package:note_app_flutter/app/widget/app/const/app_const.dart';
// import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as myHttp;
import 'package:lakukan_app/app/widget/app/const/app_const.dart';

import '../../../widget/app/theme/app_colors.dart';
import '../../../widget/atom/app_snackbar.dart';

class HomeController extends GetxController {
  //TODO: Implement HomeController
  RxList<Product> data = RxList<Product>([]);
  final scrollController = ScrollController();
  final searchController = TextEditingController().obs;

  var check = false.obs;
  var isLoading = false.obs;
  var scrollLoading = false.obs;

  var total = 0.obs;

  final count = 0.obs;
  @override
  void onInit() {
    // scrollController.addListener(printScroll);
    // print("check");
    super.onInit();
  }

  void scrollListener(context) async {
    // print(scrollController.offset);
    if (scrollController.offset == scrollController.position.maxScrollExtent) {
      scrollLoading.value = true;
      await getData(context, contains: searchController.value.text);
      scrollLoading.value = false;
      // print("check");
    }
  }

  void onChanged(context, {String? val}) async {
    isLoading.value = true;
    await getData(context, skip: 0, contains: val);
    isLoading.value = false;
  }

  Future<void> initScroll(context) async {
    scrollController.addListener(() => scrollListener(context));
  }

  Future<void> initData(context, {String? contains}) async {
    contains = contains ?? '';
    isLoading.value = true;
    await getData(context, skip: 0, contains: contains);
    await initScroll(context);
    searchController.value.text = '';
    print('text: ${searchController.value.text}');
    isLoading.value = false;
  }

  Future<void> getData(context, {int? skip, String? contains}) async {
    skip = skip == 0 ? skip : data.length;
    contains = contains ?? '';
    // print(skip);
    var response = await myHttp.get(Uri.parse(
        '${AppConst.baseApi}products/search?q=$contains&limit=10&skip=$skip'));
    // print('hello :' + response.body);
    // data.clear();
    if (response.statusCode == 200) {
      Products result = Products.fromJson(json.decode(response.body));
      if (skip == 0) {
        data.value = result.products;
      } else {
        data.addAll(result.products);
      }
      print(result.total);
      total.value = result.total;
      update();
    } else {
      // print('Error : status code' + response.statusCode.toString());
      AppSnackbar.show(
        context,
        title: 'Error : status code' + response.statusCode.toString(),
        backgroundColor: AppColors.error,
        showCloseButton: true,
      );
    }
  }

  void logout(context) async {}

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    // scrollController.removeListener(scrollListener);
  }

  void increment() => count.value++;
}
