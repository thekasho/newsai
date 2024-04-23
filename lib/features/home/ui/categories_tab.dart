import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../core/class/request_status.dart';
import '../../../core/constants/colors.dart';
import '../../news/ui/by_category.dart';
import '../controllers/home.dart';
import '../controllers/news.dart';
import '../widget/category_title.dart';

class CategoriesTabScreen extends StatefulWidget {
  const CategoriesTabScreen({super.key});

  @override
  State<CategoriesTabScreen> createState() => _CategoriesTabScreenState();
}

class _CategoriesTabScreenState extends State<CategoriesTabScreen> {
  @override
  Widget build(BuildContext context) {
    Get.put(HomeContImp());
    Get.put(NewsContImp());
    return GetBuilder<HomeContImp>(builder: (hCont) {
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
                  cont.getCategories();
                },
                child: SizedBox(
                  width: 100.w,
                  height: 100.h,
                  child: Column(
                    children: [
                      const CategoryTitle(
                        sectionTitle: "All Categories..",
                      ),
                      const Divider(
                        thickness: 2,
                      ),
                      Container(
                        width: 100.w,
                        height: 65.h,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 15),
                        child: GridView.builder(
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 1.h,
                            mainAxisSpacing: 1.h,
                            mainAxisExtent: 27.h,
                          ),
                          itemCount: cont.allCategory.length,
                          physics: const ScrollPhysics(),
                          itemBuilder: (BuildContext context, int index) {
                            return GestureDetector(
                              onTap: (){
                                Get.to(()=>NewsByCategoryScreen(id: cont.allCategory[index]["id"]));
                              },
                              child: Column(
                                children: [
                                  Container(
                                    clipBehavior: Clip.antiAlias,
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      // color: black
                                    ),
                                    child: cont.allCategory[index]["cover"] == null ? Image.asset(
                                      "assets/images/news_category.jpg",
                                    )
                                    : CachedNetworkImage(
                                      imageUrl: cont.allCategory[index]["cover"],
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
                                  Text(
                                    cont.allCategory[index]['title'],
                                    style: TextStyle(
                                      color: black,
                                      fontSize: 20.sp,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'Cairo',
                                    ),
                                  )
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    ],
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
