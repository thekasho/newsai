import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../core/class/request_status.dart';
import '../../../core/constants/colors.dart';
import '../../home/widget/one_banner_post.dart';
import '../controllers/popular.dart';

class PopularNewsScreen extends StatefulWidget {
  const PopularNewsScreen({super.key});

  @override
  State<PopularNewsScreen> createState() => _PopularNewsScreenState();
}

class _PopularNewsScreenState extends State<PopularNewsScreen> {
  @override
  Widget build(BuildContext context) {
    Get.put(PopularNewsContImp());
    return GetBuilder<PopularNewsContImp>(builder: (cont) {
      if (cont.requestStatus == RequestStatus.loading) {
        return Scaffold(
          body: Container(
            color: white,
            height: 85.h,
            width: 100.w,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(height: 20.h),
                const CircularProgressIndicator(
                  color: black,
                ),
              ],
            ),
          ),
        );
      } else if(cont.requestStatus == RequestStatus.success){
        return Scaffold(
          appBar: AppBar(
            backgroundColor: backgroundColor,
            title: Text(
              "Popular Posts"
            ),
            centerTitle: true,
          ),
          body: Container(
            color: backgroundColor,
            height: double.infinity,
            width: double.infinity,
            child: RefreshIndicator(
              onRefresh: () async {
                cont.getNews();
              },
              child: SizedBox(
                height: 100.h,
                width: 100.w,
                child: SingleChildScrollView(
                  child: ListView.builder(
                    reverse: true,
                    shrinkWrap: true,
                    itemCount: cont.allNews.length,
                    physics: const ScrollPhysics(),
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        onTap: (){},
                        child: Container(
                          width: 95.w,
                          color: white,
                          padding: const EdgeInsets.all(10),
                          child: Stack(
                            children: [
                              OneBannerPost(
                                imageLink: cont.allNews[index]['cover'] ?? "",
                                categoryName: cont.allNews[index]['category_title'] ?? "",
                                postTitle: cont.allNews[index]['title'] ?? "",
                                postDate: cont.allNews[index]['created_at'] ?? "",
                                lang: cont.allNews[index]['lang'] ?? "ar",
                              ),
                              GestureDetector(
                                onTap: () async {
                                  cont.likePost(cont.allNews[index]['id']);

                                  if(cont.allNews[index]['is_liked'] == 1){
                                    cont.allNews[index]['is_liked'] = 0;
                                  } else {
                                    cont.allNews[index]['is_liked'] = 1;
                                  }
                                  cont.update();
                                  print(cont.allNews[index]['is_liked']);
                                },
                                child: Container(
                                  width: 100.w,
                                  height: 6.h,
                                  margin: const EdgeInsets.only(
                                    top: 10,
                                    right: 10,
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Container(
                                          padding: const EdgeInsets.all(8),
                                          clipBehavior: Clip.antiAlias,
                                          decoration: const BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: white,
                                          ),
                                          child: Icon(
                                            cont.allNews[index]['is_liked'] == 1 ? FontAwesomeIcons.solidThumbsUp : FontAwesomeIcons.thumbsUp,
                                            color: cont.allNews[index]['is_liked'] == 1 ? red : landingBackground,
                                            size: 22.sp,
                                          )
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
        );
      }
      return Scaffold(
        body: Container(
          color: white,
          height: 85.h,
          width: 100.w,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: 20.h),
              const CircularProgressIndicator(
                color: black,
              ),
            ],
          ),
        ),
      );
    });
  }
}
