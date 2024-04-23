import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../core/class/request_status.dart';
import '../../../core/constants/colors.dart';
import '../controllers/home.dart';
import '../controllers/news.dart';
import '../widget/by_height_horizontal_list_post.dart';
import '../widget/home_title.dart';
import '../widget/horizontal_posts.dart';
import '../widget/one_banner_post.dart';

class HomeTabScreen extends StatefulWidget {
  const HomeTabScreen({super.key});

  @override
  State<HomeTabScreen> createState() => _HomeTabScreenState();
}

class _HomeTabScreenState extends State<HomeTabScreen> {
  @override
  Widget build(BuildContext context) {
    Get.put(HomeContImp());
    Get.put(NewsContImp());
    return GetBuilder<HomeContImp>(builder: (cont) {
      return Scaffold(
        body: SizedBox(
          height: double.infinity,
          width: double.infinity,
          child: GetBuilder<NewsContImp>(builder: (cont) {
            if (cont.requestStatus == RequestStatus.loading) {
              return SizedBox(
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
              );
            } else if(cont.requestStatus == RequestStatus.success){
              return RefreshIndicator(
                onRefresh: () async {
                  cont.getNews();
                },
                child: SizedBox(
                  height: 100.h,
                  width: 100.w,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        const MainHomeTitle(
                          sectionTitle: "Popular News..",
                          sectionSubTitle: 'View Popular News',
                        ),
                        OneBannerPost(
                          imageLink: cont.allNews[0]['cover'] ?? "",
                          categoryName: cont.allNews[0]['category_title'] ?? "",
                          postTitle: cont.allNews[0]['title'] ?? "",
                          postDate: cont.allNews[0]['created_at'] ?? "",
                          lang: cont.allNews[0]['lang'] ?? "ar",
                        ),
                        SizedBox(height: 1.h,),
                        SizedBox(
                          width: 95.w,
                          child: Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        width: 100.w,
                                        height: 30.h,
                                        child: NestedScrollView(
                                          headerSliverBuilder: (_, ch) {
                                            return [];
                                          },
                                          body: GridView.builder(
                                            scrollDirection: Axis.horizontal,
                                            itemCount: 4,
                                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                              crossAxisCount: 1,
                                              mainAxisSpacing: 2.w,
                                              childAspectRatio: 1,
                                            ),
                                            padding: EdgeInsets.symmetric(horizontal: 2.w),
                                            itemBuilder: (_, i) {
                                              return HorizontalPosts(
                                                imageLink: cont.allNews[i+1]['cover'] ?? "",
                                                postTitle: cont.allNews[i+1]['title'] ?? "",
                                                postDate: cont.allNews[i+1]['created_at'] ?? "",
                                                lang: cont.allNews[i+1]['lang'] ?? "ar",
                                              );
                                            },
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 1.h,),
                        SizedBox(
                          width: 100.w,
                          height: 46.h,
                          child: Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Column(
                                    children: [
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 3.w,
                                        ),
                                        width: 100.w,
                                        height: 45.h,
                                        child: NestedScrollView(
                                          headerSliverBuilder: (_, ch) {
                                            return [];
                                          },
                                          body: GridView.builder(
                                            scrollDirection: Axis.horizontal,
                                            itemCount: cont.allNews.length - 5 >= 1 ? 5 : cont.allNews.length - 5,
                                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                              crossAxisCount: 1,
                                              crossAxisSpacing: 10,
                                              mainAxisSpacing: 5.w,
                                              childAspectRatio: 1.4,
                                            ),
                                            itemBuilder: (_, i) {
                                              return ByHeightHorizontalListPost(
                                                imageLink: cont.allNews[i+5]['cover'] ?? "",
                                                postTitle: cont.allNews[i+5]['title'] ?? "",
                                                postDate: cont.allNews[i+5]['created_at'] ?? "",
                                                postCategory: cont.allNews[i+5]['category_title'] ?? "",
                                                lang: cont.allNews[i+5]['lang'] ?? "ar",
                                              );
                                            },
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const MainHomeTitle(
                          sectionTitle: "Recent News..",
                          sectionSubTitle: 'View Recent News',
                        ),
                        ListView.builder(
                          reverse: true,
                          shrinkWrap: true,
                          itemCount: cont.allNews.length,
                          physics: const ScrollPhysics(),
                          itemBuilder: (BuildContext context, int index) {
                            return Container(
                              width: 95.w,
                              padding: const EdgeInsets.all(10),
                              child: OneBannerPost(
                                imageLink: cont.allNews[index]['cover'] ?? "",
                                categoryName: cont.allNews[index]['category_title'] ?? "",
                                postTitle: cont.allNews[index]['title'] ?? "",
                                postDate: cont.allNews[index]['created_at'] ?? "",
                                lang: cont.allNews[index]['lang'] ?? "ar",
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }
            return SizedBox(
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
            );
          }),
        ),
      );
    });
  }
}



