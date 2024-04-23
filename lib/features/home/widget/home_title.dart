import 'package:flutter/material.dart';
import 'package:newsai/core/constants/colors.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class MainHomeTitle extends StatelessWidget {
  final String sectionTitle;
  final String sectionSubTitle;
  final void Function()? onTap;
  const MainHomeTitle({
    super.key, required this.sectionTitle, required this.sectionSubTitle, this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: 5.w,
              vertical: 2.h,
            ),
            width: 60.w,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  sectionTitle,
                  style: TextStyle(
                    fontSize: 17.sp,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Cairo',
                  ),
                ),
                Text(
                  sectionSubTitle,
                  style: TextStyle(
                    fontSize: 15.sp,
                    color: darkGrey,
                    fontFamily: 'Cairo',
                  ),
                ),
              ],
            ),
          ),
          const Spacer(),
          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.symmetric(
              horizontal: 5.w,
              vertical: 2.h,
            ),
            width: 35.w,
            child: Text(
              "View More",
              style: TextStyle(
                fontSize: 17.sp,
                fontWeight: FontWeight.bold,
                fontFamily: 'Cairo',
                decoration: TextDecoration.underline,
                color: landingBackground,
              ),
            ),
          ),
        ],
      ),
    );
  }
}