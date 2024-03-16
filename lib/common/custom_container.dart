import 'package:flutter/material.dart';
import 'package:payoda/common/app_colors.dart';
import 'package:payoda/common/themes.dart';

Widget customContainer(
    {required String firstTitle,
      required String firstValue,
      required String secondTitle,
      required String secondValue,
       String? thirdTitle,
       String? thirdValue
    }) {
  return Row(children: [
    Expanded(
      child: Container(

        decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: AppColors.lightPrimary),
        child: Padding(
          padding: const EdgeInsets.only(top: 10, bottom: 15, left: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                firstTitle,
                style: textTheme()
                    .titleMedium
                    ?.copyWith(fontSize: 13, fontWeight: FontWeight.w500, color: AppColors.pureWhite),
              ),
              const SizedBox(height: 15),
              Text(
                firstValue,
                style: textTheme()
                    .titleMedium
                    ?.copyWith(fontSize: 30, fontWeight: FontWeight.w600, color: AppColors.pureWhite),
              ),
            ],
          ),
        ),
      ),
    ),
    const SizedBox(width: 10),
    Expanded(
      child: Container(
    //    padding: const EdgeInsets.only(top: 10, bottom: 15, left: 10),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: AppColors.lightPrimary),
        child: Padding(
          padding: const EdgeInsets.only(top: 10, bottom: 15, left: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(secondTitle,
                  style: textTheme()
                      .titleMedium
                      ?.copyWith(fontSize: 13, fontWeight: FontWeight.w500, color: AppColors.pureWhite)),
              const SizedBox(height: 15),
              Text(secondValue,
                  style: textTheme()
                      .titleMedium
                      ?.copyWith(fontSize: 30, fontWeight: FontWeight.w600, color: AppColors.pureWhite)),
            ],
          ),
        ),
      ),
    ),

   if(thirdTitle != null) Expanded(
      child: Container(
        margin: const EdgeInsets.only(left: 10),
      //  padding: const EdgeInsets.only(top: 10, bottom: 15, left: 10),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: AppColors.lightPrimary),
        child: Padding(
          padding: const EdgeInsets.only(top: 10, bottom: 15, left: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(thirdTitle??'',
                  style: textTheme()
                      .titleMedium
                      ?.copyWith(fontSize: 13, fontWeight: FontWeight.w500, color: AppColors.pureWhite)),
              const SizedBox(height: 15),
              Text(thirdValue??'',
                  style: textTheme()
                      .titleMedium
                      ?.copyWith(fontSize: 30, fontWeight: FontWeight.w600, color: AppColors.pureWhite)),
            ],
          ),
        ),
      ),
    ),

  ]);
}