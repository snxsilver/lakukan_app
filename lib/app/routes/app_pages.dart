import 'package:get/get.dart';

import 'package:lakukan_app/app/modules/home/bindings/home_binding.dart';
import 'package:lakukan_app/app/modules/home/views/home_view.dart';
import 'package:lakukan_app/app/modules/product_detail/bindings/product_detail_binding.dart';
import 'package:lakukan_app/app/modules/product_detail/views/product_detail_view.dart';
import 'package:lakukan_app/app/modules/product_edit/bindings/product_edit_binding.dart';
import 'package:lakukan_app/app/modules/product_edit/views/product_edit_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.PRODUCT_DETAIL,
      page: () => ProductDetailView(),
      binding: ProductDetailBinding(),
    ),
    GetPage(
      name: _Paths.PRODUCT_EDIT,
      page: () => ProductEditView(),
      binding: ProductEditBinding(),
    ),
  ];
}
