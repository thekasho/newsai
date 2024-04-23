import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../config/config.dart';
import '../../../core/class/request_status.dart';
import '../../../core/constants/colors.dart';
import '../../news/ui/single_post.dart';
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
                        MainHomeTitle(
                          sectionTitle: "Popular News..",
                          sectionSubTitle: 'View Popular News',
                          onTap: () {
                            Get.toNamed(screenPopularNew);
                          }
                        ),
                        GestureDetector(
                          onTap: (){
                            Get.to(()=>SinglePostScreen(id: cont.allNews[0]['id']));
                          },
                          child: Stack(
                            alignment: Alignment.topCenter,
                            children: [
                              OneBannerPost(
                                imageLink: cont.allNews[0]['cover'] ?? "",
                                categoryName: cont.allNews[0]['category_title'] ?? "",
                                postTitle: cont.allNews[0]['title'] ?? "",
                                postDate: cont.allNews[0]['created_at'] ?? "",
                                lang: cont.allNews[0]['lang'] ?? "ar",
                              ),
                              GestureDetector(
                                onTap: () async {
                                  cont.likePost(cont.allNews[0]['id']);
                                  if(cont.allNews[0]['is_liked'] == 1){
                                    cont.allNews[0]['is_liked'] = 0;
                                    cont.allNews[0]['likesCount'] = cont.allNews[0]['likesCount']-1;
                                  } else {
                                    cont.allNews[0]['is_liked'] = 1;
                                    cont.allNews[0]['likesCount'] = cont.allNews[0]['likesCount']+1;
                                  }
                                  cont.update();
                                },
                                child: Container(
                                  width: 100.w,
                                  height: 6.h,
                                  margin: const EdgeInsets.only(
                                    right: 20,
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
                                            cont.allNews[0]['is_liked'] == 1 ? FontAwesomeIcons.solidThumbsUp : FontAwesomeIcons.thumbsUp,
                                            color: cont.allNews[0]['is_liked'] == 1 ? red : landingBackground,
                                            size: 22.sp,
                                          )
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
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
                                              return Stack(
                                                children: [
                                                  HorizontalPosts(
                                                    imageLink: cont.allNews[i+1]['cover'] ?? "",
                                                    postTitle: cont.allNews[i+1]['title'] ?? "",
                                                    postDate: cont.allNews[i+1]['created_at'] ?? "",
                                                    lang: cont.allNews[i+1]['lang'] ?? "ar",
                                                  ),
                                                  GestureDetector(
                                                    onTap: (){
                                                      Get.to(()=>SinglePostScreen(id: cont.allNews[i+1]['id']));
                                                    },
                                                    child: Container(
                                                      width: 100.w,
                                                      height: 100.h,
                                                      color: Colors.transparent,
                                                    ),
                                                  ),
                                                  GestureDetector(
                                                    onTap: () async {
                                                      cont.likePost(cont.allNews[i+1]['id']);
                                                      if(cont.allNews[i+1]['is_liked'] == 1){
                                                        cont.allNews[i+1]['is_liked'] = 0;
                                                        cont.allNews[i+1]['likesCount'] = cont.allNews[0]['likesCount']-1;
                                                      } else {
                                                        cont.allNews[i+1]['is_liked'] = 1;
                                                        cont.allNews[i+1]['likesCount'] = cont.allNews[0]['likesCount']+1;
                                                      }
                                                      cont.update();
                                                    },
                                                    child: Container(
                                                      width: 100.w,
                                                      height: 6.h,
                                                      margin: const EdgeInsets.only(
                                                        right: 5,
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
                                                              cont.allNews[i+1]['is_liked'] == 1 ? FontAwesomeIcons.solidThumbsUp : FontAwesomeIcons.thumbsUp,
                                                              color: cont.allNews[i+1]['is_liked'] == 1 ? red : landingBackground,
                                                              size: 22.sp,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ],
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
                                              return Stack(
                                                children: [
                                                  ByHeightHorizontalListPost(
                                                    imageLink: cont.allNews[i+5]['cover'] ?? "",
                                                    postTitle: cont.allNews[i+5]['title'] ?? "",
                                                    postDate: cont.allNews[i+5]['created_at'] ?? "",
                                                    postCategory: cont.allNews[i+5]['category_title'] ?? "",
                                                    lang: cont.allNews[i+5]['lang'] ?? "ar",
                                                  ),
                                                  GestureDetector(
                                                    onTap: (){
                                                      Get.to(()=>SinglePostScreen(id: cont.allNews[i+5]['id']));
                                                    },
                                                    child: Container(
                                                      width: 100.w,
                                                      height: 100.h,
                                                      color: Colors.transparent,
                                                    ),
                                                  ),
                                                  GestureDetector(
                                                    onTap: () async {
                                                      cont.likePost(cont.allNews[i+5]['id']);
                                                      if(cont.allNews[i+5]['is_liked'] == 1){
                                                        cont.allNews[i+5]['is_liked'] = 0;
                                                        cont.allNews[i+5]['likesCount'] = cont.allNews[0]['likesCount']-1;
                                                      } else {
                                                        cont.allNews[i+5]['is_liked'] = 1;
                                                        cont.allNews[i+5]['likesCount'] = cont.allNews[0]['likesCount']+1;
                                                      }
                                                      cont.update();
                                                    },
                                                    child: Container(
                                                      width: 100.w,
                                                      height: 6.h,
                                                      margin: const EdgeInsets.only(
                                                        left: 7,
                                                        top: 5,
                                                      ),
                                                      child: Row(
                                                        mainAxisAlignment: MainAxisAlignment.start,
                                                        children: [
                                                          Container(
                                                            padding: const EdgeInsets.all(8),
                                                            clipBehavior: Clip.antiAlias,
                                                            decoration: const BoxDecoration(
                                                              shape: BoxShape.circle,
                                                              color: white,
                                                            ),
                                                            child: Icon(
                                                              cont.allNews[i+5]['is_liked'] == 1 ? FontAwesomeIcons.solidThumbsUp : FontAwesomeIcons.thumbsUp,
                                                              color: cont.allNews[i+5]['is_liked'] == 1 ? red : landingBackground,
                                                              size: 22.sp,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ],
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
                        MainHomeTitle(
                          sectionTitle: "Recent News..",
                          sectionSubTitle: 'View Recent News',
                          onTap: () {
                            Get.toNamed(screenPopularNew);
                          },
                        ),
                        ListView.builder(
                          shrinkWrap: true,
                          itemCount: cont.allNews.length,
                          physics: const ScrollPhysics(),
                          itemBuilder: (BuildContext context, int index) {
                            return GestureDetector(
                              onTap: (){
                                Get.to(()=>SinglePostScreen(id: cont.allNews[index]['id']));
                              },
                              child: Container(
                                width: 95.w,
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
                                          cont.allNews[index]['likesCount'] = cont.allNews[0]['likesCount']-1;
                                        } else {
                                          cont.allNews[index]['is_liked'] = 1;
                                          cont.allNews[index]['likesCount'] = cont.allNews[0]['likesCount']+1;
                                        }
                                        cont.update();
                                      },
                                      child: Container(
                                        width: 100.w,
                                        height: 5.h,
                                        margin: const EdgeInsets.only(
                                          right: 7,
                                          top: 2,
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
                                                size: 20.sp,
                                              ),
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



