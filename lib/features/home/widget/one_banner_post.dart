import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../core/constants/colors.dart';

class OneBannerPost extends StatelessWidget {
  final String imageLink;
  final String categoryName;
  final String postTitle;
  final String postDate;
  final String lang;

  const OneBannerPost({
    super.key, required this.imageLink, required this.categoryName, required this.postTitle, required this.postDate, required this.lang,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 95.w,
      height: 25.h,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Stack(
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
          Container(
            width: 100.w,
            height: 25.h,
            padding: const EdgeInsets.all(15),
            child: Column(
              mainAxisAlignment: lang == "ar" ? MainAxisAlignment.end : MainAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      alignment: Alignment.center,
                      width: 20.w,
                      decoration: BoxDecoration(
                        color: red,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Text(
                        categoryName,
                        style: TextStyle(
                          color: white,
                          fontSize: 15.sp,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: .5.h,),
                Row(
                  children: [
                    Container(
                      width: 88.w,
                      alignment: Alignment.center,
                      color: black.withOpacity(.5),
                      padding: EdgeInsets.only(
                        bottom: .5.h,
                        right: lang == "ar" ? 3.w : 0,
                        left: lang == "ar" ? 3.w : 0,
                      ),
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
                  ],
                ),
                Container(
                  width: 88.w,
                  alignment: Alignment.center,
                  color: black.withOpacity(.5),
                  padding: EdgeInsets.only(
                    bottom: .5.h,
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
              ],
            ),
          ),
        ],
      ),
    );
  }
}
