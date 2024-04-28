import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:lakukan_app/app/widget/app/assets/app_icons.dart';
import 'package:lakukan_app/app/widget/app/theme/app_colors.dart';
import 'package:lakukan_app/app/widget/app/theme/app_sizes.dart';
import 'package:lakukan_app/app/widget/app/theme/app_text_style.dart';
import 'package:lakukan_app/app/widget/app/utility/app_helper.dart';
import 'package:lakukan_app/app/widget/atom/app_appbar.dart';
import 'package:lakukan_app/app/widget/atom/app_card.dart';
import 'package:lakukan_app/app/widget/atom/app_image.dart';
// import 'package:lakukan_app/app/widget/atom/app_loading.dart';
import 'package:lakukan_app/app/widget/atom/app_text_field.dart';
// import 'package:note_app_flutter/app/widget/app/asset/app_icons.dart';
// import 'package:note_app_flutter/app/widget/app/theme/app_colors.dart';
// import 'package:note_app_flutter/app/widget/app/theme/app_sizes.dart';
// import 'package:note_app_flutter/app/widget/app/theme/app_text_style.dart';
// import 'package:note_app_flutter/app/widget/app/utility/app_helper.dart';
// import 'package:note_app_flutter/app/widget/atom/app_appbar.dart';
// import 'package:note_app_flutter/app/widget/atom/app_card.dart';

import '../../../routes/app_pages.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    controller.initData(context);
    // controller.scrollController.addListener(controller.scrollListener);
    return SafeArea(
      child: Scaffold(
        appBar: appBar(context),
        body: RefreshIndicator(
          onRefresh: () => controller.initData(context),
          child: body(),
        ),
        floatingActionButton: addButton(),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        bottomSheet: footer(),
      ),
    );
  }

  AppAppbar appBar(context) {
    return AppAppbar(
      leading: AppImage(
        image: 'https://source.unsplash.com/60x60?logo',
        width: 32,
        height: 32,
      ),
      appBarHeight: 140,
      bottom: searchForm(context),
      title: "Lakukan App",
      // centerTitle: true,
      actions: [
        GestureDetector(
          onTap: () {
            controller.logout(context);
            // Get.toNamed(Routes.LOGIN);
          },
          child: Icon(AppIcons.logout),
        ),
      ],
    );
  }

  Widget searchForm(context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          vertical: AppSizes.padding / 2, horizontal: AppSizes.padding),
      child: AppTextField(
        type: AppTextFieldType.search,
        iconsSize: 32,
        controller: controller.searchController.value,
        onChanged: (val) => controller.onChanged(context, val: val),
      ),
    );
  }

  Widget body() {
    return SingleChildScrollView(
      controller: controller.scrollController,
      padding: const EdgeInsets.symmetric(horizontal: AppSizes.padding * 1.5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          producList(),
          const SizedBox(
            height: 30,
          ),
        ],
      ),
    );
  }

  Widget producList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Products",
              style: AppTextStyle.bodyXLarge(
                fontWeight: AppFontWeight.regular,
              ),
            ),
            const SizedBox(
              width: AppSizes.padding / 4,
            ),
            Obx(
              () => Text(
                "(${controller.total})",
                style: AppTextStyle.bodyLarge(
                  fontWeight: AppFontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: AppSizes.padding,
        ),
        Obx(
          () => controller.isLoading.value
              ? Container(
                  height: 400,
                  child: Center(
                    child: SizedBox(
                      child: CircularProgressIndicator(),
                      width: 20,
                      height: 20,
                    ),
                  ),
                )
              : controller.data.isEmpty
                  ? Container(
                      height: 400,
                      child: Center(
                          child: Text(
                        "No data available",
                        style: AppTextStyle.bodyLarge(
                          fontWeight: AppFontWeight.regular,
                        ),
                      )),
                    )
                  : Column(
                      children: [
                        ...List.generate(
                          controller.data.length,
                          (i) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: AppSizes.padding / 2),
                              child: GestureDetector(
                                onTap: () {
                                  Get.toNamed(
                                    Routes.PRODUCT_DETAIL,
                                    arguments: [controller.data[i]],
                                  );
                                },
                                child: AppCard(
                                  image: controller.data[i].thumbnail,
                                  title: controller.data[i].title,
                                  price: AppHelper.formatCurrency(
                                      price: controller.data[i].price),
                                  rating: controller.data[i].rating,
                                  stock: controller.data[i].stock,
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
        ),
        Obx(
          () => controller.scrollLoading.value
              ? Container(
                  height: 90,
                  child: Center(
                    child: SizedBox(
                      child: CircularProgressIndicator(),
                      width: 20,
                      height: 20,
                    ),
                  ),
                )
              : SizedBox.shrink(),
        )
      ],
    );
  }

  Widget addButton() {
    return GestureDetector(
      onTap: () {
        Get.toNamed(Routes.PRODUCT_EDIT, arguments: ['add']);
      },
      child: Container(
        padding: const EdgeInsets.all(AppSizes.padding / 1.5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppSizes.radius * 2),
          color: AppColors.primary,
        ),
        child: Icon(
          AppIcons.add,
          size: 32,
          color: AppColors.white,
        ),
      ),
    );
  }

  Widget footer() {
    return Container(
      height: 30,
      color: AppColors.darkBlueLv1,
      child: Center(
        child: Text(
          "Copyright | Muh Syaiful Adli",
          style: AppTextStyle.bodySmall(
            fontWeight: AppFontWeight.regular,
            color: AppColors.white,
          ),
        ),
      ),
    );
  }
}
