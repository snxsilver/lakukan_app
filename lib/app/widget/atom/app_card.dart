import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lakukan_app/app/widget/app/theme/app_colors.dart';
import 'package:lakukan_app/app/widget/app/theme/app_shadows.dart';
import 'package:lakukan_app/app/widget/app/theme/app_sizes.dart';
import 'package:lakukan_app/app/widget/app/theme/app_text_style.dart';
import 'package:lakukan_app/app/widget/atom/app_image.dart';

class AppCard extends StatelessWidget {
  final String image;
  final String title;
  final String price;
  final double rating;
  final int stock;
  final bool notif;
  final double size;

  const AppCard({
    super.key,
    required this.image,
    required this.title,
    required this.price,
    required this.rating,
    required this.stock,
    this.notif = false,
    this.size = 32,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSizes.padding),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppSizes.radius * 2),
        color: notif ? AppColors.greenLv6 : AppColors.white,
        boxShadow: [AppShadows.cardShadow1],
      ),
      width: Get.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          AppImage(
            image: image,
            width: 90,
            height: 90,
            fit: BoxFit.cover,
          ),
          const SizedBox(
            width: AppSizes.padding / 2,
          ),
          Flexible(
            child: Column(
              children: [
                Container(
                  // color: AppColors.redLv1,
                  height: 90,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Text(
                        title,
                        softWrap: true,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: AppTextStyle.bodyXLarge(
                          fontWeight: AppFontWeight.regular,
                          color: AppColors.secondary,
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            price,
                            style: AppTextStyle.bodyMedium(
                              fontWeight: AppFontWeight.regular,
                              color: AppColors.secondary,
                            ),
                          ),
                          SizedBox(
                            height: AppSizes.padding / 8,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Stock: $stock",
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
                                    "$rating",
                                    style: AppTextStyle.bodyMedium(
                                      fontWeight: AppFontWeight.semibold,
                                      color: AppColors.secondary,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
