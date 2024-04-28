import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:lakukan_app/app/routes/app_pages.dart';
import 'package:lakukan_app/app/widget/app/assets/app_icons.dart';
import 'package:lakukan_app/app/widget/app/theme/app_colors.dart';
import 'package:lakukan_app/app/widget/app/theme/app_sizes.dart';
import 'package:lakukan_app/app/widget/app/theme/app_text_style.dart';
import 'package:lakukan_app/app/widget/app/utility/app_helper.dart';
import 'package:lakukan_app/app/widget/atom/app_appbar.dart';
import 'package:lakukan_app/app/widget/atom/app_button.dart';
import 'package:lakukan_app/app/widget/atom/app_carousel_slider.dart';
import 'package:lakukan_app/app/widget/atom/app_icon_button_custom.dart';
import 'package:lakukan_app/app/widget/atom/app_image.dart';

import '../controllers/product_detail_controller.dart';

class ProductDetailView extends GetView<ProductDetailController> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: appBar(context),
        body: Obx(
          () => controller.isLoading.value
              ? Center(
                  child: SizedBox(
                    child: CircularProgressIndicator(),
                    width: 20,
                    height: 20,
                  ),
                )
              : body(),
        ),
        bottomSheet: bottomSheet(),
      ),
    );
  }

  AppAppbar appBar(context) {
    return AppAppbar(
      title: "Product Detail",
      actions: [
        AppIconButtonCustom(
          icon: AppIcons.edit,
          onTap: () {
            Get.toNamed(
              Routes.PRODUCT_EDIT,
              arguments: ["edit", controller.data.id],
            );
          },
          iconColor: AppColors.success,
        ),
        SizedBox(
          width: AppSizes.padding / 4,
        ),
        AppIconButtonCustom(
          icon: AppIcons.delete,
          onTap: () {
            controller.delete(context, uuid: controller.data.id);
          },
          iconColor: AppColors.error,
        ),
      ],
    );
  }

  Widget body() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppCarouselSlider(
            activeIndicatorColor: AppColors.primary,
            inactiveIndicatorColor: AppColors.blackLv7,
            indicatorSpacing: AppSizes.padding,
            swipeIndicatorPosition: SwipeIndicatorPosition.inside,
            contentList: [
              ...List.generate(controller.data.images.length + 1, (i) {
                return AppImage(
                  image: i == 0
                      ? controller.data.thumbnail
                      : controller.data.images[i - 1],
                  width: double.maxFinite,
                );
              })
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
                vertical: AppSizes.padding, horizontal: AppSizes.padding * 1.5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  controller.data.title,
                  style: AppTextStyle.heading4(),
                ),
                SizedBox(
                  height: AppSizes.padding / 2,
                ),
                Text(
                  AppHelper.formatCurrency(price: controller.data.price),
                  style: AppTextStyle.bodyXLarge(
                    fontWeight: AppFontWeight.regular,
                    color: AppColors.secondary,
                  ),
                ),
                SizedBox(
                  height: AppSizes.padding / 2,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Stock: ${controller.data.stock}",
                      style: AppTextStyle.bodyMedium(
                        fontWeight: AppFontWeight.regular,
                        color: AppColors.secondary,
                      ),
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.star,
                          size: 24,
                          color: AppColors.warning,
                        ),
                        SizedBox(
                          width: AppSizes.padding / 4,
                        ),
                        Text(
                          "${controller.data.rating}",
                          style: AppTextStyle.bodyMedium(
                            fontWeight: AppFontWeight.semibold,
                            color: AppColors.secondary,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: AppSizes.padding / 2,
                ),
                Text(
                  controller.data.description,
                  style: AppTextStyle.bodyMedium(
                      fontWeight: AppFontWeight.regular),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget bottomSheet() {
    return Container(
      height: 90,
      padding: const EdgeInsets.symmetric(
          vertical: AppSizes.padding, horizontal: AppSizes.padding * 1.5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Price: ${AppHelper.formatCurrency(price: controller.data.price)}",
            style: AppTextStyle.bodyXLarge(fontWeight: AppFontWeight.semibold),
          ),
          SizedBox(
            width: AppSizes.padding / 2,
          ),
          AppButton(
            onTap: () {},
            text: "Buy",
          )
        ],
      ),
    );
  }
}
