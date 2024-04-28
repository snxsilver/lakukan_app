import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as myHttp;
import 'package:get/get.dart';
import 'package:lakukan_app/app/data/models/products_setting.dart';
import 'package:lakukan_app/app/widget/app/const/app_const.dart';
import 'package:lakukan_app/app/widget/app/const/app_dummy_data.dart';

import '../../../data/models/submits_setting.dart';
import '../../../routes/app_pages.dart';
import '../../../widget/app/theme/app_colors.dart';
import '../../../widget/atom/app_snackbar.dart';

class ProductEditController extends GetxController {
  //TODO: Implement ProductEditController
  TextEditingController titleController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController stockController = TextEditingController();
  TextEditingController descController = TextEditingController();

  var isLoading = false.obs;
  var title = "Add Product";
  var passedData = Get.arguments;
  var edit = false.obs;

  late Product data;

  var selectedBrand = 0.obs;
  var selectedCategory = 0.obs;

  Future upload(
    context, {
    title,
    stock,
    price,
    description,
    category,
    brand,
  }) async {
    isLoading.value = true;
    update();

    Map<String, String> body = {
      "title": title,
      "stock": stock,
      "price": price,
      "description": description,
      "category": category,
      "brand": brand,
    };

    var response = await myHttp.post(
      Uri.parse('${AppConst.baseApi}products/add'),
      body: body,
    );

    // print(body);

    if (response.statusCode == 200) {
      SubmitSetting submit = SubmitSetting.fromJson(json.decode(response.body));
      print(submit);
      AppSnackbar.show(
        context,
        title: "Data has been added.",
        backgroundColor: AppColors.success,
        showCloseButton: true,
      );
      Get.offAllNamed(Routes.HOME);
    } else {
      AppSnackbar.show(
        context,
        title: 'Error : status code ' + response.statusCode.toString(),
        backgroundColor: AppColors.error,
        showCloseButton: true,
      );
    }
    isLoading.value = false;
    update();
  }

  Future patch(
    context, {
    title,
    stock,
    price,
    description,
    category,
    brand,
  }) async {
    isLoading.value = true;
    update();

    Map<String, dynamic> body = {
      "title": title,
      "stock": stock,
      "price": price,
      "description": description,
      "category": category,
      "brand": brand,
    };

    var id = passedData[1];

    var response = await myHttp.put(
      Uri.parse('${AppConst.baseApi}products/$id'),
      body: body,
    );

    // print(body);

    if (response.statusCode == 200) {
      Product product = Product.fromJson(json.decode(response.body));
      print(product);
      AppSnackbar.show(
        context,
        title: "Data has been updated.",
        backgroundColor: AppColors.success,
        showCloseButton: true,
      );
      Get.offAllNamed(Routes.HOME);
    } else {
      AppSnackbar.show(
        context,
        title: 'Error : status code ' + response.statusCode.toString(),
        backgroundColor: AppColors.error,
        showCloseButton: true,
      );
    }
    isLoading.value = false;
    update();
  }

  void getData({required uuid}) async {
    isLoading.value = true;
    update();

    var response = await myHttp.get(
      Uri.parse('${AppConst.baseApi}products/$uuid'),
    );

    if (response.statusCode == 200) {
      data = Product.fromJson(json.decode(response.body));

      titleController.text = data.title;
      selectedCategory.value = categoryList.firstWhere(
        (el) => el['text'] == data.category,
        orElse: () => null,
      )['value'];
      selectedBrand.value = brandList.firstWhere(
        (el) => el['text'] == data.brand,
        orElse: () => null,
      )['value'];
      stockController.text = data.stock.toString();
      priceController.text = data.price.toString();
      descController.text = data.description;
      update();
      // print(selectedBrand.value);
    } else {
      // print('Error : status code ' + response.statusCode.toString());
      // AppSnackbar.show(
      //   context,
      //   title: 'Error : status code ' + response.statusCode.toString(),
      //   backgroundColor: AppColors.error,
      //   showCloseButton: true,
      // );
    }
    isLoading.value = false;
    update();
  }

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
    if (passedData[0] != 'add') {
      edit.value = true;
      title = "Edit Product";
      getData(uuid: passedData[1]);
    }
    update();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
  void increment() => count.value++;
}
