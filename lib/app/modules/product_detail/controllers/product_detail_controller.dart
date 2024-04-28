import 'dart:convert';

import 'package:get/get.dart';
import 'package:lakukan_app/app/data/models/products_setting.dart';
import 'package:http/http.dart' as myHttp;

import '../../../data/models/delete_setting.dart';
import '../../../routes/app_pages.dart';
import '../../../widget/app/const/app_const.dart';
import '../../../widget/app/theme/app_colors.dart';
import '../../../widget/atom/app_snackbar.dart';

class ProductDetailController extends GetxController {
  //TODO: Implement ProductDetailController
  var isLoading = false.obs;
  late Product data;
  var passedData = Get.arguments;

  Future delete(context, {uuid}) async {
    isLoading.value = true;
    update();

    var response = await myHttp.delete(
      Uri.parse('${AppConst.baseApi}product/$uuid'),
    );

    // print(response.statusCode);

    if (response.statusCode == 200) {
      // DeleteSetting delete = DeleteSetting.fromJson(json.decode(response.body));
      AppSnackbar.show(
        context,
        title: "Data has been deleted.",
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

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();

    data = passedData[0] as Product;
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
  void increment() => count.value++;
}
