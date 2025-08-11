import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:week_3_blp_1/theme/customThemes/contextThemeExtensions.dart';

class CategoryTileButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String descriptionTxt;
  final String titleTxt;

  const CategoryTileButton({
    super.key,
    required this.onPressed,
    required this.descriptionTxt,
    required this.titleTxt,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: context.appColors.onPrimary,
        ),
        padding: EdgeInsets.all(15.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    constraints: BoxConstraints(maxWidth: 100,maxHeight: 120),
                    child: Text(
                      descriptionTxt,
                      style: TextStyle(fontSize: 13.sp),
                    ),
                  ),
                  Icon(CupertinoIcons.arrow_up_right, size: 18.sp),
                ],
              ),
            ),
            SizedBox(height: 2.h),
            Text(
              titleTxt,
              style: TextStyle(fontSize: 22.sp,fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
