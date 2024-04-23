import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../core/class/request_status.dart';
import '../../../core/constants/colors.dart';
import '../../home/controllers/news.dart';

class SinglePostScreen extends StatefulWidget {
  const SinglePostScreen({super.key, this.id});
  final dynamic id;

  @override
  State<SinglePostScreen> createState() => _SinglePostScreenState();
}

class _SinglePostScreenState extends State<SinglePostScreen> {
  NewsContImp newsContImp = Get.put(NewsContImp());
  List post = [];

  Future<void> getPostInfo() async {
    if (widget.id >= 1) {
      post = [];
      post = newsContImp.allNews.where((c) => c['id'] == widget.id).toList();
      await newsContImp.addView(widget.id);
    }
  }
  @override
  void initState() {
    getPostInfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<NewsContImp>(builder: (cont) {
      if (cont.requestStatus == RequestStatus.loading) {
        return Container(
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
        );
      } else if(cont.requestStatus == RequestStatus.success){
        return Scaffold(
          body: SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: RefreshIndicator(
              onRefresh: () async {
                cont.getNews();
                getPostInfo();
              },
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Stack(
                      children: [
                        Container(
                          height: 35.h,
                          width: 100.w,
                          color: black.withOpacity(.5),
                          child: CachedNetworkImage(
                            imageUrl: post[0]['cover'],
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
                        SafeArea(
                          child: GestureDetector(
                            onTap: () async {
                              Get.back();
                            },
                            child: Container(
                              width: 100.w,
                              height: 5.h,
                              margin: EdgeInsets.only(
                                left: 3.w,
                                top: 2,
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
                                      Icons.arrow_back,
                                      color: landingBackground,
                                      size: 20.sp,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        GestureDetector(
                          onTap: (){
                            cont.likePost(post[0]['id']);
                            if(post[0]['is_liked'] == 1){
                              post[0]['is_liked'] = 0;
                              post[0]['likesCount'] = post[0]['likesCount']-1;
                            } else {
                              post[0]['is_liked'] = 1;
                              post[0]['likesCount'] = post[0]['likesCount']+1;
                            }
                            cont.update();
                          },
                          child: Container(
                            height: 4.h,
                            margin: EdgeInsets.only(left: 3.w, top: 1.h),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 8,
                            ),
                            decoration: BoxDecoration(
                              color: darkGrey.withOpacity(.3),
                              borderRadius: const BorderRadius.all(
                                  Radius.circular(15)),
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  post[0]['is_liked'] == 1 ? FontAwesomeIcons.solidThumbsUp : FontAwesomeIcons.thumbsUp,
                                  color: post[0]['is_liked'] == 1 ? red : black,
                                  size: 18.sp,
                                ),
                                SizedBox(width: 1.w,),
                                Text("${post[0]['likesCount']}", style: TextStyle(fontSize: 16.sp),),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          height: 4.h,
                          margin: EdgeInsets.only(left: 3.w, top: 1.h),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                          ),
                          decoration: BoxDecoration(
                            color: darkGrey.withOpacity(.3),
                            borderRadius: const BorderRadius.all(
                                Radius.circular(15)),
                          ),
                          child: Row(
                            children: [
                              Text("${post[0]['category_title']}", style: TextStyle(fontSize: 16.sp, color: landingBackground, fontFamily: 'Cairo', fontWeight: FontWeight.bold),),
                              SizedBox(width: 1.w,),
                              Icon(
                                FontAwesomeIcons.tag,
                                color: landingBackground,
                                size: 17.sp,
                              ),
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: (){
                            cont.likePost(post[0]['id']);
                            if(post[0]['is_liked'] == 1){
                              post[0]['is_liked'] = 0;
                              post[0]['likesCount'] = post[0]['likesCount']-1;
                            } else {
                              post[0]['is_liked'] = 1;
                              post[0]['likesCount'] = post[0]['likesCount']+1;
                            }
                            cont.update();
                          },
                          child: Container(
                            height: 4.h,
                            margin: EdgeInsets.only(left: 3.w, top: 1.h),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 8,
                            ),
                            decoration: BoxDecoration(
                              color: darkGrey.withOpacity(.3),
                              borderRadius: const BorderRadius.all(
                                  Radius.circular(15)),
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  FontAwesomeIcons.eye,
                                  color: landingBackground,
                                  size: 18.sp,
                                ),
                                SizedBox(width: 1.5.w,),
                                Text("${post[0]['views']}", style: TextStyle(fontSize: 16.sp, color: landingBackground,),),
                              ],
                            ),
                          ),
                        ),
                        const Spacer(),
                        Container(
                          height: 4.h,
                          margin: EdgeInsets.only(right: 3.w, top: 1.h),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                          ),
                          decoration: BoxDecoration(
                            color: darkGrey.withOpacity(.3),
                            borderRadius: const BorderRadius.all(
                                Radius.circular(15)),
                          ),
                          child: Row(
                            children: [
                              Text("${post[0]['user_name']}", style: TextStyle(fontSize: 16.sp, color: landingBackground, fontFamily: 'Cairo', fontWeight: FontWeight.bold),),
                              SizedBox(width: 1.w,),
                              Icon(
                                FontAwesomeIcons.userTag,
                                color: landingBackground,
                                size: 16.sp,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 1.h,),
                    const Divider(thickness: 2, color: darkGrey, indent: 20, endIndent: 20,),
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.only(
                            left: 3.w,
                            right: 3.w,
                            top: 1.h,
                          ),
                          width: 100.w,
                          child: Text(
                              post[0]['title'],
                              textAlign: post[0]['lang'] == "ar" ? TextAlign.right : TextAlign.left,
                              style: TextStyle(
                                  color: black,
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Cairo'
                              )
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Container(
                          width: 100.w,
                          padding: EdgeInsets.symmetric(
                            horizontal: 3.w,
                          ),
                          child: Text(
                              post[0]['content'],
                              textAlign: post[0]['lang'] == "ar" ? TextAlign.right : TextAlign.left,
                              style: TextStyle(
                                  color: black,
                                  fontSize: 17.sp,
                                  fontFamily: 'Cairo'
                              )
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      }
      return Container(
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
      );
    });
  }
}
