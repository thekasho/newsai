import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../core/constants/colors.dart';

class ByHeightHorizontalListPost extends StatelessWidget {
  final String imageLink;
  final String postTitle;
  final String postDate;
  final String postCategory;
  final String lang;

  const ByHeightHorizontalListPost({
    super.key, required this.imageLink, required this.postTitle, required this.postDate, required this.postCategory, required this.lang,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){},
      child: Container(
        clipBehavior: Clip.antiAlias,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(
              Radius.circular(30)),
        ),
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            SizedBox(
              child: CachedNetworkImage(
                imageUrl: imageLink,
                height: 100.h,
                width: 100.w,
                fit: BoxFit.fill,
                errorWidget: (_, i, e) {
                  return Container(
                    color: black,
                    height: 100.h,
                    child: Image.asset(
                      "assets/images/blank.png",
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
            Row(
              children: [
                Container(
                  width: 68.w,
                  padding: EdgeInsets.all(3.w),
                  alignment: Alignment.bottomLeft,
                  child: Container(
                    color: black.withOpacity(.5),
                    child: Text(
                      postTitle,
                      textAlign: lang == "ar" ? TextAlign.right : TextAlign.left,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: white,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Container(
              width: 62.w,
              height: 4.h,
              alignment: Alignment.center,
              margin: EdgeInsets.only(
                bottom: 6.5.h,
              ),
              child: Container(
                color: black.withOpacity(.5),
                padding: EdgeInsets.only(
                  right: lang == "ar" ? 3.w : 0,
                  left: lang == "en" ? 3.w : 0,
                ),
                child: Row(
                  mainAxisAlignment: lang == "ar" ? MainAxisAlignment.end : MainAxisAlignment.start,
                  children: [
                    Icon(Icons.calendar_month_sharp, color: white, size: 18.sp,),
                    SizedBox(width: 1.w,),
                    Text(
                      postDate,
                      style: TextStyle(
                        color: white,
                        fontSize: 16.sp,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Row(
              mainAxisAlignment: lang == "ar" ? MainAxisAlignment.end : MainAxisAlignment.start,
              children: [
                Container(
                  alignment: Alignment.center,
                  width: 20.w,
                  height: 4.h,
                  margin: EdgeInsets.only(
                    bottom: 39.h,
                    right: lang == "ar" ? 3.w : 0,
                    left: lang == "en" ? 4.w : 0,
                  ),
                  decoration: BoxDecoration(
                    color: red,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Text(
                    postCategory,
                    style: TextStyle(
                      color: white,
                      fontSize: 15.sp,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}