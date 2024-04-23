
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../core/constants/colors.dart';

class HorizontalPosts extends StatelessWidget {
  final String imageLink;
  final String postTitle;
  final String postDate;
  final String lang;

  const HorizontalPosts({
    super.key, required this.imageLink, required this.postTitle, required this.postDate, required this.lang,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){},
      child: Container(
        clipBehavior: Clip.antiAlias,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(15)),
        ),
        child: Column(
          children: [
            SizedBox(
              width: 100.w,
              height: 20.h,
              child: CachedNetworkImage(
                imageUrl: imageLink,
                fit: BoxFit.fill,
                errorWidget: (_, i, e) {
                  return Container(
                    color: black,
                    width: 100.w,
                    child: Image.asset(
                      "assets/images/blank.jpg",
                    ),
                  );
                },
                placeholder: (_, i) {
                  return const Center(
                    child: CircularProgressIndicator(
                      color: landingBackground,
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: .5.h,),
            Row(
              children: [
                Container(
                  width: 63.5.w,
                  alignment: Alignment.center,
                  padding: EdgeInsets.only(right: 4.w),
                  child: Text(
                    postTitle,
                    textAlign: lang == "ar" ? TextAlign.right : TextAlign.left,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: black,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: .5.h,),
            Container(
              width: 88.w,
              padding: EdgeInsets.only(
                bottom: .5.h,
                right: lang == "ar" ? 4.w : 0,
                left: lang == "en" ? 3.w : 0,
              ),
              alignment: Alignment.center,
              child: Row(
                mainAxisAlignment: lang == "ar" ? MainAxisAlignment.end : MainAxisAlignment.start,
                children: [
                  Icon(Icons.calendar_month_sharp, color: darkGrey, size: 18.sp,),
                  SizedBox(width: 1.w,),
                  Text(
                    postDate,
                    style: TextStyle(
                      color: darkGrey,
                      fontSize: 16.sp,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}