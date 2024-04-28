import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:lakukan_app/app/widget/app/assets/app_icons.dart';
import 'package:lakukan_app/app/widget/app/theme/app_colors.dart';
import 'package:lakukan_app/app/widget/app/theme/app_text_style.dart';
import 'package:lakukan_app/app/widget/atom/app_appbar.dart';
import 'package:lakukan_app/app/widget/atom/app_icon_button_custom.dart';

import '../../../widget/app/const/app_dummy_data.dart';
import '../../../widget/app/theme/app_sizes.dart';
import '../../../widget/atom/app_category.dart';
import '../../../widget/atom/app_text_field.dart';
import '../controllers/product_edit_controller.dart';

class ProductEditView extends GetView<ProductEditController> {
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
          )),
    );
  }

  AppAppbar appBar(context) {
    return AppAppbar(
      title: controller.title,
      // centerTitle: true,
      actions: [
        AppIconButtonCustom(
          icon: AppIcons.save,
          onTap: () {
            if (controller.passedData[0] == 'add') {
              controller.upload(
                context,
                title: controller.titleController.text,
                stock: controller.stockController.text,
                price: controller.priceController.text,
                description: controller.descController.text,
                brand: brandList.firstWhere((element) =>
                    element['value'] == controller.selectedBrand.value)['text'],
                category: categoryList.firstWhere((element) =>
                    element['value'] ==
                    controller.selectedCategory.value)['text'],
              );
            } else {
              controller.patch(
                context,
                title: controller.titleController.text,
                stock: controller.stockController.text,
                price: controller.priceController.text,
                description: controller.descController.text,
                brand: brandList.firstWhere((element) =>
                    element['value'] == controller.selectedBrand.value)['text'],
                category: categoryList.firstWhere((element) =>
                    element['value'] ==
                    controller.selectedCategory.value)['text'],
              );
            }
          },
          iconColor: AppColors.primary,
        ),
      ],
    );
  }

  Widget body() {
    return Padding(
      padding: const EdgeInsets.all(AppSizes.padding * 1.5),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppTextField(
              labelText: "Title",
              maxLines: 1,
              minLines: 1,
              controller: controller.titleController,
            ),
            const SizedBox(
              height: AppSizes.padding,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: AppTextField(
                    labelText: "Price",
                    type: AppTextFieldType.number,
                    maxLines: 1,
                    minLines: 1,
                    controller: controller.priceController,
                  ),
                ),
                SizedBox(
                  width: AppSizes.padding,
                ),
                Expanded(
                  child: AppTextField(
                    labelText: "Stock",
                    type: AppTextFieldType.number,
                    maxLines: 1,
                    minLines: 1,
                    controller: controller.stockController,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: AppSizes.padding,
            ),
            AppTextField(
              labelText: "Description",
              maxLines: 3,
              minLines: 3,
              controller: controller.descController,
            ),
            SizedBox(
              height: AppSizes.padding,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                optionCustom(
                  title: "Brands",
                  widget: Obx(
                    () => Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      // spacing: AppSizes.padding,
                      children: [
                        ...List.generate(brandList.length, (i) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: AppSizes.padding / 4),
                            child: AppCategory(
                              text: brandList[i]["text"],
                              width: 150,
                              onTap: () {
                                controller.selectedBrand.value = i;
                              },
                              selected: controller.selectedBrand.value ==
                                  brandList[i]["value"],
                            ),
                          );
                        }),
                      ],
                    ),
                  ),
                ),
                optionCustom(
                  title: "Category",
                  widget: Obx(
                    () => Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      // spacing: AppSizes.padding,
                      children: [
                        ...List.generate(categoryList.length, (i) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: AppSizes.padding / 4),
                            child: AppCategory(
                              text: categoryList[i]["text"],
                              width: 150,
                              onTap: () {
                                controller.selectedCategory.value = i;
                              },
                              selected: controller.selectedCategory.value ==
                                  categoryList[i]["value"],
                            ),
                          );
                        }),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: AppSizes.padding,
            ),
          ],
        ),
      ),
    );
  }

  Widget optionCustom({required String title, required Widget widget}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: AppTextStyle.bodyMedium(fontWeight: AppFontWeight.regular),
        ),
        SizedBox(
          height: AppSizes.padding / 2,
        ),
        widget,
      ],
    );
  }
}
